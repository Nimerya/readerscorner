<?php
    session_start();
    session_destroy();

    session_start();
    $_SESSION['msg']="OK-logout";
    Header("Location: index.php");
    exit;

?>