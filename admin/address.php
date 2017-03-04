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

        switch($_REQUEST['page']) {//switch su page

            case 0: // emit report
                $system->report("SELECT address.id, 
                                        user.email, 
                                        address.address, 
                                        address.country, 
                                        address.region, 
                                        address.zip_code 
                                        FROM address 
                                        LEFT JOIN user 
                                        ON address.id_user = user.id 
                                        ORDER BY user.email");
                break;

            case 1: // emit precharged form
                $system->generateForm($table, "edit_del");
                break;

            case 2: // transaction (update)
                $body = new Template("../skins/minimal/dtml/{$table}_edit.html");
                $db->sanitize();

                $email=$_POST['email'];
                //recupero l'id utente tramite la sua email
                $db->query("SELECT id FROM user WHERE email='{$email}'");
                $id_user=$db->getResult();

                $system->transaction("UPDATE {$table} 
                                         SET id_user={$id_user[0]['id']},
                                             country='{$_POST['country']}',
                                             region='{$_POST['region']}',
                                             city='{$_POST['city']}',
                                             zip_code='{$_POST['zip_code']}',
                                             address='{$_POST['address']}'
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
                $email=$_POST['email'];
                //recupero l'id utente tramite la sua email
                $db->query("SELECT id FROM user WHERE email='{$email}'");
                $id_user=$db->getResult();
                $system->transaction("INSERT INTO {$table} 
                                             VALUES (NULL,
                                                    {$id_user[0]['id']},
                                                    '{$_POST['country']}',
                                                    '{$_POST['region']}',
                                                    '{$_POST['city']}',
                                                    '{$_POST['zip_code']}',
                                                    '{$_POST['address']}')", $table, 4, "insert");
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