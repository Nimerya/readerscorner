<?php
     session_start();

     require("include/dbms.inc.php");
     require("include/system.inc.php");
     require("include/template2.inc.php");
     require("include/auth.inc.php");

     $main = new Template("skins/gaia/dtml/frame_public.html");
     $body = new Template("skins/gaia/dtml/cart.html");

     //inizializzazione variabili necessarie per l'impaginazione
     $psize=$system->getPsize();
     $number=0;
     $totentry=0;

     $userid=$auth->isLogged();

     /*
      * Verifica se è settato l'indirizzo di return dove tornare una volta fatte tutte le
      * operazioni richieste. Se non lo è lo setta ad uno di default.
      */
     if(!isset($_REQUEST['return'])){
         $_REQUEST['return']="/readerscorner/cart.php?mode=show&where={$_REQUEST['where']}";
     }

     // Verifica che l'utente sia loggato
     if(!isset($userid)){
         $_SESSION['msg']="KO-not-logged";
         Header("location: {$_REQUEST['return']}");
         exit;
     }


     switch($_REQUEST['mode']){ //Controllo il valore di mode
         case "add": //modalità: aggiunta di un elemento nel carrello o nella wishlist

             if ($_REQUEST['id']<=0 || !isset($_REQUEST['id'])) {
                 $_SESSION['msg'] = "KO";
                 Header("location: {$_REQUEST['return']}");
                 exit;
             }

             switch($_REQUEST['where']){//Controllo il valore di where
                 case "cart": //aggiunta di un elemento nel carrello
                     if(!isset($_REQUEST['qty']) || $_REQUEST['qty']<=0){ //quantità assente o corrotta
                         $_SESSION['msg']="KO";
                         Header("location: {$_REQUEST['return']}"); //errore go back
                         exit;
                     }
                     //qui sono sicuro di avere la quantità, controllo disponibilità
                     $db->query("SELECT id 
                                 FROM book 
                                 WHERE id={$_REQUEST['id']} 
                                 AND availability>={$_REQUEST['qty']}");
                     if($db->getNumRows()!=1){ //disponibilità non sufficiente
                         $_SESSION['msg']="You are trying to buy too many copies.";
                         Header("location: {$_REQUEST['return']}");
                         exit;
                     }
                     //disponibilità sufficiente, aggiungo il prodotto nel carrello
                     $db->query("INSERT INTO cart 
                                 VALUES({$userid}, {$_REQUEST['id']}, {$_REQUEST['qty']})"); //transazione
                     $db->checkErrors("system","frontoffice",$_REQUEST['return']);
                     $db->OKgoBack("","","OK-add-cart",$_REQUEST['return']);
                     break;

                 case "wish": //aggiunta wishlist
                     //per la wishlist non ho bisogno della quantità, eseguo direttamente la transazione
                     $db->query("INSERT INTO wishlist 
                                 VALUES({$userid}, {$_REQUEST['id']})"); //transazione
                     $db->checkErrors("system","frontoffice",$_REQUEST['return']);
                     $db->OKgoBack("","","OK-add-wish",$_REQUEST['return']);
                     break;

                 default:
                     $_SESSION['msg']="KO";
                     Header("location: {$_REQUEST['return']}");
                     exit;
             }
             break;
         case "del"://caso eliminazione

             if ($_REQUEST['id']<=0 || !isset($_REQUEST['id'])) {//se non ho l'id o è corrotto esco
                 $_SESSION['msg'] = "KO";
                 Header("location: cart.php?mode=show&where={$_REQUEST['where']}");
                 exit;
             }

             switch($_REQUEST['where']) {
                 case "cart"://caso eliminazione da carrello
                     //transazione
                     $db->query("DELETE FROM cart 
                                 WHERE id_user={$userid} 
                                 AND id_book={$_REQUEST['id']}");
                     $db->checkErrors("system","frontoffice",$_REQUEST['return']);
                     $db->OKgoBack("","","OK","cart.php?mode=show&where={$_REQUEST['where']}");
                     break;
                 case "wish"://caso eliminazione da wishlist
                     //transazione
                     $db->query("DELETE FROM wishlist 
                                 WHERE id_user={$userid} 
                                 AND id_book={$_REQUEST['id']}");
                     $db->checkErrors("system","frontoffice",$_REQUEST['return']);
                     $db->OKgoBack("","","OK","cart.php?mode=show&where={$_REQUEST['where']}");
                     break;
             }
             break;
         case "show"://caso show: visualizzo elementi nel carrello/wishlist

             switch($_REQUEST['where']){
                 case "cart"://caso cart, imposto variabili
                             //per avere una visualizzazione corretta
                     $textwhere="Cart";
                     $table="cart";
                     $amount="show";
                     break;

                case "wish"://caso wishlist
                     $textwhere="Wishlist";
                     $table="wishlist";
                     $amount="hide";
                     break;
             }

             $body->setContent("name", $_SESSION['auth']['name']);
             $body->setContent("where", $textwhere);

             //seleziono dati relativi agli elementi nel carrello/wishlist
             $res=$system->search("SELECT book.id AS id, 
                                          book.cover AS cover, 
                                          book.price AS price, 
                                          book.title AS title, 
                                          book.id_promotion AS promotion 
                                          FROM book 
                                          LEFT JOIN {$table} ON book.id = {$table}.id_book
                                          LEFT JOIN user ON {$table}.id_user=user.id
                                          WHERE user.id={$userid}");
             $totentry=$res[0];
             $data=$res[1];
             $number=$res[2];

             //se ho risultati (carrello/wish non vuoto)
             if($number > 0){
                 $prom_array=[];
                 //recupero dati promozioni
                 $db->query("SELECT discount, book.id as id
                             FROM book 
                             LEFT JOIN promotion ON promotion.id=book.id_promotion 
                             WHERE promotion.end >= CURDATE()");
                 $prom_data=$db->getResult();

                 //genero array associativo [id libro]=>[valore promozione]
                 foreach($prom_data as $line){
                     $prom_array[$line['id']]=$line['discount'];
                 }

                 //setcontent elementi carrello/wish
                 foreach($data as $line){
                     if($prom_array[$line['id']]!=""){
                         $body->setContent("price",$line['price']);
                         $body->setContent("newprice", number_format(($line['price']-($line['price']*$prom_array[$line['id']])/100) ,2,".",""));
                         $body->setContent("discount", "-".$prom_array[$line['id']]."%");
                     }else{
                         $body->setContent("price","");
                         $body->setContent("newprice", $line['price']);
                         $body->setContent("discount", "");
                     }
                     if($amount=="show"){ //ovvero sto visualizzando il carrello
                         $db->query("SELECT amount 
                                     FROM cart 
                                     WHERE id_user={$userid} 
                                     AND id_book={$line['id']}");
                         $amountValue=$db->getResult()[0]['amount'];
                         $body->setContent("amount", "Amount: <b>".$amountValue."</b>");
                         //nascondo il button per aggiungere il prodotto nel carrello
                         $body->setContent("hideAddToCart","display:none;");
                     }

                     $body->setContent("title",$line['title']);
                     $body->setContent("cover",$line['cover']);
                     $body->setContent("id",$line['id']);

                 }
             }else{//controllo quì se non ho risultati
                 $body->setContent("hideProducts","display:none;");
                 $body->setContent("noresults","Your {$textwhere} is empty :(");
             }
             break;

         default:
             $_SESSION['msg']="KO";
             Header("location: {$_REQUEST['return']}");
             exit;

     }

     $body->setContent("psize_a", $system->psize_admin);
     $body->setContent("number", $totentry);
     $body->setContent("where2", $_REQUEST['where']);
     $body->setContent("where3", $_REQUEST['where']);
     $system->commonOps();
     $main->setContent("body", $body->get());
     $main->setContent("message", $_SESSION['msg']);
     $main->close();
     $_SESSION['msg']="";
?>