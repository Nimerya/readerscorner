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

                $system->report("SELECT id, title, price, publication_date, availability 
                                 FROM {$table} ORDER BY title");
                break;

            case 1: // emit precharged form


                $system->generateForm($table, "edit_del");

                //costrusco l'array delle promozioni da inserire sotto la form come campo ulteriore
                $options=[];
                $options[-1]="";
                $id_prom=-1;
                $name_prom="";

                $db->query("SELECT book.id_promotion AS id, 
                                   promotion.name AS name 
                                   FROM book LEFT JOIN promotion ON book.id_promotion=promotion.id 
                                   WHERE book.id={$_GET['id']} OR book.isbn13={$_GET['id']}");
                $result=$db->getResult();

                if($result[0]['id']!=""){
                    $id_prom=$result[0]['id'];
                    $name_prom=$result[0]['name'];
                    $options[$id_prom]=$name_prom;
                }//carico la promozione attualmente attiva sul libro dentro $options, se c'è
                
                $db->query("SELECT promotion.id AS id, 
                                   promotion.name AS name 
                                   FROM promotion 
                                   WHERE promotion.id <> {$id_prom} ORDER BY name");
                $promotions=$db->getResult();

                foreach($promotions as $key=>$value){
                    $options[$value['id']]=$value['name'];
                }//qui ho $options: array associativo con chiave=id promozione, value=nome promozione
                $sel=$id_prom;//se $id_prom è rimasto = -1 
                if($id_prom==-1){//(cioè non ci sono promozioni attualmente attive seleziono "" come valore predefinito nella select)
                    $sel="";
                }
                //inserisce select nella template (vedi template2.inc.php)
                $body->insertSelect("promotion",$options,"select","","","{$sel}","promotion");
                break;

            case 2: // transaction (update)
                $body = new Template("../skins/minimal/dtml/{$table}_edit.html");

                $db->sanitize();
                //se non è stata scelta una nuova cover 
                if($_FILES['cover']['name']==""){
                    $cover=$_POST['old_cover']; //utilizzo la vecchia
                } else {//altrimenti carico la nuova
                    $cover=$system->fileUpload("../images/cover/","cover");
                }

                $promotion=$_POST['promotion'];
                if($promotion=="" || $promotion==-1){
                    $promotion="NULL"; //se non è stata scelta una promozione imposto il valore a NULL
                }

                $db->query("UPDATE {$table} 
                            SET id_promotion={$promotion},
                                title = '{$_POST['title']}', 
                                price = '{$_POST['price']}', 
                                publication_date = '{$_POST['publication_date']}', 
                                availability = '{$_POST['availability']}',
                                pages = '{$_POST['pages']}', 
                                dimension = '{$_POST['dimension']}',
                                isbn13 = '{$_POST['isbn13']}',
                                language = '{$_POST['language']}',
                                description = '{$_POST['description']}',
                                cover = '{$cover}',
                                publisher = '{$_POST['publisher']}'
                             WHERE id = {$_POST['id']}");
                $db->checkErrors("update");

                //elimino le entry del libro in writes (per poi reinserirle aggiornate)
                $db->query("DELETE FROM writes WHERE writes.id_book={$_POST['id']}");
                $db->checkErrors("update");

                //scorro gli autori inseriti, se l'i-esimo autore non è presente nel db lo inserisco
                $authors=explode(";",$_POST['author']);
                foreach($authors as $value){

                    $db->query("SELECT author.id FROM author WHERE name='{$value}'");
                    $db->checkErrors("referential_constraint");
                    
                    if($db->getNumRows() == 0){
                        $db->query("INSERT INTO author 
                                 VALUES (NULL, 
                                         '$value', 
                                         NULL,
                                         NULL)");
                        $db->checkErrors("referential_constraint");
                        $db->query("SELECT LAST_INSERT_ID() as id;");
                    }
                    //arrivati qui sicuramente l'autore è nel db
                    //catturo id autore, se l'autore c'era l'id l'ho preso prima dell'if, 
                    //altimenti lo inserisco e catturo l'id dell'autore appena inserito

                    $author_id=$db->getResult();

                    //inserisco l'associazione libro-autore dentro writes
                    $db->query("INSERT INTO writes
                             VALUES ({$author_id[0]['id']},
                                     {$_POST['id']})");
                    $db->checkErrors("referential_constraint");
                }//per ogni autore

                $db->OKgoBack($table, 0);
                break;

            case 3: //delete

                $system->transaction("auto",$table,0,"delete");
                break;

            case 4: //emit add form
                $system->generateForm($table, "add");

                $options=[];
                $options[-1]="";

                $db->query("SELECT promotion.id, promotion.name FROM promotion ORDER BY name");
                $promotions=$db->getResult();

                foreach($promotions as $key=>$value){//riempio la select delle promozioni
                    $options[$value['id']]=$value['name'];
                }
                //inietto la select
                $body->insertSelect("promotion",$options,"select","","","{$id_prom}","promotion");
                break;

            case 5: // transaction (add)
                //pulisco dati
                $db->sanitize();

                //carico file cover
                $cover=$system->fileUpload("../images/cover/", "cover");

                $promotion=$_POST['promotion'];
                if($promotion=="" || $promotion==-1){
                    $promotion="NULL"; //se non è stata scelta una promozione la setto a NULL
                }

                $db->query("INSERT INTO {$table} 
                         VALUES (NULL,
                                  {$promotion},
                                 '{$_POST['title']}',
                                 '{$_POST['price']}',
                                 '{$_POST['publication_date']}',
                                 '{$_POST['availability']}',
                                 '{$_POST['pages']}',
                                 '{$_POST['dimension']}',
                                 '{$_POST['isbn13']}',
                                 '{$_POST['language']}',
                                 '{$_POST['description']}',
                                 '{$cover}',
                                 '{$_POST['publisher']}')");
                $db->checkErrors("insert");
                //catturo id libro appena inserito
                $db->query("SELECT LAST_INSERT_ID() as id;");
                $book_id=$db->getResult();

                //scorro gli autori inseriti, se l'i-esimo autore non è presente nel db lo inserisco
                $authors=explode(";",$_POST['author']);
                foreach($authors as $value){

                    $db->query("SELECT author.id FROM author WHERE name='{$value}'");
                    $db->checkErrors("referential_constraint");
                    if($db->getNumRows() == 0){
                        $db->query("INSERT INTO author 
                                 VALUES (NULL, 
                                         '$value', 
                                         NULL,
                                         NULL)");
                        $db->checkErrors("referential_constraint");
                        $db->query("SELECT LAST_INSERT_ID() as id;");
                    }
                    //arrivati qui sicuramente l'autore è nel db
                    //catturo id autore, se l'autore c'era l'id l'ho preso prima dell'if, altimenti lo inserisco e catturo l'id dell'autore appena inserito

                    $author_id=$db->getResult();

                    //inserisco l'associazione libro autore dentro writes
                    $db->query("INSERT INTO writes
                             VALUES ({$author_id[0]['id']},
                                     {$book_id[0]['id']})");
                    $db->checkErrors("referential_constraint");
                }//per ogni autore

                $db->OKgoBack($table,4);
                break;
            default:
                Header("location: /readerscorner/admin/error.php?error=404");
                exit;
                break;
        }


$body->setContent("table", $table);
$main->setContent("message", $_SESSION['msg']);//mostro il messaggio se c'è
$main->setContent("body", $body->get());
$main->close();
$_SESSION['msg']="";//pulisco il messaggio
?>