<?php

define("UNCONNECTED", "UNCONNECTED");
define("CONNECTED", "CONNECTED");
define("ERROR", "ERROR");


Class DBMS {
     
    var
    $host,
    $user,
    $pass,
    $name,
    $status,
    $link,
    $handle;
     
    function DBMS($host, $user, $pass, $name) {
         
        $this->host = $host;
        $this->user = $user;
        $this->pass = $pass;
        $this->name = $name;
         
        $this->status = UNCONNECTED;
    }
     
    function connect() {
         
        $this->link = mysqli_connect($this->host, $this->user, $this->pass, $this->name);
         
        if ($this->link) {
            $this->status = CONNECTED;
        } else {
            $this->status = ERROR;
        }
         
    }
     
    function isConnected() {
        return ($this->status == CONNECTED);
    }
     
    function isError() {
        return ($this->status == ERROR);
    }
     
    function query($query) {
         
        $this->handle = mysqli_query($this->link, $query);
         
        if (!$this->handle) {
             
            $this->status = ERROR;
        } else {
             
            $this->status = CONNECTED;
        }
    }
     
    function getResult() {
         
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
 
/* ------- */
   
   
     $db = new DBMS("localhost", "root", "viva1felice", "tdw1617_2");
     $db->connect();
     
     if ($db->isConnected()) {
         
         
        if (preg_match("+^([a-z]{1,})_([a-z]{1,})\.php$+", basename($_SERVER['SCRIPT_NAME']), $matches)) {
            
            switch ($matches[2]) {
                case 'add':
                    echo "INSERT INTO {$matches[1]} VALUES (NULL,{$_POST['position']},'{$_POST['name']}','{$_POST['description']}')";
                break;
                case 'edit':
                    echo "{$matches[1]} -- edit/save";
                break;
                case 'del':
                    echo "{$matches[1]} -- delete";
                break;
            }
        }   
     }
    
    
?>


