<?php

//variabel connect adalah menyambungkan ke database dengan nama database api
$connect = new mysqli("localhost", "root", "", "api");

    //penanganan error jika database tidak nyambung
    if($connect){
    }
    else{
        echo " NOOOOO";
    }
?>