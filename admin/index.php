<?php

session_start();

require("../include/dbms.inc.php");
require("../include/system.inc.php");
require("../include/template2.inc.php");
require("../include/auth.inc.php");

    $auth->checkPermission();

    $main = new Template("../skins/minimal/dtml/frame_public.html");
    $body = new Template("../skins/minimal/dtml/welcome.html");

        $body->setContent("date",date("d/m/Y"));

        //recupero e visualizzo il numero di libri presenti nel database
        $db->query("SELECT COUNT(*) as count FROM book");
        $body->setContent("booknumber",$db->getResult()[0]['count']);

        //recupero e visualizzo il numero di utneti nel db
        $db->query("SELECT COUNT(*) as count FROM user");
        $body->setContent("usernumber",$db->getResult()[0]['count']);

        //recupero e visualizzo il numero di promozioni attive
        $db->query("SELECT COUNT(*) as count FROM promotion WHERE end>=CURDATE()");
        $body->setContent("promnumber",$db->getResult()[0]['count']);

        //recupero e visualizzo il numero di ordini non anora evasi
        $db->query("SELECT COUNT(*) as count FROM purchase WHERE status = 'In preparation'");
        $body->setContent("orders",$db->getResult()[0]['count']);

        //recupero l'elenco dei libri in esaurimento (disponibilità < 10 pezzi)
        $db->query("SELECT title as booktitle, id as bookid, availability 
                    FROM book 
                    WHERE availability < 10 
                    AND publication_date <= CURDATE()");
        $body->setContent("booklow",$db->getNumRows());
        $data=$db->getResult();
        $text="";
        foreach($data as $line){
            $body->setContent($line);
        }

    $body->setContent("name", $_SESSION['auth']['name']);
    $main->setContent("body", $body->get());
    $main->setContent("message", $_SESSION['msg']);
    $main->close();
    $_SESSION['msg']="";

?>