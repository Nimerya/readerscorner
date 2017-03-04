<?php

     session_start();
    
     require("include/dbms.inc.php");
     require("include/system.inc.php");
     require("include/template2.inc.php");
     require("include/auth.inc.php");
      
     $main = new Template("skins/gaia/dtml/frame_public.html");
     $body = new Template("skins/gaia/dtml/signup.html");


    switch($_REQUEST['page']) {
         case 0: // emit form signup
             $body->setContent("action","signup");
             $body->setContent("requiredTerms","required");
             $body->setContent("requiredPassword","required");
             break;
         case 1: // transaction
             $db->sanitize();


             //check che l'email sia effettivamente una mail,
             //e che corrisponda alla mail di verifica, stessa cosa per la password

             if (!filter_var($_POST['email'], FILTER_VALIDATE_EMAIL) ||
                 $_POST['email']!=$_POST['email2'] || $_POST['password']!=$_POST['password2']) {
                $_SESSION['msg']="The email you inserted is not valid.";
                Header("location: signup.php");
                exit;
             }

             $pass=md5($_POST['password']);
             //transazione
             $db->query("INSERT INTO user 
                              VALUES(NULL, 
                                    '{$_POST['name']}', 
                                    '{$_POST['surname']}', 
                                    '{$_POST['email']}', 
                                    '{$pass}',
                                    '{$_POST['telephone']}',
                                    '{$_POST['birthday']}')");
             $db->checkErrors("insert", "frontoffice");
             $db->OKgoBack("login",0,"OK-signup");
             break;
     }
     $system->commonOps();
     $main->setContent("body", $body->get());
     $main->setContent("message", $_SESSION['msg']);
     $main->close();
     $_SESSION['msg']="";
     
    
?>