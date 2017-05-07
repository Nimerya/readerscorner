<?php

     session_start();

     require("include/dbms.inc.php");
     require("include/system.inc.php");
     require("include/template2.inc.php");
     require("include/auth.inc.php");
     
     $main = new Template("skins/gaia/dtml/frame_public.html");
     $body = new Template("skins/gaia/dtml/home_body.html");

     $main->setContent("home_active","active");


     //setcontent slider
     //recupero i dati delle slide dello slider
     $db->query("SELECT * FROM slider WHERE active = 1 ORDER BY position");
     $sliderdata=$db->getResult();

     foreach ($sliderdata as $slide){
          $body->setContent($slide);
     }
     //fine setcontent slider

     //inizio setcontent categorie
     //recupero i dati di 3 categorie random
     $db->query("SELECT name AS categoryname, 
                        id AS categoryid 
                 FROM category 
                 ORDER BY RAND() LIMIT 3");
     $categories=$db->getResult();
     $j=0;
     //per ogni categoria recupero i dati di suoi 6 libri random
     foreach($categories as $category){
         $body->setContent("i",$j);
         $j++;
         $db->query("SELECT book.cover AS cover 
                     FROM bookcategory LEFT JOIN book ON bookcategory.id_book=book.id 
                     WHERE bookcategory.id_category={$category['categoryid']} 
                     ORDER BY RAND() LIMIT 6");
         $books=$db->getResult();
         $body->setContent($category);
         //setcontent
         for($i=0;$i<6;$i++){
             $body->setContent("categorycover", $books[$i]['cover']);
         }
     }
     //fine setcontent categorie


     //inizio setcontent new arrivals
     //recupero i dati dei libri pubblicati nell'ultimo mese
     $db->query("SELECT cover AS newcover, 
                        title AS newtitle, 
                        book.id AS newid, 
                        price as newprice,
                        discount AS newarrivalsdiscount
                        FROM book LEFT JOIN promotion ON id_promotion=promotion.id 
                        WHERE end >= CURDATE() 
                        AND publication_date > (DATE(NOW()) - INTERVAL 30 DAY) 
                        AND publication_date <= CURDATE() 
                        ORDER BY publication_date DESC LIMIT 15");
     $books=$db->getResult();
     if($db->getNumRows()>0){
         foreach($books as $book_new){
             // calcolo sconto e formattazione prezzo con 2 decimali
             $book_new['newnewprice']=number_format(($book_new['newprice']-($book_new['newprice']*$book_new['newarrivalsdiscount'])/100) ,2,".","");
             $body->setContent($book_new);
         }
     }else{
          $body->setContent("hiddenNewArrivals","display:none;");
     }

     //fine setcontent new arrivals


     //inizio setcontent promotions
     //recupero i dati dei libri in promozione (attiva) ordinati per valore della promozione
     $db->query("SELECT cover AS promcover, 
                        title AS promtitle, 
                        book.id AS promid, 
                        price AS promprice, 
                        discount 
                        FROM book 
                        LEFT JOIN promotion ON id_promotion=promotion.id 
                        WHERE end >= CURDATE() AND publication_date <= CURDATE()
                        ORDER BY discount DESC LIMIT 15");
     $books_prom=$db->getResult();
     if($db->getNumRows()>0){
          foreach($books_prom as $book_prom){
              // calcolo sconto e formattazione prezzo con 2 decimali
               $book_prom['promnewprice']=number_format(($book_prom['promprice']-($book_prom['promprice']*$book_prom['discount'])/100) ,2,".","");
               $body->setContent($book_prom);
          }
     }else{
         $body->setContent("hiddenPromotions","display:none;");
     }
     //fine setcontent promotions

     //inizio setcontent coming soon
     //recupero i dati dei libri che ancora non sono stati pubblicati
     $db->query("SELECT cover AS cscover, 
                             title AS cstitle, 
                             publication_date AS csdate
                             FROM book 
                             WHERE publication_date > CURDATE()
                             ORDER BY publication_date LIMIT 15");
     $books_cs=$db->getResult();
     if($db->getNumRows()>0){

         foreach($books_cs as $book_cs){
              $body->setContent($book_cs);
          }
     }else{
          $body->setContent("hiddenNewArrivals","display:none;");
     }
     //fine setcontent coming soon


     $system->commonOps();
     $main->setContent("body", $body->get());
     $main->setContent("message", $_SESSION['msg']);
     $main->close();
     $_SESSION['msg']="";

     
    
?>


