<?php

session_start();

require("include/dbms.inc.php");
require("include/template2.inc.php");

$main = new Template("skins/gaia/dtml/error.html");

    //recupero dati dell'erore
    $db->query("SELECT title,body 
                FROM textpage 
                WHERE section='error_{$_GET['error']}'");
    $err_result=$db->getResult()[0];

    //recupero dati "suggerimenti"
    $db->query("SELECT title,subtitle,body 
                FROM textpage 
                WHERE section='error_hints'");
    $hints=$db->getResult()[0];

    //setcontents
    $main->setContent("error_title",$err_result['title']);
    $main->setContent("error_body", $err_result['body']);

    $main->setContent("hints_title",$hints['title']);
    $main->setContent("hints_subtitle",$hints['subtitle']);
    $main->setContent("hints_body",$hints['body']);

$_SESSION['msg']="";
$_SESSION['err_desc']="";
$main->close();


?>


