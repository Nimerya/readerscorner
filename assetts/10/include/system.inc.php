<?php

    Class System {
        var
            $table,
            $operation;
        
        function System() {
            
            if (preg_match("+^([a-z]{1,})_([a-z]{1,})\.php$+", basename($_SERVER['SCRIPT_NAME']), $matches)) {
                $this->table = $matches[1];
                $this->operation = $matches[2];
  
            } else {
                $this->table = "";
                $this->operation = "";
            }
        }
        
        function getTable() {
            return $this->table;
        }
        
        function getOperation() {
            return $this->operation;
        }
        
    }
    
    $system = new System();


?>