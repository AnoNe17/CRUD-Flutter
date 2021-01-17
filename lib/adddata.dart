import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:http/http.dart' as http;

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {

  //Dijadikan Object pada setiap controller yang akan digunakan
  //disini kita memakai controllerNama .. Yang di gunakan pada TextField dengan controller : controllerNama
  //begitu juga seterusnya
  TextEditingController controllerNama = new TextEditingController();
  TextEditingController controllerPass = new TextEditingController();

  void addData(){
    //mengirimkan data 'nama' dan 'pass' ke localhost nama folder dan nama file dengan metode POST
    //variabel 'nama' mengambil data dari TEXT dari (id) controllerNama dan mengirimkannya ke file php untuk menambah data
    //di file PHP addData nya sendiri mengambil data 'nama' dan 'pass' yang diambil dari sini
    //kemudian memasukannya ke dalam database dengan query yang sudah ada
    var url = "http://192.168.0.200/belajar_crud_flutter/adddata.php";
    http.post(url, body: {
      "nama" : controllerNama.text,
      "pass" : controllerPass.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Nambah Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: new ListView(
          children: <Widget>[
            //menggunakan kolom
            new Column(
              children: <Widget>[
                //menggunakan TextField dengan dekorasi pada Textfield ada hintText dan juga label
                new TextField(
                  //controller ini jika di ibaratkan seperti membaeri id/nama variabel pada TextField ini
                  //yang nanti akan digunakan untuk inputan
                  controller : controllerNama,
                  decoration: new InputDecoration(
                      hintText: "nama",
                      labelText: "nama"
                  ),
                ),
                new TextField(
                  //controller ini jika di ibaratkan seperti membaeri id/nama variabel pada TextField ini
                  //yang nanti akan digunakan untuk inputan
                  controller : controllerPass,

                  decoration: new InputDecoration(
                      hintText: "pass",
                      labelText: "pass"
                  ),
                ),
                new Padding(padding: const EdgeInsets.all(10.0),),

                //Membuat tombol Tambah Data
                new RaisedButton(
                  child: new Text("Tambah Data"),
                  color: Colors.blueAccent,
                  onPressed: (){
                    //memanggil fungsi addData() pada line 18
                    addData();
                    //Menggunakan Navigator.push agar ketika kita memanggil class . Maka aplikasi akan hot raload (refresh) dengan otomatis
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => new MyApp()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
