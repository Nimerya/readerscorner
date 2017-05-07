<?php

define("UNCONNECTED", "UNCONNECTED");
define("CONNECTED", "CONNECTED");
define("ERROR", "ERROR");


Class dbms
{

    var
        $host,
        $user,
        $pass,
        $name,
        $status,
        $link,
        $handle,
        $error;


    function DBMS($host, $user, $pass, $name)
    {
        $this->host = $host;
        $this->user = $user;
        $this->pass = $pass;
        $this->name = $name;
        $this->status = UNCONNECTED;
    }

    /**
     * instaura connessione al db
     */
    function connect()
    {
        $this->link = mysqli_connect($this->host, $this->user, $this->pass, $this->name);
        if ($this->link) {
            $this->status = CONNECTED;
        } else {
            $this->status = ERROR;
        }
    }

    /**
     * controlla se ci sono errori dopo l'esecuzione di una query
     * @param $error string errore da utilizzare nella redirezione
     * @param string $mode string indica se l'invocazione è stata fatta da backoffice o meno
     * @param string $back string opzionale, indirizzo completo del fallback
     */
    function checkErrors($error,$mode="backoffice",$back="/readerscorner/admin/error.php?error=")
    {
        if ($this->isError()) {//se c'è un errore
            $_SESSION['err_desc']=$this->error;//catturo la sua descrizione
            $_SESSION['msg'] = "KO";//imposto il messaggio a KO
            if($mode=="backoffice"){//se la funzione è stata chiamata da backoffice
                //redireziono alla pagina di errore del backoffice
                Header("location: {$back}{$error}");
            }else{//altrimenti
                if($back!="/readerscorner/admin/error.php?error=") {
                    //se ho specificato un back diverso da quello di default
                    Header("location: {$back}");
                }else{
                    //altrimenti riporto alla pagina di errore del frontoffice
                    Header("location: /readerscorner/error.php?error={$error}");
                }
            }
            exit;
        }
    }

    /**
     * @return mixed string ultimo errore avvenuto
     */
    function getLastError(){
        return $this->error;

    }

    /**
     * @return bool true se c'è un errore, false altrimenti
     */
    function isError(){
        return ($this->status == ERROR);
    }

    /**
     * invocato in caso di successo redireziona a una pagina specificata
     * @param $page string nome della pagina in cui si verrà redirezionati
     * @param $number int step della pagina in cui tornare
     * @param string $msg messaggio da mostrare all'utente
     * @param string $fullredirect opzionale, permette di specificare il path
     */
    function OKgoBack($page, $number,$msg="OK",$fullredirect="")
    {
        $_SESSION['msg'] = $msg;
        if($fullredirect==""){//se non ho specificato un path
            Header("Location: {$page}.php?page={$number}");
        }else{//se ho specificato un path
            Header("Location: {$fullredirect}");
        }
        exit;
    }

    /**
     * @return bool true se la connessione è avvenuta con successo, false altrimenti
     */
    function isConnected()
    {
        return ($this->status == CONNECTED);
    }

    /**
     * pulisce i dati in POST, pulisce invece $target se specificato
     * @param string $target stringa da pulire
     * @return string stringa pulita
     */
    function sanitize($target = "")
    {
        foreach ($_POST as $key => $value) {
            $_POST[$key] = addslashes($value);
        }
        return addslashes($target);
    }

    /**
     * @return int numero di righe della query appena lanciata
     */
    function getNumRows()
    {
        return mysqli_num_rows($this->handle);
    }

    /**
     * torna il numero di entry della tabella passata
     * @param $table string nome della tabella da interrogare
     * @param $where string clausola where
     * @return mixed numero di entry
     */
    function getNumEntry($table, $where)
    {
        $this->query("SELECT COUNT(*) as n FROM {$table} {$where}");
        return $this->getResult()[0]['n'];
    }

    /**
     * lancia la query passata per argomento
     * @param $query string query
     */
    function query($query)
    {
        $this->handle = mysqli_query($this->link, $query);

        if (!$this->handle) {
            $this->status = ERROR;
        } else {
            $this->status = CONNECTED;
        }

        $this->error= mysqli_error($this->link);
    }

    /**
     * inizializza una transazione
     */
    function beginTransaction(){
        $this->query("SET AUTOCOMMIT=0");
        $this->query("START TRANSACTION");
    }

    /**
     * effettua il commit, usata dopo beginTransaction()
     */
    function commit(){
        $this->query("COMMIT");
    }

    /**
     * effettua il rollback
     */
    function rollBack(){
        $this->query("ROLLBACK");
    }

    /**
     * @return array|bool array contenente i risultati della query
     * lanciata oppure false se non ci sono risultati
     */
    function getResult()
    {
        $result = false;
        do {
            $data = mysqli_fetch_assoc($this->handle);
            if ($data) {
                $result[] = $data;
            }
        } while ($data);
        return $result;
    }
}

$db = new DBMS("localhost", "root", "root", "readerscorner");
$db->connect();

if (!$db->isConnected()) {
    Header("Location: error.php?error=db_connection");
    exit;
}

?>