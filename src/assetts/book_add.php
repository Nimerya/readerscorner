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
             #echo "sanitize OK <br>";

             //carico file cover
             $cover=$system->fileUpload();

             $db->query("INSERT INTO book 
                         VALUES (NULL,
                                 NULL,
                                 '{$_POST['title']}',
                                  {$_POST['price']},
                                 '{$_POST['publication_date']}',
                                  {$_POST['availability']},
                                  {$_POST['pages']},
                                 '{$_POST['dimension']}',
                                 '{$_POST['isbn13']}',
                                 '{$_POST['language']}',
                                 '{$_POST['description']}',
                                 '{$cover}',
                                 '{$_POST['publisher']}')");

             //catturo id libro appena inserito
             $db->query("SELECT LAST_INSERT_ID() as id;");
             $book_id=$db->getResult();

             //scorro gli autori inseriti, se l'i-esimo autore non è presente nel db lo inserisco
             $authors=explode(";",$_POST['author']);
             foreach($authors as $value){

                 $db->query("SELECT author.id FROM author WHERE name='{$value}'");

                 if($db->getNumRows() == 0){
                     $db->query("INSERT INTO author 
                                 VALUES (NULL, 
                                         '$value', 
                                         NULL)");
                     $db->query("SELECT LAST_INSERT_ID() as id;");
                 }
                 //arrivati qui sicuramente l'autore è nel db
                 //catturo id autore, se l'autore c'era l'id l'ho preso prima dell'if, altimenti lo inserisco e catturo l'id dell'autore appena inserito

                 $author_id=$db->getResult();

                 //inserisco l'associazione libro autore dentro writes
                 $db->query("INSERT INTO writes
                             VALUES ({$author_id[0]['id']},
                                     {$book_id[0]['id']})");
             }//per ogni autore


             $main->setContent("message", ($db->isError()? "KO":"OK"));

             break;
     }
     
     $body->setContent("table", $system->getTable());
     $main->setContent("body", $body->get());
     $main->close();
    
?>


