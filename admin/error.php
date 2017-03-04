<?php

session_start();

require("../include/dbms.inc.php");
require("../include/system.inc.php");
require("../include/template2.inc.php");
require("../include/auth.inc.php");


$main = new Template("../skins/minimal/dtml/frame_public.html");
$body = new Template("../skins/minimal/dtml/error.html");

//recupero dati dell'errore
$db->query("SELECT title, body FROM textpage WHERE section='error_{$_GET['error']}'");
$err_result=$db->getResult()[0];

//setcontent messaggio d'errore
$body->setContent("error_title",$err_result['title']);
//setcontent dettagli dell'errore da mysql se presente
$body->setContent("error_body", $err_result['body']." <br> Detailed description of the error (if available): <strong>".$_SESSION['err_desc']."</strong>");



$main->setContent("body", $body->get());
$main->setContent("message", $_SESSION['msg']);
//pulisco session
$_SESSION['msg']="";
$_SESSION['err_desc']="";
$main->close();


?>


