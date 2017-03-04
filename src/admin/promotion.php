<?php

session_start();

require("../include/dbms.inc.php");
require("../include/system.inc.php");
require("../include/template2.inc.php");
require("../include/auth.inc.php");

$auth->checkPermission();
$table=$system->getTable();


$main = new Template("../skins/minimal/dtml/frame_public.html");

        switch($_REQUEST['page']) {

            case 0: // emit report
                $system->report("SELECT * FROM {$table} ORDER BY id");
                break;

            case 1: // emit precharged form
                $system->generateForm($table, "edit_del");

                //aggiungo report ausiliario che mostra l'elenco dei libri soggetti a questa promozione
                $system->addAux("SELECT book.id,title,price,publication_date, availability
                                                 FROM book 
                                            LEFT JOIN promotion
                                                   ON book.id_promotion=promotion.id
                                                WHERE promotion.id= {$_GET['id']}
                                             GROUP BY book.id
                                             ORDER BY book.title",
                                "SELECT name FROM promotion WHERE id={$_GET['id']}",
                                "List of books belonging to promotion: ");
                break;

            case 2: // transaction update
                $system->transaction("auto", $table, 0, "update");
                break;

            case 3://transaction (delete)
                $system->transaction("auto", $table, 0, "delete");
                break;

            case 4: // emit form (add)
                $system->generateForm($table, "add");
                break;

            case 5: // transaction (add)
                $system->transaction("auto", $table, 4, "insert");
                break;

            default:
                Header("location: /readerscorner/admin/error.php?error=404");
                exit;
                break;
        }

$body->setContent("table", $table);
$main->setContent("message", $_SESSION['msg']);
$main->setContent("body", $body->get());
$main->close();
$_SESSION['msg']="";
?>