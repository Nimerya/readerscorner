<?php

     session_start();

     require("include/dbms.inc.php");
     require("include/system.inc.php");
     require("include/template2.inc.php");
     require("include/auth.inc.php");
     require("include/PHPMailer/PHPMailerAutoload.php");


     $main = new Template("skins/gaia/dtml/frame_public.html");
     $body = new Template("skins/gaia/dtml/contact.html");


     $main->setContent("contact_active","active");

     switch($_REQUEST['page']){
         case 0://emit form di contatto
             break;

         case 1://invio mail

             $db->sanitize(); //pulisco dati

             //imposto variabili necessarie all'invio delle mail
             $from    = $_POST['email'];
             $subject = $_POST['subject'];
             $message = wordwrap($_POST['message']);
             $name= $_POST['name'];


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
             $mail->setFrom($from,"TRC - Customer: ".$name);
             $mail->addReplyTo($from,$name);

             $mail->Subject = $subject;
             $mail->Body = $message;

             //recupero nome ed email di tutti gli utenti membri del gruppo "Customer Support"
             $db->query("SELECT email, 
                                user.name AS cname 
                         FROM groups 
                         LEFT JOIN usergroup ON groups.id=usergroup.id_group 
                         LEFT JOIN user ON usergroup.id_user = user.id 
                         WHERE groups.name='Customer Support'");
             $data=$db->getResult();
             $db->checkErrors("system","frontoffice");

             //per ogni utente in Customer Support
             foreach($data as $line){
                 $to=$line['email'];
                 $cname=$line['cname'];
                 $mail->AddAddress($to, $cname);
                 //viene inviata una mail
                 if(!$mail->Send()) {
                     Header("location:error.php?error=system");
                     exit;
                 }
             }
             $db->OKgoBack("contact",0,"OK-message");
             break;
     }
     $system->commonOps();
     $main->setContent("body", $body->get());
     $main->setContent("message", $_SESSION['msg']);
     $main->close();
     $_SESSION['msg']="";
     
    
?>


