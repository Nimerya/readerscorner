<?php

     session_start();
    
     require("include/dbms.inc.php");
     require("include/system.inc.php");
     require("include/template2.inc.php");
     #require("include/auth.inc.php");
      
     $main = new Template("skins/gaia/dtml/frame_public.html");
     $body = new Template("skins/gaia/dtml/login.html");
     
     $body->setContent("name", $data[0]['name']);
     
     $main->setContent("body", $body->get());
     $main->close();
     
    
?>


