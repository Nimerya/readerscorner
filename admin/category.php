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
        //aggiungo un report ausiliario sotto la form di modifica
        $system->addAux("SELECT book.id,title,price,publication_date, availability
                                                 FROM category 
                                            LEFT JOIN bookcategory 
                                                   ON category.id=bookcategory.id_category
                                            LEFT JOIN book 
                                                   ON bookcategory.id_book = book.id 
                                                WHERE category.id= {$_GET['id']}
                                             GROUP BY book.id
                                             ORDER BY book.title",
                        "SELECT name FROM category WHERE id={$_GET['id']}",
                        "List of books belonging to: ");

        break;

    case 2: // transaction update
        $system->transaction("auto", $table, 0, "update");
        break;

    case 3://transaction (delete)

        $system->transaction("auto",$table,0,"delete");
        break;

    case 4: // emit form (add)
        $system->generateForm($table, "add");
        break;

    case 5: // transaction (add)
        $system->transaction("auto", $table, 4, "insert");
        break;

    case 10: //emissione form aggiunta libro a categoria
        $body=new Template("../skins/minimal/dtml/select_form.html");
        //genero le select per aggiungere un libro a una categoria
        $system->generateSelect("category", "book", "name", "title", "add");
        break;

    case 11: //transazione aggiunta libro a categoria
        $system->addXtoY("bookcategory", $_POST['category'], $_POST['book'], "add");
        break;

    case 12: // step 1 rimozione: emissione form selezione categoria dalla quale rimuovere il libro
        $body=new Template("../skins/minimal/dtml/select_form.html");
        $system->generateSelect("category", "book", "name", "title", "del", "bookcategory");
        break;

    case 13://step 2 rimozione: emissione form selezione libro da rimuovere dalla
            // categoria precedentemente selezionata
        $body=new Template("../skins/minimal/dtml/select_form.html");
        $system->generateSelect("category", "book", "name", "title", "del", "bookcategory");
        break;
    case 14://step 3 rimozione: transazione
        $system->addXtoY("bookcategory",$_POST['category'], $_POST['book'], "del");
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