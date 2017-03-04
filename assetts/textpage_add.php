<?php

session_start();

require("../include/dbms.inc.php");
require("../include/system.inc.php");
require("../include/template2.inc.php");
require("../include/auth.inc.php");
$auth->checkPermission();

$main = new Template("../skins/minimal/dtml/frame_public.html");
$body = new Template("../skins/minimal/dtml/{$system->getTable()}_add.html");

if (!isset($_REQUEST['page'])) {
    $_REQUEST['page'] = 0;
}

switch($_REQUEST['page']) {
    case 0: // emit form

        break;
    case 1: // transaction
        //pulisco dati
        $db->sanitize();

        $db->query("INSERT INTO textpage 
                         VALUES (NULL,
                                 '{$_POST['title']}',
                                 '{$_POST['subtitle']}',
                                 '{$_POST['body']}',
                                 '{$_POST['position']}',
                                 '{$_POST['active']}',
                                 '{$_POST['section']}')");


        $main->setContent("message", ($db->isError()? "KO":"OK"));

        break;
}


$main->setContent("body", $body->get());
$main->close();

?>


