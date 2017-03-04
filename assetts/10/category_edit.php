<?php

    session_start();
     require("include/dbms.inc.php");
     require("include/system.inc.php");
     require("include/template2.inc.php");
     require("include/auth.inc.php");
     
     $main = new Template("skins/nevia/dtml/frame-public.html");
     
     
     if (!isset($_REQUEST['page'])) {
         $_REQUEST['page'] = 0;
     }
     
     switch($_REQUEST['page']) {
         case 0: // emit report
             
             // $body = new Template("skins/nevia/dtml/category_edit-report.html");
             $body = new Template("skins/nevia/dtml/category_edit-report2.html");
             
             $db->query("SELECT * FROM category");
             
             if (!$db->isError()) {
                 
                 $data = $db->getResult();
                               
                 foreach($data as $line) {

                    
                     $body->setContent($line);
 
                     /*
                      
                    foreach($line as $key => $element) {
                        $body->setContent($key, $element);
                    }  
                    */
                 }
             }
             
             break;
             
         case 1: // emit precharged form
             $body = new Template("skins/nevia/dtml/category_edit.html");
             
             $db->query("SELECT * FROM category WHERE id = {$_GET['id']}");
             
             if (!$db->isError()) {
                 $data = $db->getResult();
                 
                 foreach($data[0] as $key => $value) {
                     $body->setContent($key,$value);
                 }
             }
             
             
             break;
         case 2: // transaction
             $body = new Template("skins/nevia/dtml/category_edit.html");
             
             $db->sanitize();
             if ($_POST['position'] == "") {
                 $_POST['position'] = 0;
             }

             $db->query("UPDATE category 
                        SET name = '{$_POST['name']}', 
                          position = {$_POST['position']}, 
                          description = '{$_POST['description']}'
                         WHERE id = {$_POST['id']}");
             
             if (!$db->isError()) {
                 foreach($_POST as $key => $value) {
                     $body->setContent($key,$value);
                 }
             }
             
             $body->setContent("message", ($db->isError()? "KO":"OK"));
             
             break;   
     }
     
     
     $main->setContent("body", $body->get());
     $main->close();
    
?>


