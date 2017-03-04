<?php

    session_start();

     require("include/dbms.inc.php");
     require("include/system.inc.php");
     require("include/template2.inc.php");
     require("include/auth.inc.php");
     
     $main = new Template("skins/nevia/dtml/frame-public.html");
     $body = new Template("skins/nevia/dtml/category_add2.html");
     
     if (!isset($_REQUEST['page'])) {
         $_REQUEST['page'] = 0;
     }
     
     switch($_REQUEST['page']) {
         case 0: // emit form
             break;
         case 1: // transaction
            
             $db->sanitize();
             if ($_POST['position'] == "") {
                 $_POST['position'] = 0;
             }

             $db->query("INSERT INTO {$system->getTable()} VALUES (NULL,{$_POST['position']},'{$_POST['name']}','{$_POST['description']}')");             
             
             $body->setContent("message", ($db->isError()? "KO":"OK"));
             
             break;   
     }
     
     
     $main->setContent("body", $body->get());
     $main->close();
    
?>


