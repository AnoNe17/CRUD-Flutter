<?php 
    include 'config.php';

    //Mengambil data yang dikirim melalui method POST
    //kemudian mengubahnya kedalam variabel
    //variabel ini nantinya akan digunakan untuk query
    $id   = $_POST['id'];
    $nama = $_POST['nama'];
    $pass = $_POST['pass'];

    //mengirim query kedalam database
    //$connect adalah variabel yang menyambungkan ke databse yang diambil dari include 'config.php
    $connect -> query ("UPDATE user SET id='$id', nama='$nama', pass='$pass' WHERE id='$id'");
    //query ini nanti akan dijalankan pada database
?>