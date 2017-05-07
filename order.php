<?php
     session_start();

     require("include/dbms.inc.php");
     require("include/system.inc.php");
     require("include/template2.inc.php");
     require("include/auth.inc.php");

     $main = new Template("skins/gaia/dtml/frame_public.html");

     //controllo che l'user sia loggato
     $userid=$auth->isLogged();


    if(!isset($userid)){
         $_SESSION['msg']="KO-not-logged";
         Header("location: /readerscorner/index.php");
         exit;
     }

    //se non c'è un id ordine mostro il riepilogo di tutti gli ordini effettuati dall'user loggato
    if(!isset($_GET['id'])){
             $body = new Template("skins/gaia/dtml/order.html");
             $body->setContent("name",$_SESSION['auth']['name']);

             //recupero dati ordini
             $res=$system->search("SELECT * FROM purchase WHERE id_user={$userid}");
             $orders=$res[1];
             $totentry=$res[0];
             $number=$res[2];

             //se non ci sono ordini
             if($number <= 0){
                 $body->setContent("hideOrders","display:none;");
                 $body->setContent("showWarning","display:block;");
             }else{//se ci sono ordini
                 $i=0;
                 foreach($orders as $order){
                     if($i%2==0){//coloro le riche in modo alternato
                         $body->setContent("coloredRow","background: #ecebdf");
                     }else{
                         $body->setContent("coloredRow","");
                     }
                     $i++;
                     //se l'ordine è in uno stato diverso da "In preparation", non ne permetto l'annullamento
                     if(!($order['status']=="In preparation" || $order['status']=="in preparation")){
                         $body->setContent("hideCancel","display:none;");
                     }else{//ne permetto l'annullamento
                         $body->setContent("hideCancel","");
                     }
                     $order['total']=number_format($order['total'],2);
                     $body->setContent($order);
                 }
             }
     }else{//qui ho l'id di un ordine
        if ($_GET['mode'] == "cancel") { //cancellazione ordine
            //se chi invoca la pagina ha permesso su purchase.php nel backoffice

            if($auth->checkPermission("purchase.php")){
                $db->query("SELECT bookpurchase.isbn13 AS isbn13, 
                                   bookpurchase.amount AS amount 
                            FROM bookpurchase LEFT JOIN purchase ON bookpurchase.id_purchase=purchase.id 
                            WHERE bookpurchase.id_purchase={$_GET['id']}
                            AND (purchase.status='In preparation' OR purchase.status='in preparation')");
            }else{
                //se invece è un altro user controllo che l'ordine sia il suo
                $db->query("SELECT bookpurchase.isbn13 AS isbn13, 
                                   bookpurchase.amount AS amount 
                            FROM bookpurchase LEFT JOIN purchase ON bookpurchase.id_purchase=purchase.id 
                            WHERE bookpurchase.id_purchase={$_GET['id']} 
                            AND purchase.id_user={$userid}
                            AND (purchase.status='In preparation' OR purchase.status='in preparation')");
            }

            //recupero dati dell'ordine
            $data = $db->getResult();

            if($db->getNumRows()<1){ //se non trovo l'ordine

                //se è settato return significa che questo pezzo di script è stato invocato da una pagina esterna
                //nel dettaglio la pagina purchase.php del backoffice
                //quindi su errore torno lì
                if(isset($_GET['return'])){
                    $_SESSION['msg']="KO";
                    Header("location: /readerscorner/admin/purchase.php");
                    exit;
                }
                //altrimenti torno a order.php (ovvero l'annullamento è stato richiesto dall'utente
                //dal suo account
                $_SESSION['msg']="KO-order-canc";
                Header("location: order.php");
                exit;
            }//l'id è corretto: è un ordine esistente e ha come stato "In preparation"
            foreach ($data as $item) {//annullo l'ordine, quindi ripristino le availability dei libri coinvolti
                $db->query("UPDATE book 
                            SET availability=availability + {$item['amount']} 
                            WHERE book.isbn13={$item['isbn13']}");
                $db->checkErrors("system", "frontoffice", "/readerscorner/order.php");
            }
            //aggiorno lo stato dell'ordine
            if($auth->checkPermission("purchase.php")){
                $db->query("UPDATE purchase 
                        SET status='Canceled' 
                        WHERE purchase.id={$_GET['id']} 
                        AND purchase.status='In preparation'");
                $db->checkErrors("system", "frontoffice", "/readerscorner/order.php");
            }else{
                $db->query("UPDATE purchase 
                        SET status='Canceled' 
                        WHERE purchase.id={$_GET['id']} 
                        AND purchase.id_user={$userid} 
                        AND purchase.status='In preparation'");
                $db->checkErrors("system", "frontoffice", "/readerscorner/order.php");
            }


            //come sopra
            if(isset($_GET['return'])){
                $_SESSION['msg']="OK";
                Header("location: /readerscorner/admin/purchase.php");
                exit;
            }
            $_SESSION['msg']="OK-order-canc";
            Header("location: order.php");
            exit;

        } else { //report singolo ordine

            $body = new Template("skins/gaia/dtml/final_report.html");

            $body->setContent("addressText", "Address:");
            $body->setContent("paymentText", "Card Data:");
            $body->setContent("hideButtons", "display:none;");

            $body->setContent("name", $_SESSION['auth']['name']);
            $body->setContent("surname", $_SESSION['auth']['surname']);

            //recupero dati dell'ordine
            $db->query("SELECT address, 
                               purchase.total AS total, 
                               country, 
                               region, 
                               city, 
                               zip_code, 
                               card_number AS number, 
                               card_expire, 
                               card_owner AS owner 
                               FROM address 
                               LEFT JOIN purchase ON purchase.id_address = address.id 
                               WHERE purchase.id={$_GET['id']} AND purchase.id_user={$userid}");
            $data = $db->getResult()[0];

            //formatto dati carta
            $pieces = explode("/", $data['card_expire']);

            $data['expire_month'] = $pieces[0];
            $data['expire_year'] = $pieces[1];

            $body->setContent($data);

            //recupero dati di tutti i libri appartenenti all'ordine
            $db->query("SELECT book.id AS idbook, 
                               bookpurchase.title AS title, 
                               bookpurchase.isbn13 AS isbn13, 
                               bookpurchase.price AS final_price, 
                               amount 
                               FROM bookpurchase LEFT JOIN book ON book.isbn13 = bookpurchase.isbn13 
                               WHERE bookpurchase.id_purchase={$_GET['id']}");

            $books=$db->getResult();
            $i=0;
            //setcontent
            foreach($books as $book){
                if($i%2 == 0){//coloro le riche della tabella di report
                    $body->setContent("coloredRow", "background: #ecebdf");
                }else{
                    $body->setContent("coloredRow", "");
                }
                $i++;
                $body->setContent($book);
            }

            //riciclando la template di report (ultimo step purchase) devo nascondere le colonne che non uso
            $body->setContent("hideColumn1","display:none;");
            $body->setContent("hideColumn2","display:none;");
            $body->setContent("hideColumn3","display:none;");
            $body->setContent("hideColumn4","display:none;");

            }
        }

     $system->commonOps();
     $main->setContent("body", $body->get());
     $main->setContent("message", $_SESSION['msg']);
     $main->close();
     $_SESSION['msg']="";
?>