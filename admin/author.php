<?php

session_start();

require("../include/dbms.inc.php");
require("../include/system.inc.php");
require("../include/template2.inc.php");
require("../include/auth.inc.php");

//controllo che l'user abbia il permesso di accedere alla pagina
$auth->checkPermission();
$table=$system->getTable();

$main = new Template("../skins/minimal/dtml/frame_public.html");

        switch($_REQUEST['page']) {

            case 0: // emit report

                $system->report("SELECT id, name, biography FROM {$table} ORDER BY name");
                break;

            case 1: // emit precharged form
                $system->generateForm($table, "edit_del");
                
                //addaux aggiunge un report extra sotto la form di edit (vedi system.inc.php)
                $system->addAux("SELECT book.id,title,price,publication_date, availability
                                                 FROM author 
                                            LEFT JOIN writes 
                                                   ON author.id=writes.id_author
                                            LEFT JOIN book 
                                                   ON book.id = writes.id_book 
                                                WHERE author.id= {$_GET['id']}
                                             GROUP BY book.id
                                             ORDER BY book.title","SELECT name FROM author 
                                             WHERE id={$_GET['id']}","List of books written by: ");
                break;
                
            case 2: // transaction update

                $db->sanitize();
                //se non ho scelto una nuova foto allora prendo la vecchia
                if($_FILES['photo']['name']==""){
                    $photo=$_POST['old_photo'];
                } else {
                    //altrimenti carico la nuova
                    $photo=$system->fileUpload("../images/author/","photo");
                }
                
                $system->transaction("UPDATE {$table} 
                                      SET name = '{$_POST['name']}', 
                                          biography = '{$_POST['biography']}',
                                          photo = '{$photo}'
                                      WHERE id = {$_POST['id']}", $table, 0, "update");
                break;

            case 3://transaction (delete)

                $system->transaction("auto",$table,0,"delete");

                break;

            case 4: // emit form (add)
                $system->generateForm($table, "add");
                break;

            case 5: // transaction (add)
                //pulisco dati
                $db->sanitize();
                //carico la foto
                $photo=$system->fileUpload("../images/author/","photo");

                $system->transaction("INSERT INTO {$table} 
                                            VALUES (NULL,
                                                    '{$_POST['name']}',
                                                    '{$_POST['biography']}',
                                                    '{$photo}')", $table, 4, "insert");

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