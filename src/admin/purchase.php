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
                $system->report("SELECT purchase.id AS id, 
                                        user.email AS user_email, 
                                        date_order AS date,
                                        total,  
                                        status  
                                        FROM {$table} 
                                        LEFT JOIN user ON {$table}.id_user = user.id 
                                        ORDER BY purchase.date_order DESC");
                break;
            case 1: // emit precharged form
                $system->generateForm($table, "edit_del");

                //recupero dati dello stato
                $db->query("SELECT status FROM purchase WHERE id={$_GET['id']}");
                $status=$db->getResult()[0]['status'];

                //aggiungo il campo "Status"
                $disabled="";
                $sel=$status;

                if($status=="canceled" || $status=="Canceled"){
                    $body->setContent("script",
                        "<script>document.getElementById('editbutton').style.display='none';</script>");
                    $disabled="disabled";

                }

                $options=array("In preparation"  => "In preparation",
                               "Shipped" => "Shipped",
                               "Canceled" => "Canceled",
                               "Delivered" => "Delivered");

                $body->setContent("labelStatus","Status *");
                $body->insertSelect("status",$options,"select",$disabled,"",$sel,"");

                //aggiungo report ausiliario contenente l'elenco dei libri acquistati in questo ordine
                //con i loro dettagli e i dati relativi al destinatario dell'ordine
                $system->addAux("SELECT book.id, 
                                 bookpurchase.isbn13 AS isbn13, 
                                 bookpurchase.title AS title, 
                                 amount, 
                                 bookpurchase.price AS final_price 
                                 FROM bookpurchase 
                                 LEFT JOIN book ON book.isbn13=bookpurchase.isbn13 
                                 WHERE bookpurchase.id_purchase={$_GET['id']}",

                                "SELECT user.name, 
                                 user.surname, 
                                 user.email, 
                                 country, 
                                 region, 
                                 zip_code, 
                                 address, 
                                 city 
                                 FROM purchase LEFT JOIN address ON purchase.id_address=address.id 
                                 LEFT JOIN user ON address.id_user=user.id WHERE purchase.id={$_GET['id']}",
                                 "List of ordered books: ");
                break;
            case 2:
                //se lo stato è stato impostato a "Canceled" delego order.php ad eseguire la transazione
                //per il ripristino delle disponibilità ecc. (vedi order.php?&mode=cancel)
                if($_POST['status']=="Canceled" || $_POST['status']=="canceled"){
                    Header("location: /readerscorner/order.php?id={$_POST['id']}&mode=cancel&return=backoffice");
                    exit;
                }//altrimenti
                 //proseguo con l'update
                $system->transaction("UPDATE purchase 
                                      SET status='{$_POST['status']}' 
                                      WHERE purchase.id={$_POST['id']}", $table, 0, "update");
                break;
            case 3://transaction (delete)
                $system->transaction("auto", $table, 0, "delete");
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