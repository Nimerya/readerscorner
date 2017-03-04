<?php

     require("include/dbms.inc.php");
     require("include/system.inc.php");
     require("include/template2.inc.php");
     
     $main = new Template("skins/nevia/dtml/frame-public.html");
     $body = new Template("skins/nevia/dtml/home.html");
     
     
     $main->setContent("body", $body->get());
     $main->close();
     
    
?>


