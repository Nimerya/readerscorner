<?php
     session_start();

     require("include/dbms.inc.php");
     require("include/system.inc.php");
     require("include/template2.inc.php");
     require("include/auth.inc.php");

     $main = new Template("skins/gaia/dtml/frame_public.html");
     $body = new Template("skins/gaia/dtml/account.html");

     $psize=$system->getPsize();
     $number=0;
     $totentry=0;

     $userid=$auth->isLogged();

    /*
     * Controlla se l'utente che chiede di accedere al proprio account è effettivamente loggato:
     * se no, reindirizza alla home dell'e-commerce(index.php), altrimenti procede.
    */
     if(!isset($userid)){
         $_SESSION['msg']="KO-not-logged";
         Header("location: /readerscorner/index.php");
         exit;
     }

    //Recupera e mostra tutti i dati dell'utente loggato
     $db->query("SELECT * FROM user WHERE id = {$userid}");
     $userdata=$db->getResult();

     foreach($userdata as $data){
         $body->setContent($data);
     }

    /*
     * Viene lanciata, tramite la funzione search (vedi libreria system) la query di
     * recupero degli indirizzi dell'utente, la quale oltre a tornare i risultati
     * ottenuti dalla query, restituisce informazioni necessarie per un'eventuale
     * impaginazione.
    */
     $res=$system->search("SELECT country, zip_code, address, city, region, id AS idaddr 
                           FROM address 
                           WHERE id_user={$userid}");
     $addresses=$res[1];
     $totentry=$res[0];
     $number=$res[2];


    /*
     * Se non vi sono indirizzi legati all'utente, allora viene mostrato un messaggio
     * di assenza di indirizzi, altrimenti vengono mostrati tutti gli indirizzi con
     * relativa impaginazione.
     */
     if($number <= 0){
         $body->setContent("hideAddresses","display:none;");
         $body->setContent("showWarning","display:block;");

     }else{
         foreach($addresses as $address){
             $body->setContent($address);
         }
     }



     //Impaginazione
     $body->setContent("psize_a", $system->psize_admin);
     $body->setContent("number", $totentry);

     //CommonOps esegue operazioni comuni a tutte le pagine (vedi libreria system)
     $system->commonOps();

     //Settaggio di eventuali messaggi
     $main->setContent("body", $body->get());
     $main->setContent("message", $_SESSION['msg']);
     $main->close();
     $_SESSION['msg']="";
?>