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
                $system->report("SELECT * FROM {$table} ORDER BY name");
                break;

            case 1: // emit precharged form
                $system->generateForm($table, "edit_del");

                //aggiungo report ausiliario nella form di modifica per visualizzare
                //gli users appartenenti a quel gruppo
                $system->addAux("SELECT user.id, user.name, user.surname, user.email
                                                 FROM usergroup
                                            LEFT JOIN user
                                                   ON user.id = usergroup.id_user
                                                WHERE usergroup.id_group= {$_GET['id']}",
                                            "SELECT name FROM groups WHERE id={$_GET['id']}",
                                "List of users belonging to: ",1,"user.php");

                //aggiungo report ausiliario nella form di modifica per visualizzare
                //i servizi attivi in quel gruppo
                $system->addAux("SELECT service.id, service.name, service.description
                                 FROM groupservice LEFT JOIN service ON groupservice.id_service = service.id
                                 WHERE groupservice.id_group={$_GET['id']}",
                                "SELECT name FROM groups WHERE id={$_GET['id']}",
                                "List of services belonging to: ",2,"service.php");


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

            case 10: //add service to group
                $body=new Template("../skins/minimal/dtml/select_form.html");
                $system->generateSelect("groups", "service", "name", "name", "add");
                break;

            case 11: //transaction add service to group
                $system->addXtoY("groupservice", $_POST['groups'], $_POST['service'], "add");
                break;

            case 12: //step 1 rimozione servizio da gruppo
                $body=new Template("../skins/minimal/dtml/select_form.html");
                $system->generateSelect("groups", "service", "name", "name", "del", "groupservice");
                break;

            case 13: //step 2 rimozione servizio da gruppo
                $body=new Template("../skins/minimal/dtml/select_form.html");
                $system->generateSelect("groups", "service", "name", "name", "del", "groupservice");
                break;
            case 14: //step 3 rimozione servizio da gruppo (transazione)
                $system->addXtoY("groupservice",$_POST['groups'], $_POST['service'], "del");
                break;

            case 20: //step 1 aggiunta utente a gruppo
                $body=new Template("../skins/minimal/dtml/select_form.html");
                $system->generateSelect("user", "groups", "email", "name", "add","", 21);
                break;

            case 21: //transazione aggiunta utente a gruppo
                $system->addXtoY("usergroup", $_POST['user'], $_POST['groups'], "add",20);
                break;

            case 22: //step 1 rimozione utente da gruppo
                $body=new Template("../skins/minimal/dtml/select_form.html");
                $system->generateSelect("user", "groups", "email", "name", "del", "usergroup","",23);
                break;

            case 23: //step 2 rimozione utente da gruppo
                $body=new Template("../skins/minimal/dtml/select_form.html");
                $system->generateSelect("user", "groups", "email", "name", "del", "usergroup","",23);
                break;
            case 24: //step 3 rimozione utente da gruppo: transazione
                $system->addXtoY("usergroup",$_POST['user'], $_POST['groups'], "del","",22);
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