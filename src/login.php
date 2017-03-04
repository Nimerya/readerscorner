<?php

     session_start();
    
     require("include/dbms.inc.php");
     require("include/system.inc.php");
     require("include/template2.inc.php");
     require("include/auth.inc.php");
      
     $main = new Template("skins/gaia/dtml/frame_public.html");
     $body = new Template("skins/gaia/dtml/login.html");


     if (!isset($_REQUEST['page'])) {
         $_REQUEST['page'] = 0;
     }

     switch($_REQUEST['page']) {
         case 0: // emit form

             break;
         case 1: // transaction
             $auth->Login();

             $_SESSION['msg']="OK-login";
             Header("Location: index.php");
             exit;
             break;
     }
     $system->commonOps();
     $main->setContent("body", $body->get());
     $main->setContent("message", $_SESSION['msg']);
     $main->close();
     $_SESSION['msg']="";
     
    
?>