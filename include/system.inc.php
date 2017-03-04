<?php

    Class System {
        var
            $table,
            $psize_admin, //dimensione di una pagina di report del pannello di amministrazione
            $placeholder,
            $pattern,
            $style;
        
        function System() {
            global $body;

            //cattura nome della pagina
            $this->table = explode(".php", basename($_SERVER['SCRIPT_NAME']))[0];
            //imposta page a 0 se nonn è settato
            if (!isset($_REQUEST['page'])) {
                $_REQUEST['page'] = 0;
            }

            //imposta dimensione pagina
            if (isset($_REQUEST['psize_a'])) {
                if((int)$_REQUEST['psize_a'] == $_REQUEST['psize_a'] && (int)$_REQUEST['psize_a'] > 0){
                    $this->psize_admin=$_REQUEST['psize_a'];
                    $_SESSION['psize_a']=$_REQUEST['psize_a'];
                }else{
                    $this->psize_admin = 15;
                }
            }elseif (isset($_SESSION['psize_a'])){
                if((int)$_SESSION['psize_a'] == $_SESSION['psize_a'] && (int)$_SESSION['psize_a'] > 0) {
                    $this->psize_admin = $_SESSION['psize_a'];
                }else{
                    $this->psize_admin = 15;
                }
            }
            elseif ($this->psize_admin=="") {
                $this->psize_admin = 15;
            }
        }

        /**
         * data una query impagina i risultati
         * @param $query string query i cui risultati andranno impaginati
         * @return array res[0] contiene il numero totale di entry che tornerebbe la query se non limitata;
         *               res[1] contiene i dati tornati dalla query
         *               res[2] contiene il numero di entry tornate da questa query (limitata)
         */
        function search($query){

            global $db, $body;
            $number=0;
            $totentry=0;
            $res=array();
            //ottengo la dimensione di una pagina
            $psize=$this->getPsize();

            //lancio la query
            $db->query($query);
            $db->checkErrors("system","frontoffice");
            //se ci sono risultati ne catturo il numero
            if($db->getNumRows()>0){
                $totentry=$db->getNumRows();
            }
            //calcolo il numero di pagine necessarie a contenere tutti i risultati
            $numpages=$this->getNumPages($totentry);

            //lancio la funzione che si occupa dei setcontent dei pulsanti per cambiare pagina
            $pn=$body->setPageButtons($numpages);

            //calcolo l'offset iniziale
            $start=($pn-1)*$psize;

            //lancio la query limitata
            $db->query($query." LIMIT {$start}, {$psize}");
            $data=$db->getResult();
            //se ottengo risultati ne metto da parte la cardinalità
            if($db->getNumRows()>0){
                $number=$db->getNumRows();
            }
            //return (vedi PHPDoc)
            $res[0]=$totentry;
            $res[1]=$data;
            $res[2]=$number;

            return $res;
        }


        /**
         * genera una stringa di caratteri random lunga $length
         * @param int $length lunghezza della stringa da generare
         * @return string stringa di caratteri random
         */
        function generateRandomString($length = 10) {
            $characters = '0123456789abcdefghijklmnopqrstuvwxyz';
            $charactersLength = strlen($characters);
            $randomString = '';
            for ($i = 0; $i < $length; $i++) {
                $randomString .= $characters[rand(0, $charactersLength - 1)];
            }
            return $randomString;
        }


        /**
         * aggiunge una tabella di report ausiliaria (sotto il form di edit/cancellazione) nel backoffice
         * @param $query string query che recupera i dati da inserire nella tabella
         * @param $querytext string query che recupera i dati da utilizzare come descrizione
         * @param $text string testo da mettere a video sopra il report
         * @param int $tag indica l'indice del placeholder aux da sostituire
         * @param string $auxtable nome della pagina su cui si viene redirezionati
         *                         onclick sulla riga della tabella di report
         */
        function addAux($query, $querytext, $text, $tag=1,$auxtable=""){
            global $db, $aux, $body;

            $aux=new Template("../skins/minimal/dtml/report.html");
            $db->query($query);

            if($db->getNumRows()==0){
                return;
            }
            $aux->report($db->getResult(),"aux");

            if($auxtable!=""){
                $aux->setContent("auxtable",$auxtable);
            }else{
                $aux->setContent("auxtable","book.php");
            }
            $aux->setContent("hidden","display:none");

            $db->query($querytext);
            //caso particolare "purchase"
            if($this->table=="purchase"){
                $items=$db->getResult()[0];
                $extra1="Recipient: ".$items['name']." ".$items['surname'];
                $extra2="Email: ".$items['email'];
                $extra3="Address: ".$items['address'].", ".$items['zip_code'].", "
                                   .$items['city'].", ".$items['region'].", ".$items['country'];
                $body->addBlank("additionaltext", "Shipping Data<br><br>"."<p>".$extra1."</p>".
                                "<p>".$extra2."</p>"."<p>".$extra3."</p>");
                $body->addBlank("auxtitle".$tag,$text);
            }else{
                $body->addBlank("auxtitle".$tag,$text.$db->getResult()[0]['name']);
            }
            $body->setContent("hidden","display:none");
            $body->setContent("aux".$tag, $aux->get());
        }

        /**
         * cattura i metadati dal db
         */
        function getMetadata(){
            global $db;
            $db->query("SELECT * FROM field_data ");
            $data=$db->getResult();

            foreach($data as $field){
                $this->pattern[$field['name']]=$field['pattern'];
                $this->placeholder[$field['name']]=$field['placeholder'];
                $this->style[$field['name']]=$field['style'];
            }
        }

        /**
         * @param $n int nuova taglia della pagina
         */
        function setPageSize($n, $mode="admin"){
            $this->psize_admin=$n;
        }

        /**
         * @return mixed nome della tabella (ricavato dalla pagina in cui si trova)
         */
        function getTable() {
            return $this->table;
        }

        /**
         * @param string $mode se = admin torna la taglia di una pagina del backoffice
         * @return int la taglia di una pagina
         */
        function getPsize() {
            return $this->psize_admin;
        }


        /**
         * @param $date string data da convertire
         * @param $desiredResult string formato desiderato
         * @return bool|false|string false se il formato non è definito, la data riformattata altrimenti
         */
        function dateConverter($date, $desiredResult){
            switch($desiredResult) {
                case "ymd":
                    return date_format(date_create_from_format('d-m-Y', $date), 'Y-m-d');
                case "dmy":
                    return date_format(date_create_from_format('Y-m-d', $date), 'd-m-Y');
                default:
                    return false;
            }
        }

        /**
         * dato il numero tot di entries torna il numero di pagine
         * necessarie ad ospitare i risultati (vedi $system->search)
         *
         * @param $tot int numero di entry del report
         * @return float il numero di pagine necessarie
         */
        function getNumPages($tot){
            return ceil($tot/$this->psize_admin);
        }

        /**
         * carica il file dopo un'inserimento dello stesso tramite form
         * @param $where string path dove si vuole salvare il file
         * @param $name string nome della variabile contenente i dati del file dentro la superglobal $_FILES
         * @return string torna il nome del file caricato
         */
        function fileUpload($where, $name){
            $target_dir = $where;
            $return=basename($_FILES[$name]["name"]);
            $target_file = $target_dir . basename($_FILES[$name]["name"]);
            $uploadOk = 1;
            $imageFileType = pathinfo($target_file,PATHINFO_EXTENSION);
            // Check if image file is a actual image or fake image
            if(isset($_POST["submit"])) {
                $check = getimagesize($_FILES[$name]["tmp_name"]);
                if($check !== false) { //ok
                    $uploadOk = 1;
                } else {//il file non è un'immagine
                    $uploadOk = 0;
                }
            }
            // controllo formato file
            if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg"
                && $imageFileType != "gif" ) {
                $uploadOk = 0;
            }
            //controllo flag
            if ($uploadOk == 0) {
            //se è tutto ok
            } else {
                //sposto file nella nuova destinazione
                if (move_uploaded_file($_FILES[$name]["tmp_name"], $target_file)) {

                } else {
                   //errore spostamento file
                }
            }
            return $return;
        }

        /**
         * funzione atta a racchiudere tutte le operazioni effettuate da tutte le pagine del frontoffice
         */
        function commonOps(){
            global $db,$main,$auth;

            //recupero i dati dei link delle varie sezioni del footer
            $db->query("SELECT title AS infotitle, 
                               id AS infoid 
                        FROM textpage 
                        WHERE section = 'information' 
                        AND active = 1 
                        ORDER BY title");
            $data=$db->getResult();
            foreach($data as $line){
                $main->setContent($line);
            }

            $db->query("SELECT title AS faqtitle, 
                               id AS faqid 
                        FROM textpage 
                        WHERE section = 'faq' 
                        AND active = 1 
                        ORDER BY title");
            $data=$db->getResult();
            foreach($data as $line){
                $main->setContent($line);
            }
            //fine footer

            //genero i menu dropdown del menu orizzontale del frontoffice
            $this->setDDmenu("categories");
            $this->setDDmenu("promotions");
            //testo nell'angolo in alto a sinistra
            $db->query("SELECT body FROM textpage WHERE section='quote'");
            $main->setContent("quote", $db->getResult()[0]['body']);
            //vedi $system->setAuthButtons()
            $auth->setAuthButtons();
        }


        /**
         * @param $mode string specifica il target delle operazioni: "categories" genera il menu delle categorie
         *                                                           "promotions" genera il menu delle promozioni
         */
        function setDDmenu($mode){
            global $db, $main;

            switch($mode){
                case "categories":
                    $db->query("SELECT name AS ddcatname, id AS ddcatid 
                                FROM category ORDER BY ddcatname");
                    $ddmenu=$db->getResult();
                    foreach($ddmenu as $line){
                        $main->setContent($line);
                    }
                    break;
                case "promotions":
                    //le promozioni scadute non compaiono
                    $db->query("SELECT name AS ddpromname, id AS ddpromid 
                                FROM promotion WHERE end >= CURDATE() ORDER BY ddpromname");
                    $ddmenu=$db->getResult();
                    foreach($ddmenu as $line){
                        $main->setContent($line);
                    }
                    break;
            }
        }

        /**
         * genera la tabella di report e impagina i risultati
         * @param $query string la query che recupera i dati da inserire nella tabella
         */
        function report($query){

            global $db, $body;

            $body = new Template("../skins/minimal/dtml/report.html");

            $db->sanitize();

            $field_name=[];
            $where=" WHERE ";
            //recupero la struttura della tabella
            $db->query("SHOW COLUMNS FROM {$this->table}");
            $columns=$db->getResult();

            foreach($columns as $column){//se è un id lo ignoro
                if(substr($column['Field'],0,2)=="id"){
                    continue;
                }//costruisco la clausola where della query di ricerca
                $field_name[]=$column['Field'];
                $where.=" ".$column['Field']." LIKE '%{$_POST['search_query']}%' OR";
            }
            //caso particolare address e purchase
            if($this->table=='address' || $this->table=='purchase'){
                $where.=" user.email LIKE '%{$_POST['search_query']}%' OR";
            }
            $where=substr($where, 0, -2); //taglio l'ultimo "OR" che avanza

            //se voglio il report in base ad un criterio di ricerca
            if(isset($_POST['search_query'])){
                //in $query_section[0] ho tutta la query fino a ORDER BY escluso,
                //in $query_section[1] ho il contenuto della clausola ORDER BY
                $query_section=explode("ORDER BY", $query);
                //ricostruisco la query iniettando la clausola where prima di ORDER BY
                $query=$query_section[0].$where." ORDER BY ".$query_section[1];
            }

            //placeholder dell'input della search nella testata del report
            $placeholder="Insert: ";

            //costruisco il placeholder concatenando i vari campi della tabella
            for($i=0;$i<count($field_name);$i++){
                $placeholder.=$field_name[$i].", ";
            }
            //taglio l'ultimo ", " superfluo
            $placeholder=substr($placeholder, 0, -2);

            $body->setContent("searchplaceholder","$placeholder");

            //dimensione singola pagina, è salvata nella classe system come attributo di classe (classe system.inc)
            $psize=$this->psize_admin;

            //totale entry nella tabella con clausola where opzionale (classe dbms.inc)
            $totentry=$db->getNumEntry($this->table, "");

            //calcola numero totale di pagine (classe system.inc)
            $numpages=$this->getNumPages($totentry);

            //metto nella pagina html i pulsanti per cambiare pagina, torna il numero di pagina attuale
            $pn=$body->setPageButtons($numpages);

            $db->query($query." LIMIT ".($pn-1)*$psize.", ".$psize);
            $data = $db->getResult();

            //controlla se ci sono errori, se si manda alla pagina error con error=argomento passato (classe dbms.inc)
            $db->checkErrors("report");

            if($db->getNumRows()==0){
                $_SESSION['msg']="empty";
                Header("location: /readerscorner/admin/index.php");
                exit;
            }

            //dato il risultato della query
            //riempie la pagina di report (vedi template2.inc.php)

            $body->report($data);
        }

        /**
         * torna true se $string contiene almeno una occorrenza di $var, false altrimenti
         *
         * @param $string
         * @param $var
         * @return bool
         */
        function myStrpos($string, $var){
            if(strpos($string, $var)!==false)
                return true;
            else
                return false;
        }

        /**
         * interroga il database e ottiene la struttura della tabella interessata, genera automaticamente
         * la form per l'inserimento/modifica/eliminazione dei record
         * @param $table string
         * @param $mode string (edit_del per generare la form di eliminazione/modifica e add per
         * generare la form d'inserimento
         */
        function generateForm($table, $mode)
        {
            global $db, $body;

            //ottiene i metadati (field_data)
            $this->getMetadata();

            //utilizzata per il caso speciale di book
            $prechargedAuthors="";
            $prechargedAddress="";

            $body = new Template("../skins/minimal/dtml/add_edit_form.html");
            $body->setContent("operation", ucwords($mode));

            //delega l'inserimento dei pulsanti specificando la modalità
            $body->insertButtons($mode);

            //ottengo la struttura della tabella
            $db->query("SHOW COLUMNS FROM {$table}");
            $data = $db->getResult();
            $db->checkErrors("get");

            //setcontent testata del form
            $body->setContent("head", ($mode == "add") ?
                              "Add: " .ucwords(str_replace("_"," ",$table)) :
                              "Edit: " . ucwords(str_replace("_"," ",$table)));

            $get="";

            if ($mode == "edit_del") {//caso generazione form per edit/cancellazione
                //caso speciale book
                if($table=="book"){
                    $db->query("SELECT author.name as name
                                FROM writes 
                                LEFT JOIN author 
                                ON writes.id_author=author.id
                                WHERE writes.id_book = {$_GET['id']}");
                    $authors = $db->getResult();
                    $db->checkErrors("get");
                    $s="";
                    //ottengo l'elenco degli autori e li concateno
                    foreach($authors as $author){
                        $s.=$author['name'].";";
                    }
                    $s=rtrim($s, ";");
                    //contiene il value per precaricare il campo Authors del form di book
                    $prechargedAuthors="value=\"{$s}\"";

                }elseif($table=="address"){//caso speciale address
                    $db->query("SELECT user.email 
                                FROM address 
                                LEFT JOIN user 
                                ON address.id_user = user.id 
                                WHERE address.id={$_GET['id']}");
                    //contiene l'email dell'user proprietario dell'address
                    $prechargedAddress="value=\"{$db->getResult()[0]['email']}\"";
                }

                //goto è il placeholder che contiene l'indice di
                //pagina su cui si deve andare dopo aver inviato la form
                $body->setContent("goto", 2);

                //catturo i dati della tabella (generica)
                $db->query("SELECT * FROM {$table} WHERE id = {$_GET['id']}");
                $get = $db->getResult();//ottengo tutti i dati da inserire come valori nella form precaricata
                $db->checkErrors("get");
            }else{//caso generazione form per inserimento
                //goto è il placeholder che contiene l'indice di
                //pagina su cui si deve andare dopo aver inviato la form
                $body->setContent("goto", 5);
            }
                    //scorro tutti i campi della tabella
                    foreach($data as $field){
                        $required="";
                        $star=" ";
                        $precharged="";

                        //se il campo è obbligatorio aggiungo required e la * alla fine della label
                        if($field['Null']!="YES"){
                            $required="required";
                            $star=" *";
                        }

                        //mi metto da parte tipo, nome, label, placeholder, pattern e stile
                        //del campo input da generare
                        $type=$field['Type'];
                        $name=$field['Field'];
                        $label=($field['Field']).$star;
                        $placeholder=$this->placeholder[$field['Field']];
                        $pattern=$this->pattern[$field['Field']];
                        $style=$this->style[$field['Field']];

                        //se sto generando la form per l'edit/eliminazione
                        //pulisco i dati acquisiti
                        if($mode=="edit_del"){
                            $item=htmlentities($get[0][$name]);
                            $precharged="value=\"{$item}\"";
                        }

                        //tutti i campi numerici tranne le KEY
                        if($this->myStrpos($type, "int") ||
                           $this->myStrpos($field['Type'], "decimal") ||
                           $this->myStrpos($field['Type'], "float") ||
                           $this->myStrpos($field['Type'], "double")){

                                if($field['Key']==""){
                                    $body->insertInput($name, $label, $required , $placeholder,
                                        $pattern, "number", $precharged, $style);
                                }
                        }
                        //tutti i file (cover, photo, image)
                        elseif ($this->myStrpos($type, "varchar") && ($this->myStrpos($name, "cover") ||
                                $this->myStrpos($name, "photo") || $this->myStrpos($name, "image"))){


                            if($mode=="edit_del"){
                                $required="";
                                $label=str_replace(" *", " ", $label);

                                if($table=="book"){//caso particolare book
                                    $body->insertPic("current_cover","Current Cover",$get[0]['cover'], "cover");
                                    $body->insertHidden("old_cover", "value=\"{$get[0]['cover']}\"", "hiddenoldcover");

                                }elseif ($table=="author"){//caso particolare author
                                    $body->insertPic("current_photo","Current Photo",$get[0]['photo'],
                                                     "author",
                                        "<li>You can't delete an author before deleting all of his books. </li>");
                                    $body->insertHidden("old_photo", "value=\"{$get[0]['photo']}\"", "hiddenoldcover");

                                }elseif ($table=="slider"){//caso particolare slider
                                    $body->insertPic("current_image","Current Image",$get[0]['image'], "slider");
                                    $body->insertHidden("old_image", "value=\"{$get[0]['image']}\"", "hiddenoldcover");

                                }
                            }

                            $body->insertInput($name, $label, $required , $placeholder,
                                               $pattern, "file", $precharged, $style);
                        }
                        //email
                        elseif ($this->myStrpos($type, "varchar") && $this->myStrpos($name, "email")){
                            $body->insertInput($name, $label, $required , $placeholder,
                                               $pattern, "email", $precharged, $style);
                        }
                        //password
                        elseif ($this->myStrpos($type, "varchar") && $this->myStrpos($name, "password")){
                            if($mode=="edit_del"){//se il form è per l'edit/delete non mostro la password
                                continue;
                            }
                            $body->insertInput($name, $label, $required ,
                                               $placeholder, $pattern, "password", "", $style);

                        }
                        //tutte le altre varchar
                        elseif ($this->myStrpos($type, "varchar")){


                            if($name=="status" && $this->table=="purchase"){
                                continue;
                            }

                            $body->insertInput($name, $label, $required ,
                                               $placeholder, $pattern, "text", $precharged, $style);

                        }
                        //date
                        elseif ($this->myStrpos($type, "date")){
                            $body->insertInput($name, $label, $required ,
                                               $placeholder, $pattern, "date", $precharged, $style);

                        }
                        //tutti gli altri text
                        elseif ($this->myStrpos($type, "text")){
                            $body->insertInput($name, $label, $required ,
                                               $placeholder, $pattern,"textarea", $get[0][$name], $style);

                        }
                    }
                    //caso particolare author di book gestito a parte
                    if($table=="book"){
                        $body->insertInput("author", "Authors *", "required" ,
                            "placeholder= \"Use ';' to separate authors: First Author;Second Author;Third Author\"",
                            "", "text", $prechargedAuthors, "width: 75%;");

                    }elseif($table=="address"){//caso particolare address
                        $body->insertInput("email", "User Email *", "required" , "","",
                            "email", $prechargedAddress, "width: 30%;");

                    }elseif($table=="purchase"){
                        $body->addBlank("notesPurchase","<p style='font-size:80%'><b>Warning!</b>
                                                         <br>Deleting an order through the \"Delete\" 
                                                         button will actually delete the oorder in the database, 
                                                         if you just want to <b>cancel</b> 
                                                         the order change its status to <b>\"Canceled\"</b>.
                                                         <br>Other available status are: 
                                                         <b>\"In preparation\", \"Shipped\", \"Delivered\"</b></p> 
                                                         </p>");
                        $body->setContent("extraStyleContainer","margin-top:10px;");
                    }

                    //input type hidden contenente l'id del record
                    $body->insertHidden("id", "value=\"{$get[0]['id']}\"", "hidden");
        }

        /**
         * metodo che lancia query e gestisce errori e pagine di ritorno su successo,
         * genera automaticamente alcuni tipi di query
         *
         * @param $query string se =="auto" il metodo genera la query automaticamente
         * @param $table string  tabella interessata dalla query
         * @param $back int pagina nella quale bisogna redirezionare l'utente dopo il success
         * @param $mode string usata in caso di query=="auto" per generare le query di aggiunta/eliminazione/edit
         */
        function transaction($query, $table, $back, $mode){

            global $db;

            if($query=="auto"){
                $db->query("SHOW COLUMNS FROM {$table}");
                $columns=$db->getResult();

                $db->sanitize();

                switch($mode){

                    case "delete"://caso generazione query delete
                        $query="DELETE FROM {$table} WHERE id={$_GET['id']}";
                        break;

                    case "insert"://caso generazione query insert
                        if($table=="user"){//caso user, faccio l'md5 della password
                            $_POST['password']=md5($_POST['password']);
                        }
                        $query="INSERT INTO {$table} VALUES(NULL, ";
                        if($table=="address"){//caso particolare address
                            $query.="NULL, ";
                        }
                        //scorro le colonne della tabella e genero la query
                        foreach ($columns as $column){
                            //se è un id lo ignoro
                            if($column['Field']=="id"){
                                continue;
                            }
                            //se è id_user lo ignoro
                            if($column['Field']=="id_user"){
                                continue;
                            }
                            $query.="'{$_POST[$column['Field']]}', ";
                        }
                        //taglio l'utimo ", "
                        $query=rtrim($query, ", ");
                                  //chiudo la query
                        $query.=")";
                        break;

                    case "update"://caso generazione query update
                        if($table=="user"){
                            $_POST['password']=md5($_POST['password']);
                        }
                        $query="UPDATE {$table} SET ";
                        foreach ($columns as $column){
                            if($column['Field']=="id" || $column['Field']=="password"){
                                continue;//ignoro campi id e password
                            }
                            $query.=$column['Field']." = "."'{$_POST[$column['Field']]}', ";
                        }
                        $query=rtrim($query, ", ");
                        $query.=" WHERE id= {$_POST['id']}";
                        break;
                }
            }
            $db->query($query);
            $db->checkErrors($mode);
            $db->OKgoBack($table, $back);
        }

        /**
         * genera e lancia le query di aggiunta/eliminazione delle relazioni
         *
         * @param $target string tabella che contiene la relazione
         * @param $idfirst int valore dell'id del record della prima tabella
         * @param $idsecond int come sopra ma per la seconda tabella
         * @param $mode string definisce se si vuole aggiungere o eliminare
         */
        function addXtoY($target, $idfirst, $idsecond, $mode, $gotoadd="10", $gotodel="12"){
            global $db;
            switch($mode){
                case "add":
                    $this->transaction("INSERT INTO {$target} VALUES({$idfirst}, {$idsecond})",
                                        $this->table,$gotoadd,"referential_constraint");
                    break;
                case "del":
                    $db->query("SHOW COLUMNS FROM {$target}");
                    $res=$db->getResult();
                    $id=[];

                    //scorro tutti i campi e catturo gli id
                    foreach($res as $field){
                        if(substr($field['Field'],0,3)=="id_"){
                            $id[]=$field['Field'];

                            //appena trovo i primi 2 esco
                            if(count($id)==2){
                                break;
                            }
                        }
                    }
                    //id[0] contiene l'id il primo id, id[1] il secondo
                    $this->transaction("DELETE FROM {$target} 
                                        WHERE {$id[0]} = {$idfirst} 
                                        AND {$id[1]} = {$idsecond}",
                                        $this->table,$gotodel,"referential_constraint");
                    break;
            }
        }

        /**
         * genera la form con 2 sselect per la gestione delle relazioni
         *
         * @param $first string contiene il nome della prima tabella
         * @param $second string contiene il nome della seconda tabella
         * @param $firstvalue string contiene il nome del campo da visualizzare nella select
         * @param $secondvalue string come sopra ma per la seconda tabella
         * @param $mode string specifica se si deve generare la form per l'eliminazione o l'inseriemnto
         * @target string è il nome della tabella che contiene i dati della relazione, opzionale
         */
        function generateSelect($first, $second, $firstvalue, $secondvalue, $mode, $target="",
                                $gotoadd="11", $gotodel="13", $query=""){
            global $db, $body;

            switch($mode) {
                case "add"://caso aggiunta relazione tra $first e $second
                    $body->setContent("head", "Select the items to bind: ");
                    $body->setContent("goto", $gotoadd);

                    //ottengo i valori da inderire nelle select
                    $db->query("SELECT id, {$firstvalue} FROM {$first} ORDER BY {$firstvalue}");
                    $result_first = $db->getResult();

                    $db->query("SELECT id, {$secondvalue} FROM {$second} ORDER BY {$secondvalue}");
                    $result_second = $db->getResult();

                    $options_first = [];
                    //genero gli array associativi options: [id]=>[valore]
                    foreach ($result_first as $key => $values) {
                        $options_first[$values['id']] = $values[$firstvalue];
                    }
                    $options_second = [];
                    foreach ($result_second as $key => $values) {
                        $options_second[$values['id']] = $values[$secondvalue];
                    }
                    //inserisco i 2 input type select
                    $body->insertSelect($first, $options_first, "select1");
                    $body->insertSelect($second, $options_second, "select2");

                    $body->insertButtons("add", "Bind");
                    break;

                case "del"://caso rimozione relazione tra $first e $second

                    //genero select per il primo step dell'eliminazione
                    if($_REQUEST['page']==12 || $_REQUEST['page']==22){
                        $body->setContent("head", "Select the first item to unbind: ");
                        $body->setContent("goto", $gotodel);

                        $db->query("SELECT id, {$firstvalue} FROM {$first} ORDER BY {$firstvalue}");
                        $result_first = $db->getResult();

                        $options_first = [];
                        foreach ($result_first as $key => $values) {
                            $options_first[$values['id']] = $values[$firstvalue];
                        }

                        $body->insertSelect($first, $options_first, "select1");
                        $body->insertButtons("proceed");
                    //genero select per il secondo step dell'eliminazione
                    }elseif($_REQUEST['page']==13 || $_REQUEST['page']==23){
                        $body->setContent("head", "Select the second item: ");
                        $body->setContent("goto", $gotodel+1);

                        if($first=="groups"){//casi particolari
                            $db->query("SELECT {$second}.id, {$second}.{$secondvalue} 
                                        FROM {$target} 
                                        LEFT JOIN {$second} 
                                        ON {$target}.id_{$second} = {$second}.id
                                        WHERE {$target}.id_group = {$_POST['groups']} 
                                        ORDER BY {$second}.{$secondvalue}");
                        }elseif ($second=="groups"){
                            $db->query("SELECT groups.id, groups.{$secondvalue} 
                                        FROM {$target} 
                                        LEFT JOIN groups
                                        ON {$target}.id_group = groups.id
                                        WHERE {$target}.id_{$first} = {$_POST[$first]} 
                                        ORDER BY groups.{$secondvalue}");
                        }elseif($query!=""){
                            $db->query($query);
                        }else{
                            $db->query("SELECT {$second}.id, {$second}.{$secondvalue} 
                                        FROM {$target} 
                                        LEFT JOIN {$second} 
                                        ON {$target}.id_{$second} = {$second}.id
                                        WHERE {$target}.id_{$first} = {$_POST[$first]} 
                                        ORDER BY {$second}.{$secondvalue}");
                        }

                        $result_second=$db->getResult();

                        //costruisco ooptions
                        $options_second = [];
                        foreach ($result_second as $key => $values) {
                            $options_second[$values['id']] = $values[$secondvalue];
                        }
                        $db->query("SELECT id, {$firstvalue} FROM {$first} WHERE id={$_POST[$first]}");
                        $res=$db->getResult();

                        $opt=array($res[0]['id']=>$res[0][$firstvalue]);

                        //inserisco la prima select come disabled (nello step 2 il primo campo è congelato
                        $body->insertSelect($first, $opt, "select1", "disabled", "color: silver;");
                        $body->insertHidden($first, "value=\"{$res[0]['id']}\"", "hidden");
                        //inserisco la seconda select
                        $body->insertSelect($second, $options_second, "select2");
                        $body->insertButtons("del2");
                    }
                    break;
            }
        }
    }
    $system = new System();

?>