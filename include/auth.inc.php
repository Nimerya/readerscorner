<?php

    Class Auth {
         
        function Login()
        {

            global $db, $data;

            if (isset($_SESSION['auth'])) {

                //utente già autenticato

            } else {
                //check credenziali
                $db->query("SELECT * FROM user 
                                WHERE email = '{$_POST['email']}' 
                                AND password = MD5('{$_POST['password']}')");

                if (!$db->isError()) {
                    //se ho un unico risultato (caso success)
                    if ($db->getNumRows() == 1) {
                        $data = $db->getResult();
                        //carico in sessione i dati dell'user
                        $_SESSION['auth'] = $data[0];
                        //ottengo i dati relativi ai servizi a cui ha accesso
                        $db->query("SELECT user.id, 
                                               groups.id, 
                                               service.name, 
                                               service.icon
                                          FROM user
                                     LEFT JOIN usergroup
                                            ON user.id = usergroup.id_user
                                     LEFT JOIN groups
                                            ON groups.id = usergroup.id_group
                                     LEFT JOIN groupservice
                                            ON groupservice.id_group = groups.id
                                     LEFT JOIN service
                                            ON service.id = groupservice.id_service
                                         WHERE user.email = '{$_POST['email']}'");

                        $db->checkErrors('login');

                        $services = $db->getResult();
                        //carico in sessione i servizi
                        foreach ($services as $service) {
                            $_SESSION['auth']['service'][$service['name']] = true;
                        }

                    } else { //abbiamo più o meno di 1 risultato
                        Header("Location: /readerscorner/error.php?error=login");
                        exit;
                    }

                } else { //errore query login
                    Header("Location: /readerscorner/error.php?error=system");
                    exit;
                }
            }//utente già loggato
        }

        /**
         * controlla che l'user abbia i permessi per utilizzare la pagina in cui si trova,
         * oppure si può passare il nome del servizio direttamente
         * @param string $service parametro opzionale che indica il servizio da controllare
         * @return bool torna true se l'user ha il permesso per il servizio passato, false altrimenti,
         *              se non si passa il servizio in caso di esito negativo l'user viene reindirizzato alla
         *              pagina di errore
         */
        function checkPermission($service=""){
            if($service==""){
                if (!isset($_SESSION['auth']['service'][basename($_SERVER['SCRIPT_NAME'])])) {
                    Header("Location: /readerscorner/error.php?error=permission");
                    exit;
                }
            }else{
                    return isset($_SESSION['auth']['service'][$service]);
                }
                return false;
            }

        /**
         * controlla che l'utente appartiene al gruppo passato (nome)
         * @param $group string nome del gruppo
         * @return bool true se l'user appartiene al gruppo, false altrimenti
         */
        function belongsToGroup($group){
            global $db;
            $userid=$this->isLogged();
            $db->query("SELECT COUNT(*) AS num FROM groups 
                                LEFT JOIN usergroup ON groups.id=usergroup.id_group
                                LEFT JOIN user ON usergroup.id_user = user.id 
                                WHERE user.id={$userid} AND groups.name='{$group}'");

            return $db->getResult()[0]['num']>0;
        }

        /**
         * imposta link giusti nella homepage del frontend se l'user è loggato
         */
        function setAuthButtons(){
            global $main;
            if(isset($_SESSION['auth']['name'])){//se l'user è loggato
                $main->setContent("loginout", "<li><a href=\"logout.php\">LogOut</a></li>");
                $main->setContent("welcome", "<p>Welcome <strong>".$_SESSION['auth']['name'].
                                             "</strong> to <strong>The Reader's Corner!</strong></p>");
                //se l'user ha accesso al backend ne mostro il link
                if($_SESSION['auth']['service']['index.php']){
                    $main->setContent("admin", "<li><a href=\"admin/index.php\">Admin Panel</a></li>");
                }
            }else{//controllo qui se l'user non è loggato
                $main->setContent("hideUserbar", "display:none;");
                $main->setContent("loginout", "<li><a href=\"login.php\">LogIn</a></li>".
                                              " <li><a href=\"signup.php\">SignUp</a></li>");
            }

        }

        /**
         * @return mixed array dei servizi a cui ha accesso l'user attualmente loggato
         */
        function getScripts(){
            return $_SESSION['auth']['service'];
        }

        /**
         * @return mixed torna l'id dell'user se questo è loggato
         */
        function isLogged(){
            return ($_SESSION['auth']['id']);
        }

        /**
         * @return mixed array associativo [servizio]=>[icona]
         */
        function getIcons(){
           global $db;
           //acquisisco icone dei servizi
           $db->query("SELECT name, icon FROM service");
           $data=$db->getResult();
           foreach ($data as $line){
               $icons[$line['name']]=$line['icon'];
           }
           return $icons;
        }
    }
    
    $auth=new Auth();

?>