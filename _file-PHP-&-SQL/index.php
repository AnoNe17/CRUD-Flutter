<?php

    //memanggil file config.php yang isinya menyambungkan ke database
    include 'config.php';

    //mengambil semua data pada tabel user
    $queryResult = $connect -> query ("SELECT * FROM user");

    $result = array();

    //memasukan data queryResult menjadi variabel fetchData kemudian memasukannya kedalam array
    //yang dimana array tersebut bervariabel result
    while ($fetchData = $queryResult->fetch_assoc()){
        $result[]=$fetchData;
    }

    //merubah array menjadi JSON
    echo json_encode($result);
?>