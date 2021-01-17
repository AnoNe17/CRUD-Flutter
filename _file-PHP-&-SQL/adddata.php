<?php 
    include 'config.php';

    //Mengambil data yang dikirim melalui method POST
    //kemudian mengubahnya kedalam variabel
    //variabel ini nantinya akan digunakan untuk query
    $nama = $_POST['nama'];
    $pass = $_POST['pass'];

    //mengirim query kedalam database
    //$connect adalah variabel yang menyambungkan ke databse yang diambil dari include 'config.php
    $connect -> query ("INSERT INTO user VALUES ('','$nama','$pass')");
    //query ini nanti akan dijalankan pada database
?>