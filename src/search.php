<?php
     session_start();

     require("include/dbms.inc.php");
     require("include/system.inc.php");
     require("include/template2.inc.php");
     require("include/auth.inc.php");

     $main = new Template("skins/gaia/dtml/frame_public.html");
     $body = new Template("skins/gaia/dtml/report.html");

     $psize=$system->getPsize();
     $number=0;
     $totentry=0;
     $searchquery="nothing";

     $db->sanitize();
     $_REQUEST['sq']=$db->sanitize($_REQUEST['sq']);


     $data=[];

     if(isset($_REQUEST['cid'])){//se è stato passato l'id di una categoria
         $main->setContent("category_active","active");

         //conservo il target della ricerca per usarlo dopo quando cambio pagina
         $_SESSION['sq']="cid={$_REQUEST['cid']}";

         //recupero il nome della categoria
         $db->query("SELECT name FROM category WHERE id={$_REQUEST['cid']}");
         $searchquery="{$db->getResult()[0]['name']}";

         //impagino tutti i libri appartenenti a quella categoria
         $res=$system->search("SELECT id,title,price,cover
                                 FROM book 
                            LEFT JOIN bookcategory 
                                   ON book.id = bookcategory.id_book 
                                WHERE bookcategory.id_category ={$_REQUEST['cid']}");

         //acquisisco dati che userò alla fine
         $totentry=$res[0];
         $data=$res[1];
         $number=$res[2];

     }elseif(isset($_REQUEST['promid'])){//se invece ho l'id di una promozione

         $main->setContent("sales_active","active");
         $_SESSION['sq']="promid={$_REQUEST['promid']}";

         //recupero il nome della promozione
         $db->query("SELECT name FROM promotion 
                     WHERE id={$_REQUEST['promid']} 
                     AND promotion.end>=CURDATE()");
         if($db->getNumRows()==1){
             $searchquery="{$db->getResult()[0]['name']}";
         }

         //recupero i dati dei libri appartenenti a quella promozione
         $res=$system->search("SELECT book.id AS id,title,price,cover
                               FROM book 
                               LEFT JOIN promotion ON book.id_promotion=promotion.id
                               WHERE book.id_promotion ={$_REQUEST['promid']} 
                               AND promotion.end>=CURDATE()");

         $totentry=$res[0];
         $data=$res[1];
         $number=$res[2];


     }elseif($_REQUEST['sq']){//se invece ho una stringa
         $_SESSION['sq']="sq={$_REQUEST['sq']}&mode={$_REQUEST['mode']}";

         if($_REQUEST['sq'] == "newarrivals"){//caso "newarrivals"
             $main->setContent("na_active","active");

             //recupero i dati dei libri pubblicati nell'ultimo mese
             $res=$system->search("SELECT id,title,price,cover 
                                   FROM book 
                                   WHERE publication_date > (DATE(NOW()) - INTERVAL 30 DAY) 
                                   AND publication_date <= CURDATE() 
                                   ORDER BY publication_date DESC");
             $totentry=$res[0];
             $data=$res[1];
             $number=$res[2];
             $searchquery="New Arrivals";

         }elseif($_REQUEST['sq']=="bestsellers"){//caso "bestsellers"
             $main->setContent("best_active","active");

             //recupero dati dei libri più venduti
             $res=$system->search("SELECT SUM(amount) AS sum, 
                                          book.id AS id, 
                                          book.title AS title,
                                          book.price AS price, 
                                          book.cover AS cover 
                                    FROM bookpurchase 
                                    LEFT JOIN book ON book.isbn13 = bookpurchase.isbn13 
                                    GROUP BY bookpurchase.isbn13 ORDER BY sum DESC");
             $data=$res[1];
             $number=$res[2];
             $totentry=$res[0];
             $searchquery="Bestsellers";

         }else{//qualsiasi altra stringa
             switch($_REQUEST['mode']){//switch modalità: libro/autore
                 case "b"://caso b: cerco un libro
                     //cerco i libri compatibili al titolo/isbn13 inserito
                     $res=$system->search("SELECT id,title,price,cover 
                                           FROM book 
                                           WHERE title 
                                           LIKE '%{$_REQUEST['sq']}%' 
                                           OR isbn13 
                                           LIKE '%{$_REQUEST['sq']}%'");
                     $totentry=$res[0];
                     $data=$res[1];
                     $number=$res[2];
                     $searchquery="\"{$_REQUEST['sq']}\"";

                     break;
                 case "a"://caso a: autore

                     //cerco l'autore in base al nome
                     $db->query("SELECT photo, biography, name 
                                 FROM author 
                                 WHERE name 
                                 LIKE '%{$_REQUEST['sq']}%' ");

                 //se ho un un unico risultato per l'autore
                 if($db->getNumRows()==1){
                     //ne mostro i dettagli
                         $author=$db->getResult()[0];
                         $body->setContent("showauthor","display:inline-block;");
                         $body->setContent("name",$author['name']);
                         $body->setContent("photo",$author['photo']);
                         if($author['biography']!=""){//se ho la biografia
                             $body->setContent("biography",$author['biography']);
                         }else{//se non ho la biografia
                             $body->setContent("biography","<br> not available.");
                         }
                     }
                     //recupero i dati di tutti i libri con l'autore cercato
                     $res=$system->search("SELECT book.id,title,price,cover,author.name
                                             FROM book LEFT JOIN writes ON book.id=writes.id_book
                                        LEFT JOIN author ON writes.id_author=author.id
                                            WHERE author.name LIKE '%{$_REQUEST['sq']}%'");

                     $totentry=$res[0];
                     $data=$res[1];
                     $number=$res[2];

                     //costruisco una stringa contenente l'elenco degli autori che matchano con la ricerca
                     $authors="";
                     $authors_arr=array();
                     foreach ($data as $line){
                         if(isset($authors_arr[$line['name']])){
                             continue;
                         }
                         $authors_arr[$line['name']]=1;
                         $authors.="{$line['name']}, ";
                     }
                     $authors=substr($authors,0,-2);
                     $searchquery="\"{$_REQUEST['sq']}\" ({$authors})";
                     break;
             }
         }
     }
     //se in uno qualsiasi dei casi sopra ho dei risultati
     if($number > 0){
         $prom_array=[];
         //costruisco un array associativo [idlibro]=>[valoresconto] se c'è
         $db->query("SELECT discount, book.id as id
                   FROM book 
              LEFT JOIN promotion 
                     ON promotion.id=book.id_promotion 
                    AND promotion.end >= CURDATE()");
         $prom_data=$db->getResult();

         foreach($prom_data as $line){
             $prom_array[$line['id']]=$line['discount'];
         }

         //setcontent dei libri con i loro dati
         foreach($data as $line){
             if($prom_array[$line['id']]!=""){
                 $body->setContent("price",$line['price']);
                 //setcontent con calcolo del prezzo scontato
                 $body->setContent("newprice", number_format(($line['price']-($line['price']*$prom_array[$line['id']])/100) ,2,".",""));
                 $body->setContent("discount", "-".$prom_array[$line['id']]."%");
             }else{
                 $body->setContent("price","");
                 $body->setContent("newprice", $line['price']);
                 $body->setContent("discount", "");
             }

             $body->setContent("title",$line['title']);
             $body->setContent("cover",$line['cover']);
             $body->setContent("id",$line['id']);

         }
     }else{//se in uno qualsiasi dei casi sopra non ho risultati
         $body->setContent("hidePagination","display:none;");
         $body->setContent("disabled","display:none;");
         $_SESSION['msg']="empty";
     }

     //setcontent impaginazione risultati
    $body->setContent("psize_a", $system->psize_admin);
    $body->setContent("sq",$_SESSION['sq']);
    $body->setContent("number", $totentry);
    $body->setContent("searchquery", str_replace("\\","",$searchquery));

    $system->commonOps();
    $main->setContent("body", $body->get());
    $main->setContent("message", $_SESSION['msg']);
    $main->close();
    $_SESSION['msg']="";
?>