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
                $system->report("SELECT * FROM {$table} ORDER BY title");
                break;

            case 1: // emit precharged form
                $system->generateForm($table, "edit_del");
                break;

            case 2: // transaction update
                $db->sanitize();
                //se non è stata scelta una nuova immagine
                if($_FILES['image']['name']==""){
                    $image=$_POST['old_image']; //utilizzo quella vecchia
                } else {//altrimenti carico la nuova
                    $image=$system->fileUpload("../images/slider/","image");
                }
                //proseguo con l'update
                $system->transaction("UPDATE {$table} 
                                      SET title = '{$_POST['title']}', 
                                          body = '{$_POST['body']}',
                                          image = '{$image}',
                                          link = '{$_POST['link']}',
                                          active = {$_POST['active']},
                                          position = {$_POST['position']}
                                      WHERE id = {$_POST['id']}", $table, 0, "update");
                break;

            case 3://transaction (delete)
                $system->transaction("auto", $table, 0, "delete");
                break;

            case 4: // emit form (add)
                $system->generateForm($table, "add");
                break;

            case 5: // transaction (add)
                $db->sanitize();
                //carico immagine
                $image=$system->fileUpload("../images/slider/","image");
                //proseguo con l'insert
                $system->transaction("INSERT INTO {$table} 
                                            VALUES (NULL,
                                                    '{$_POST['title']}',
                                                    '{$_POST['body']}',
                                                    '{$image}',
                                                    '{$_POST['link']}',
                                                    '{$_POST['active']}',
                                                    '{$_POST['position']}')", $table, 4, "insert");
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