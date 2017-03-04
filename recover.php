<?php

     session_start();

     require("include/dbms.inc.php");
     require("include/system.inc.php");
     require("include/template2.inc.php");
     require("include/auth.inc.php");
     require("include/PHPMailer/PHPMailerAutoload.php");


     $main = new Template("skins/gaia/dtml/frame_public.html");
     $body = new Template("skins/gaia/dtml/contact.html");

     if(!isset($_GET['email'])){
         $_SESSION['msg']="KO";
         Header("location: index.php");
         exit;
     }
             $db->sanitize();

             //genero nuova password random
             $temp_psw=$system->generateRandomString();
             //ne calcolo l'md5
             $md5=md5($temp_psw);

             //recupero nome utente
             $db->query("SELECT name FROM user WHERE email='{$_GET['email']}'");
             $db->checkErrors("system","front");
             if($db->getNumRows()<1){
                 $db->OKgoBack("login",0,"error");
             }else{//preparo dati per la mail
                 $name=$db->getResult()[0]['name'];
                 //aggiorno la vecchia password con la nuova generata sopra
                 $db->query("UPDATE user SET password='{$md5}' WHERE email='{$_GET['email']}'");
                 $db->checkErrors("system","frontoffice");

                 $mail = new PHPMailer(); // create a new object
                 $mail->IsSMTP(); // enable SMTP
                 $mail->SMTPDebug = 0; // debugging: 1 = errors and messages, 2 = messages only
                 $mail->SMTPAuth = true; // authentication enabled
                 $mail->SMTPSecure = 'ssl'; // secure transfer enabled REQUIRED for Gmail
                 $mail->Host = "smtp.gmail.com";
                 $mail->Port = 465; // or 587
                 $mail->IsHTML(true);
                 $mail->Username = "";
                 $mail->Password = "";
                 $mail->Sender="";
                 $mail->setFrom("","TRC - Password Recovering");
                 $mail->Subject = "Password Recovery";
                 $mail->Body = "<p>Hi <strong>{$name}</strong>, this is your new temporary password:
                                <strong>{$temp_psw}</strong></p>
                                <p>Please log in and change it as soon as possible through you account page.</p>
                        
                                <p style='color:silver; margin-top:25px;'>This is an automatically generated email, 
                                please <strong>DO NOT REPLY.</strong></p>";

                 $mail->AddAddress($_GET['email']);

                 //invio mail
                 if(!$mail->Send()) {
                     Header("location:error.php?error=system");
                     exit;
                 }

                 $db->OKgoBack("login",0,"OK-recover");
             }







     $system->commonOps();
     $main->setContent("body", $body->get());
     $main->setContent("message", $_SESSION['msg']);
     $main->close();
     $_SESSION['msg']="";
     
    
?>


