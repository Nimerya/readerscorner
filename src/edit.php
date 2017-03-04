<?php

     session_start();
    
     require("include/dbms.inc.php");
     require("include/system.inc.php");
     require("include/template2.inc.php");
     require("include/auth.inc.php");
      
     $main = new Template("skins/gaia/dtml/frame_public.html");

     $userid=$auth->isLogged();

     $db->sanitize();


        if(!isset($userid)){
            $_SESSION['msg']="KO-not-logged";
            Header("location: /readerscorner/index.php");
            exit;
        }

     switch($_REQUEST['mode']) {
         case "add": //add address

             switch($_REQUEST['page']){
                 case 0: //emit form aggiunta indirizzo
                     $body=new Template ("skins/gaia/dtml/add_adr.html");
                     $body->setContent("what","an address");
                     $body->setContent("mode",$_REQUEST['mode']);
                     break;

                 case 1: //transaction aggiunta indirizzo
                     $db->sanitize();
                     $db->query("INSERT INTO address 
                                 VALUES(NULL, {$userid}, 
                                             '{$_POST['country']}', 
                                             '{$_POST['region']}', 
                                             '{$_POST['city']}', 
                                             '{$_POST['zip_code']}', 
                                             '{$_POST['address']}')");
                     $db->checkErrors("delete", "frontoffice");
                     $db->OKgoBack("","","OK","account.php");
                     break;
             }
             break;

         case "del": //caso cancellazione indirizzo
             if(!isset($_REQUEST['idaddr'])){ //se non ho l'id dell'indirizzo
                 $_SESSION['msg']="KO";//errore, esco
                 Header("location: index.php");
                 exit;
             }

             //rimuovo l'indirizzo corrispondente all'id ricevuto
             //controllando che effettivamente appartenga all'user loggato
             $db->query("DELETE FROM address WHERE id={$_REQUEST['idaddr']} AND address.id_user={$userid}");
             $db->checkErrors("delete", "frontoffice");
             $db->OKgoBack("","","OK","account.php");

             break;

         case "edit": // caso modifica indirizzo/account

             switch($_REQUEST['what']){
                 case "adr"://caso modifica indirizzo

                     if(!isset($_REQUEST['idaddr'])){//se non ho l'id esco
                         $_SESSION['msg']="KO";
                         Header("location: index.php");
                         exit;
                     }

                     if($_REQUEST['page']==0){//emit form precompilato modifica indirizzo
                         $body=new Template ("skins/gaia/dtml/add_adr.html");
                         $body->setContent("what","address");
                         $body->setContent("mode",$_REQUEST['mode']);
                         $body->setContent("idaddr",$_REQUEST['idaddr']);

                         //recupero dati relativo all'indirizzo
                         $db->query("SELECT * 
                                     FROM address 
                                     WHERE id={$_REQUEST['idaddr']} 
                                     AND id_user={$userid}");

                         //se non ho risultati: errore, esco
                         if($db->getNumRows()<=0){
                             $_SESSION['msg']="KO";
                             Header("location: index.php");
                             exit;
                         }
                         $address=$db->getResult()[0];
                         $body->setContent($address);
                     }else{//controllo qui se sono al caso page=1-> transazione update

                         //transazione update
                         $db->query("UPDATE address SET country='{$_POST['country']}', 
                                                        region='{$_POST['region']}',
                                                        city='{$_POST['city']}', 
                                                        zip_code='{$_POST['zip_code']}',
                                                        address='{$_POST['address']}'
                                     WHERE id={$_POST['idaddr']} AND id_user={$userid}");
                         $db->checkErrors("update", "frontoffice");
                         $db->OKgoBack("","","OK","account.php");
                     }

                     break;
                 case "acc"://caso edit account
                     if($_REQUEST['page']==0){//emit form modifica account
                         $body=new Template ("skins/gaia/dtml/signup.html");
                         $body->setContent("what","address");
                         $body->setContent("hideTerms","display:none;");
                         $body->setContent("hidePassword","display:none;");
                         $body->setContent("mode",$_REQUEST['mode']);
                         $body->setContent("action","edit");
                         $body->setContent("additionalPars","?mode=edit&what=acc");

                         //precarico form
                         $db->query("SELECT * FROM user WHERE id={$userid}");
                         $data=$db->getResult()[0];
                         $body->setContent($data);
                         $body->setContent("hideTerms","display:none;");
                     }else{//transazione
                         $db->query("UPDATE user SET name='{$_POST['name']}', 
                                                        surname='{$_POST['surname']}',
                                                        email='{$_POST['email']}', 
                                                        telephone='{$_POST['telephone']}',
                                                        birth_day='{$_POST['birthday']}'
                                                        WHERE id={$userid}");
                         $db->checkErrors("update");
                         $db->OKgoBack("","","OK","account.php");
                     }

                     break;
                 case "psw"://caso edit password
                     if($_REQUEST['page']==0){//emit form
                         $body=new Template ("skins/gaia/dtml/psw.html");
                     }else{//transazione
                         $old=MD5($_POST['password']);//calcolo md5

                         //se la vecchia password inserita == password utente
                         if($old==$_SESSION['auth']['password']){
                             //procedo con la transazione
                             $pass=MD5($_POST['newpassword']);

                             $db->query("UPDATE user 
                                         SET password='{$pass}' 
                                         WHERE id={$userid}");
                             $db->checkErrors("update");
                             $db->OKgoBack("","","OK","account.php");
                         }else{//controllo quì se la vecchia password è sbagliata
                             $_SESSION['msg']="KO-bad-old-psw";
                             Header("location: edit.php?mode=edit&what=psw");
                             exit;
                         }
                     }
                     break;

                 default:
                     $_SESSION['msg']="KO";
                     Header("location: index.php");
                     exit;
                     break;


             }
             break;

         default:
             $_SESSION['msg']="KO";
             Header("location: index.php");
             exit;
     }
     $system->commonOps();
     $main->setContent("body", $body->get());
     $main->setContent("message", $_SESSION['msg']);
     $main->close();
     $_SESSION['msg']="";
     
    
?>