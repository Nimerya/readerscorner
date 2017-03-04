<?php

    session_start();

     require("include/dbms.inc.php");
     require("include/system.inc.php");
     require("include/template2.inc.php");
     require("include/auth.inc.php");
     
     $main = new Template("skins/nevia/dtml/frame-public.html");
     $body = new Template("skins/nevia/dtml/user_add.html");
     
     if (!isset($_REQUEST['page'])) {
         $_REQUEST['page'] = 0;
     }
     
     switch($_REQUEST['page']) {
         case 0: // emit form
             
             $db->query("SELECT id AS group_id, name AS group_name FROM groups");
             $data = $db->getResult();
             
             foreach($data as $group) {
                $body->setContent($group);
             }             
             
             break;
         case 1: // transaction
            
             
             foreach($_POST as $key => $value) {
                 echo "{$key}: {$value}<br>";
             }
             exit;
             break;   
     }
     
     
     $main->setContent("body", $body->get());
     $main->close();
    
?>


