<?php

     session_start();

     require("include/dbms.inc.php");
     require("include/system.inc.php");
     require("include/template2.inc.php");
     require("include/auth.inc.php");
     
     $main = new Template("skins/gaia/dtml/frame_public.html");
     $body = new Template("skins/gaia/dtml/single-page.html");

     //salvo il pid in sessione (usato per il meccanismo di impaginazione)
     $_SESSION['pid']=$_REQUEST['pid'];
     $userid=$auth->isLogged();
     $psize=$system->getPsize();
     $number=0;
     $totentry=0;
     $searchquery="nothing";

    switch($_REQUEST['page']){
        case 0://emit dettagli libro
            if(isset($_REQUEST['pid'])){//se ho l'id o l'isbn13
                //recupero i dati del libro
                $db->query("SELECT *, price AS newprice 
                            FROM book 
                            WHERE id={$_REQUEST['pid']} 
                            OR book.isbn13={$_REQUEST['pid']}");
                $data=$db->getResult()[0];
                //recupero i dati dello sconto (se c'è) applicato al libro
                $db->query("SELECT discount 
                            FROM book 
                            LEFT JOIN promotion ON book.id_promotion = promotion.id 
                            WHERE (book.id={$_REQUEST['pid']} OR book.isbn13={$_REQUEST['pid']}) 
                            AND end>=CURDATE()");
                $prom_data=$db->getResult()[0];

                if($db->getNumRows()==1){//se il libro è in promozione
                    $body->setContent("discount", $prom_data['discount']);
                    $body->setContent("newprice", number_format(($data['price']-($data['price']*$prom_data['discount'])/100) ,2,".",""));
                }else{//se il libro non è in promozione
                    $body->setContent("hidden", "visibility:hidden;");
                    $data['price']="";
                }

                //recupero dati relativi a recensioni e media voti
                $db->query("SELECT vote 
                            FROM review
                            LEFT JOIN book ON book.id = review.id_book 
                            WHERE id_book={$_REQUEST['pid']} OR book.isbn13={$_REQUEST['pid']}");
                $votes=$db->getResult();
                $len=count($votes);
                $sum=0;
                //calcolo media dei voti
                foreach($votes as $vote){
                    $sum+=$vote['vote'];
                }
                $avg=$sum/$len;
                $body->setContent("average",round($avg, 2));

                //setcontent dati del libro
                $body->setContent($data);

                //recupero l'elenco degli autori
                $db->query("SELECT author.name AS authorname, 
                                   author.id AS authorid 
                                   FROM book 
                                   LEFT JOIN writes ON book.id=writes.id_book 
                                   LEFT JOIN author ON writes.id_author=author.id 
                                   WHERE book.id={$data['id']}");
                $authors=$db->getResult();

                foreach($authors as $author){
                    $body->setContent($author);
                }

                //recupero le recensioni degli utenti
                $res7=$system->search("SELECT review.body AS body, 
                                              review.id AS rid, 
                                              review.vote AS vote, 
                                              user.name AS reviewName
                                       FROM book LEFT JOIN review ON book.id=review.id_book 
                                       LEFT JOIN user ON review.id_user=user.id
                                       WHERE book.id={$_REQUEST['pid']} OR book.isbn13={$_REQUEST['pid']}");
                $totentry=$res7[0];
                $reviews=$res7[1];
                $number=$res7[2];

                //se non ci sono recensioni
                if($reviews[0]['rid']==""){
                    $body->setContent("hideReviews", "display:none;");
                }else{//se ci sono recensioni
                    foreach($reviews as $review){
                        $body->setContent($review);
                    }
                }

                $body->setContent("bookid",$data['id']);

                //se l'utente è loggato
                if(isset($userid)){//mostro il pulsante per inserire recensione
                    $body->setContent("show","display:block;");

                    //se inoltre appartiene al gruppo Administrator o Moderators
                    //mostro il pulsante per la rimozione della recensione
                    if($auth->belongsToGroup("Administrators") || $auth->belongsToGroup("Moderators")){
                        $body->setContent("showRemove","display:block;");
                    }
                }

            }else{
                Header("location: error.php?error=system");
                exit;
            }
            break;

        case 1: //add review

            if(!isset($userid)){
                Header("location: error.php?error=permission");
                exit;
            }

            $db->sanitize();

            //check dati in ingresso
            if(strlen($_POST['review'])>300 ||
                !isset($_POST['review']) ||
                !isset($_POST['vote']) ||
                $_POST['vote']<1 ||
                $_POST['vote']>5){

                    $_SESSION['msg']="KO";
                    Header("location: item.php?pid={$_REQUEST['bookid']}");
                    exit;
            }

            //transazione aggiunta recensione
            $db->query("INSERT INTO review 
                        VALUES(NULL, {$userid}, {$_POST['bookid']}, '{$_POST['review']}', {$_POST['vote']})");

            if($db->isError()){//se c'è errore
                $db-> checkErrors("insert","front","/readerscorner/item.php?pid={$_REQUEST['bookid']}");
                $_SESSION['msg']="You can only add one review for each book.";
            }else{//transazione andata a buon fine
                $_SESSION['msg']="OK-review-add";
            }
            Header("location: item.php?pid={$_REQUEST['bookid']}");
            exit;
        break;

        case 2: //delete review

            //controllo che effettivamente l'user abbia i permessi
            if(!($auth->belongsToGroup("Administrators") || $auth->belongsToGroup("Moderators"))){
                Header("location: error.php?error=permission");
                exit;
            }

            $db->sanitize();
            $db->query("DELETE FROM review WHERE id={$_REQUEST['rid']}");

            if($db->isError()){
                $_SESSION['msg']="KO";
            }else{
                $_SESSION['msg']="OK";
            }
            Header("location: item.php?pid={$_REQUEST['pid']}");
            exit;

            break;
    }


     $body->setContent("psize_a", $system->psize_admin);
     $body->setContent("sq",$_SESSION['pid']);
     $body->setContent("number", $totentry);
     $system->commonOps();
     $main->setContent("body", $body->get());
     $main->setContent("message", $_SESSION['msg']);
     $main->close();
     $_SESSION['msg']="";
     
    
?>


