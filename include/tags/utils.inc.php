<?php

Class utils extends TagLibrary {

    var $icons;

    function dummy(){

    }

    function shorter($name, $data, $pars){
        //non c'è bisogno di trim, è già più corta del limite
        if (strlen($data) <= $pars['length']) {
            return $data;
        }

        //trovo l'ultimo spazio utile
        $last_space = strrpos(substr($data, 0, $pars['length']), ' ');
        if(!$last_space) $last_space = $pars['length'];
        $trimmed_text = substr($data, 0, $last_space);

        //aggiungo (...)
        $trimmed_text .= '...';

        return $trimmed_text;
    }

    function replace($name, $data, $pars){
        return str_replace("\\","",$data);
    }

    function checkavg($name, $data, $pars){
        if($data <= 0 || $data > 5){
            return "not available";
        }
        return "<b>".$data."</b>/5";
    }

    function cutnumber($name, $data, $pars){
        return "xxxx-xxxx-xxxx-".substr($data,-4);
    }

    function isempty($name, $data, $pars){
        return (($data=="") ? "not available" : $data);
    }

    function checkavailability($name, $data, $pars){
        if($data > $pars['amount']){
            return "in stock";
        }elseif($data == 0){
            return "out of stock";
        }else{
            return "low";
        }
    }

    function uppercase($name, $data, $pars){
        return ucwords(str_replace("_", " ",$data));
    }

    /**
     * @param $name
     * @param $data
     * @param $pars
     * @return string
     */
    function insertops ($name, $data, $pars){
        global $auth;
        $return="";
        $services=$auth->getScripts();
        //ordina array per chiave
        ksort($services);
        $icons=$auth->getIcons();
        foreach($services as $key=>$value){
            if($key=="index.php")
                continue;
            $return.=$this->createops($key,$icons[$key]);
        }
        return $return;
    }

    function createops($name, $icon){
        $name=str_replace(".php","",$name);
        $nameaux=$name;

        if($name=="purchase"){
            $nameaux="orders";
        }

        $nameuc=ucwords(str_replace("_"," ",$nameaux));

        $return ="<li>
                    <a style=\"cursor: pointer;\" class=\" hvr-bounce-to-right\">
                        <i class=\"fa {$icon} nav_icon\"></i> 
                        <span class=\"nav-label\">{$nameuc}</span>
                        <span class=\"fa arrow\"></span>
                    </a>
                    
                    <ul class=\"nav nav-second-level\">
                       <li>
                            <a href=\"{$name}.php?page=4\" class=\" hvr-bounce-to-right\" >
                                &nbsp&nbsp&nbsp
                                <i class=\"fa fa-plus-square nav_icon \"></i>
                                <i style='font-size:12px;'>Insert</i>
                            </a>
                       </li>
                       
                       <li>
                            <a href=\"{$name}.php?page=0\" class=\"hvr-bounce-to-right\" >
                                &nbsp&nbsp&nbsp
                                <i class=\"fa fa-edit nav_icon\"></i>
                                <i style='font-size:12px;'>Report/Edit/Delete</i>
                            </a>
                       </li>";

        if($name=="category"){
            $return.= "<li>
                        <a href=\"{$name}.php?page=10\" class=\"hvr-bounce-to-right\" >
                            &nbsp&nbsp&nbsp
                            <i class=\"fa fa-arrow-circle-right nav_icon\"></i>
                            <i style='font-size:12px;'>Bind book</i>
                        </a>
                       </li>";
            $return.= "<li>
                        <a href=\"{$name}.php?page=12\" class=\"hvr-bounce-to-right\" >
                            &nbsp&nbsp&nbsp
                            <i class=\"fa fa-arrow-circle-left nav_icon\"></i>
                            <i style='font-size:12px;'>Unbind book</i>
                        </a>
                      </li>";

        }elseif($name=="groups"){
            $return.= "<li>
                        <a href=\"{$name}.php?page=10\" class=\"hvr-bounce-to-right\" >
                            &nbsp&nbsp&nbsp
                            <i class=\"fa fa-arrow-circle-right nav_icon\"></i>
                            <i style='font-size:12px;'>Bind service</i>
                        </a>
                       </li>";

            $return.= "<li>
                        <a href=\"{$name}.php?page=12\" class=\"hvr-bounce-to-right\" >
                            &nbsp&nbsp&nbsp
                            <i class=\"fa fa-arrow-circle-left nav_icon\"></i>
                            <i style='font-size:12px;'>Unbind service</i>
                        </a>
                       </li>";

            $return.= "<li>
                        <a href=\"{$name}.php?page=20\" class=\"hvr-bounce-to-right\" >
                            &nbsp&nbsp&nbsp
                            <i class=\"fa fa-thumbs-o-up nav_icon\"></i>
                            <i style='font-size:12px;'>Bind user</i>
                        </a>
                      </li>";

            $return.= "<li>
                        <a href=\"{$name}.php?page=22\" class=\"hvr-bounce-to-right\" >
                            &nbsp&nbsp&nbsp
                            <i class=\"fa fa-thumbs-o-down nav_icon\"></i>
                            <i style='font-size:12px;'>Unbind user</i>
                        </a>
                       </li>";

        }elseif($name=="purchase") {
            $return ="<li>
                        <a style=\"cursor: pointer;\" class=\" hvr-bounce-to-right\">
                            <i class=\"fa {$icon} nav_icon\"></i> 
                            <span class=\"nav-label\">{$nameuc}</span>
                            <span class=\"fa arrow\"></span>
                        </a>
                        <ul class=\"nav nav-second-level\">
                            <li>
                                <a href=\"{$name}.php?page=0\" class=\"hvr-bounce-to-right\" >
                                &nbsp&nbsp&nbsp
                                <i class=\"fa fa-edit nav_icon\"></i>
                                <i style='font-size:12px;'>Report/Edit/Delete</i>
                                </a>
                            </li>";
        }

        return $return."</ul>
               </li>";

    }

    function format($name, $data, $pars) {


        $y = substr($data, 0, 4);
        $m = substr($data, 5, 2);
        $d = substr($data, 8, 2);

        if($y==0 && $m==0 & $d==0){
            return "not available";
        }
        return "$d/$m/$y";
    }

}

?>