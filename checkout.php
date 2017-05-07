<?php
     session_start();

     require("include/dbms.inc.php");
     require("include/system.inc.php");
     require("include/template2.inc.php");
     require("include/auth.inc.php");



     $main = new Template("skins/gaia/dtml/frame_public.html");

     $db->sanitize();


     $psize=$system->getPsize();
     $number=0;
     $totentry=0;

     $userid=$auth->isLogged();

     if(!isset($_REQUEST['step'])){
         $_REQUEST['step']=0;
     }

     if(!isset($userid)){
         $_SESSION['msg']="KO-not-logged";
         Header("location: {$_REQUEST['return']}");
         exit;
     }

     switch($_REQUEST['step']){
         case 0://step 0: visualizzo elenco indirizzi
             $_SESSION['auth']['address']="";
             $_SESSION['auth']['card']="";
             $_SESSION['auth']['checkout']="";

             //se non ci sono elementi nel carrello
             $db->query("SELECT COUNT(*) AS count FROM cart WHERE id_user={$userid}");
             if($db->getResult()[0]['count']<1){//esco
                 $_SESSION['msg']="Your cart is empty.";
                 Header("location: cart.php?mode=show&where=cart");
                 exit;
             }

             //controllo quì se ho almeno un elemento nel carrello
             $body = new Template("skins/gaia/dtml/report_adr.html");
             //recupero gli indirizzi dell'utente e li impagino
             $res=$system->search("SELECT country, 
                                          zip_code, 
                                          address, 
                                          city, 
                                          region, 
                                          id AS idaddr 
                                          FROM address 
                                          WHERE id_user={$userid}");
             $addresses=$res[1];
             $totentry=$res[0];
             $number=$res[2];

             //se non ci sono indirizzi, monstro messaggio informativo e ne chiedo l'aggiunta
             if($number <= 0){
                 $body->setContent("hideAddresses","display:none;");
                 $body->setContent("showWarning","display:block;");

             }else{//altrimenti (ho almeno 1 indirizzo)
                 foreach($addresses as $address){
                     $body->setContent($address);
                 }
             }
             break;
         case 1://step 1: inserimento dati carta
             if(!isset($_REQUEST['idaddr'])){//se sono arrivato quì e non ho l'indirizzo esco
                 $_SESSION['msg']="KO";
                 Header("location: cart.php?mode=show&where=cart");
                 exit;
             }
             //recupero i dati dell'indirizzo scelto in precedenza
             $db->query("SELECT * 
                         FROM address 
                         WHERE id={$_REQUEST['idaddr']} 
                         AND id_user={$userid}");
             $db->checkErrors("system","frontoffice","/readerscorner/cart.php?mode=show&where=cart");
             if($db->getNumRows()!=1){ //errore, esco
                 $_SESSION['msg']="KO";
                 Header("location: cart.php?mode=show&where=cart");
                 exit;
             }else{//qui siamo sicuri di avere idaddr e che l'indirizzo appartenga effettivamente all'utente loggato
                   //metto l'indirizzo scelto in session per usarlo dopo
                 $_SESSION['auth']['address']=$db->getResult()[0];
             }

             //emit form inserimento dati carta
             $body = new Template("skins/gaia/dtml/form_card.html");
             break;

         case 2://step 2: report finale

             //controllo approfondito sui dati relativi alla carta inseriti nello step 1
             if($_POST['number']=="" || !isset($_POST['number']) ||
                preg_match("/^[0-9]{13,16}$/",$_POST['number']) !== 1 ||
                $_POST['owner']=="" || !isset($_POST['owner']) ||
                $_POST['ccv']=="" || !isset($_POST['ccv']) || preg_match("/^[0-9]{3}$/",$_POST['ccv']) !== 1 ||
                $_POST['expire_month']=="" || !isset($_POST['expire_month']) || $_POST['expire_month']<1 ||
                $_POST['expire_month'] >12 || $_POST['expire_year']=="" || !isset($_POST['expire_year']) ||
                $_POST['expire_year'] < date("Y") ||
                ($_POST['expire_year'] == date("Y") && $_POST['expire_month'] < date("n"))) {
                     $_SESSION['msg']="KO-wrong-card-data";//se qualcosa va male esco
                     Header("location: cart.php?mode=show&where=cart");
                     exit;
             }

             //strutturo i dati della carta
             $temp=array("number" => $_POST['number'],
                         "owner" => $_POST['owner'],
                         "ccv" => $_POST['ccv'],
                         "expire_month" => $_POST['expire_month'],
                         "expire_year" => $_POST['expire_year']
                        );

             //li metto in sessione per usarli dopo
             $_SESSION['auth']['card']=$temp;

             //emetto report
             $body=new Template("skins/gaia/dtml/final_report.html");

             //setcontent dati relativi a tutti i dettagli dell'ordine (indirizzo, carta...)
             $body->setContent("paymentText","The payment will be made through the following card:");
             $body->setContent("addressText","The products will be delivered to:");
             $body->setContent("name",$_SESSION['auth']['name']);
             $body->setContent("surname",$_SESSION['auth']['surname']);
             $body->setContent($_SESSION['auth']['address']);
             $body->setContent($_SESSION['auth']['card']);

             //recupero elenco libri nel carrello con eventuali sconti
             $db->query("SELECT book.id AS idbook ,
                                title, isbn13, 
                                amount, 
                                price AS originalPrice, 
                                discount, end 
                                FROM cart 
                                LEFT JOIN book ON cart.id_book = book.id
                                LEFT JOIN promotion ON book.id_promotion = promotion.id
                                WHERE cart.id_user={$userid}");
             $db->checkErrors("system","frontoffice");
             $data=$db->getResult();
             if($db->getNumRows()<1){//carrello vuoto (improbabile a questo punto) errore, esco
                 $_SESSION['msg']="KO";
                 Header("location: cart.php?mode=show&where=cart");
                 exit;
             }
             //salvo i dati dei prodotti nel carrelllo in sessione per usarli dopo
             $_SESSION['auth']['checkout']=$data;

             $tot=0;
             $newprice=0;
             $i=0;

             foreach ($data as $product){
                 if($i%2 == 0){//serve per colorare una riga si e una no della tabella di report
                     $body->setContent("coloredRow", "background: #ecebdf");
                 }else{
                     $body->setContent("coloredRow", "");
                 }

                 //controllo che l'eventuale promozione legata al libro sia ancora attiva
                 $date1=strtotime($product['end']);
                 $date2=strtotime(date("Y-m-d"));
                 $secs= $date2 - $date1;
                 $days=$secs/86400;

                 if($days>=0){//se la promozione è scaduta
                     unset($product['discount']); //rimuovila dal calcolo del prezzo finale
                 }
                 //calcolo prezzo scontato
                 $newprice=number_format(($product['originalPrice']-($product['originalPrice']*$product['discount'])/100)*$product['amount'],2 ,".","");
                 $_SESSION['auth']['checkout'][$i]['price']=$newprice; //aggiorno il prezzo in sessione
                 $body->setContent("final_price",$newprice);
                 //calcolo totale parziale (prezzo unitario * quantità)
                 $product['originalPrice']*=$product['amount'];

                 //se c'è uno sconto lo visualizzo
                 if(isset($product['discount'])){
                     $product['discount']=$product['discount']."%";
                 }

                 $body->setContent($product);
                 //incremento totale complessivo
                 $tot+=$newprice;
                 $i++;
             }
             //visualizzo totale complessivo
             $_SESSION['auth']['total']=number_format($tot,2 ,".","");
             $body->setContent("total",number_format($tot,2 ,".",""));
             break;


         case 3: //step 3: transazione finale

             $errorbookid=0;

             try {
                 //inizio transazione
                 $db->beginTransaction();

                 ////////////////////////////////////////////
                 ///// ipotetica transazione monetaria //////
                 ////////////////////////////////////////////

                 $tempids=array();

                 //scorro i libri che stanno per essere acquistati
                 foreach ($_SESSION['auth']['checkout'] as $item){
                     //sanitize del title
                     $title2=addslashes($item['title']);

                     //check disponibilità singolo libro
                     $db->query("SELECT availability 
                                 FROM book 
                                 WHERE id={$item['idbook']} 
                                 AND availability >= {$item['amount']}");
                     //se non c'è disponibilità sufficiente mi segno il libro che causa l'errore e lancio eccezione
                     if($db->getNumRows()!=1){
                         $errorbookid=$item['idbook'];

                         throw new Exception("00 There was a problem with the book's availability, 
                         {$title2} is sold out and it has been removed from your cart.");
                     }
                     //salvo la disponibilità "vecchia" precedente all'acquisto
                     $availability=$db->getResult()[0]['availability'];
                     //calcolo nuova disponibilità
                     $new_availability=$availability-$item['amount'];

                     //aggiorno disponibilità nel database
                     $db->query("UPDATE book 
                                 SET availability = {$new_availability} 
                                 WHERE book.id={$item['idbook']}");
                     if($db->isError()){ //se c'è un errore lancio eccezione
                         throw new Exception("01 There was a problem during the checkout.");
                     }

                     //inserisco tupla in bookpurchase
                     $db->query("INSERT INTO bookpurchase VALUES(NULL, 
                                                                 NULL,
                                                               '{$item['amount']}',
                                                               '{$item['price']}',
                                                               '{$item['isbn13']}',
                                                               '{$title2}')");
                     if($db->isError()){//se c'è un errore lancio eccezione
                         throw new Exception("02 There was a problem during the checkout.");
                     }

                     //recupero l'id della tupla appena inserita in bookpurchase
                     $db->query("SELECT LAST_INSERT_ID() as tempid;");
                     $lastid=$db->getResult()[0]['tempid'];
                     if(!isset($lastid)){//se c'è un errore lancio eccezione
                         throw new Exception("03 There was a problem during the checkout.");
                     }
                     //conservo l'id della tupla in bookpurchase appena inserita,
                     //così poi andrò a legarle alla tupla che andrò ad inserire in purchase
                     $tempids[]=$lastid;
                 }

                 //recupero dati carta
                 $cardnumber=substr($_SESSION['auth']['card']['number'],-4);
                 $expire=$_SESSION['auth']['card']['expire_month']."/".$_SESSION['auth']['card']['expire_year'];

                 //inserisco tupla in purchase
                 $db->query("INSERT INTO purchase VALUES(NULL,
                                                        {$userid},
                                                        {$_SESSION['auth']['address']['id']},
                                                       '{$cardnumber}',
                                                       '{$expire}',
                                                       '{$_SESSION['auth']['card']['owner']}',
                                                       '{$_SESSION['auth']['total']}',
                                                       CURDATE(),
                                                       'In preparation')");
                 if($db->isError()){//se c'è un errore lancio eccezione
                     throw new Exception("04 There was a problem during the checkout.");
                 }

                 //recuper l'id della tupla appena inserita in purchase
                 $db->query("SELECT LAST_INSERT_ID() as tempid;");
                 $lastpurchaseid=$db->getResult()[0]['tempid'];
                 if(!isset($lastpurchaseid)){//se c'è un errore lancio eccezione
                     throw new Exception("05 There was a problem during the checkout.");
                 }

                 //scorro gli id che ho precedentemente salvato (quelli di bookpurchase rimasti appesi)
                 foreach($tempids as $key=>$value){
                     //aggiorno id_purchase dentro ogni tupla di bookpurchase relativa a questo ordine
                     //così da legare ogni riga di bookpurchase a purchase
                     $db->query("UPDATE bookpurchase 
                                 SET id_purchase = {$lastpurchaseid} 
                                 WHERE id={$value}");
                     if($db->isError()){//se c'è un errore lancio eccezione
                         throw new Exception("06 There was a problem during the checkout.");
                     }
                 }
                 //acquisto ultimato
                 //svuoto il carrello
                 $db->query("DELETE FROM cart WHERE id_user={$userid}");
                 if($db->isError()){//se c'è un errore lancio eccezione
                     throw new Exception("07 There was a problem during the checkout.");
                 }

                 //commit di tutte le modifiche al db
                 $db->commit();

                 //torno alla pagina di riepilogo degli ordini
                 $_SESSION['msg']="OK-order";
                 Header("location: order.php");
                 exit;

             } catch (Exception $e) {
                 //se ho una qualsiasi eccezione
                 //rollback
                 $db->rollback();

                 //catturo dettagli dell'eccezione
                 $error=$e->getMessage();
                 $errorcode=substr($error,0,2);
                 $errortext=substr($error,2);

                 //se l'errorcode è 00 (ovvero quantità richiesta non sufficiente)
                 if($errorcode=="00"){
                     //elimino dal carrello dell'utente l'elemento che crea problemi
                     $db->query("DELETE FROM cart 
                                 WHERE id_book={$errorbookid} 
                                 AND id_user={$userid}");
                 }

                 //avverto l'utente del problema (qualunque esso sia)
                 $_SESSION['msg']=$errortext." (error #FFF".$errorcode.")";
                 Header('location: index.php');
                 exit;
             }

             break;

         default:
             $_SESSION['msg']="KO";
             Header("location: cart.php?mode=show&where=cart");
             exit;
     }

     $body->setContent("psize_a", $system->psize_admin);
     $body->setContent("number", $totentry);
     $system->commonOps();
     $main->setContent("body", $body->get());
     $main->setContent("message", $_SESSION['msg']);
     $main->close();
     $_SESSION['msg']="";
?>