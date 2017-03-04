<?php

     session_start();

     require("include/dbms.inc.php");
     require("include/system.inc.php");
     require("include/template2.inc.php");
     require("include/auth.inc.php");
     
     $main = new Template("skins/gaia/dtml/frame_public.html");
     $body = new Template("skins/gaia/dtml/page.html");



     if(isset($_REQUEST['item'])){
         if($_REQUEST['item']=="21"){//se sono nella pagina di "About Us"
             $main->setContent("about_active","active");//attivo l'item sul menù orizzontale
         }
         //recupero dati della pagina con l'id dato
         $db->query("SELECT title, subtitle, body FROM textpage WHERE id={$_REQUEST['item']}");
         if($db->getNumRows()<1){//se non ho risultati
             $_SESSION['msg']="empty";
             Header("location: index.php");
             exit;
         }
         $data=$db->getResult();
         //setcontent
         foreach($data as $line){
             $body->setContent($line);
         }
     }else{
         $_SESSION['msg']="KO";
         Header("location: error.php?error=no_results");
         exit;
     }



     $system->commonOps();
     $main->setContent("body", $body->get());
     $main->close();
     
    
?>


