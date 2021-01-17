import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:http/http.dart' as http;

class EditData extends StatefulWidget {

  //constructor ini untuk mengambil data yang dikirim dari detail.dart
  //untuk kemudian merubah TextField nama dan pass menjadi data yang tadi kita kirim dari detail.dart
  final List list;
  final int index;

  EditData({this.list, this.index});

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {

  //Dijadikan Object pada setiap controller yang akan digunakan
  //disini kita memakai controllerNama .. Yang di gunakan pada TextField dengan controller : controllerNama
  //begitu juga seterusnya
  TextEditingController controllerNama;
  TextEditingController controllerPass;

  //mengirimkan data 'id' 'nama' 'pass' ke localhost nama folder dan nama file dengan metode POST
  //variabel 'nama' mengambil data dari TEXT dari (id) controllerNama dan mengirimkannya ke file php untuk menambah data
  //di file PHP editdata nya sendiri mengambil data 'id' 'nama' 'pass' yang diambil dari sini
  //kemudian memasukannya ke dalam database dengan query yang sudah ada
  //['id']
  void editData(){
    var url = "http://192.168.0.200/belajar_crud_flutter/editdata.php";
    http.post(url, body: {
      "id" : widget.list[widget.index]['id'],
      "nama" : controllerNama.text,
      "pass" : controllerPass.text,
    });
  }

  @override
  void initState() {
    //untuk MENGISI TEXT pada controller nama dan pass dengan data yang dikirim detail.dart
    controllerNama = new TextEditingController(text: widget.list[widget.index]['nama']);
    controllerPass = new TextEditingController(text: widget.list[widget.index]['pass']);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Edit Data Lurr :'v"),),
      //isi body untuk inputan dan pengertiannya Sama seperti addData()
      // Coba lihat di file adddata.dart
      //yang beda ada pada buttonnya textnya adalah "Edit Data" dan ketika di klick akan memanggil fungsi editdata()
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: new ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new TextField(
                  controller : controllerNama,
                  decoration: new InputDecoration(
                      hintText: "nama",
                      labelText: "nama"
                  ),
                ),
                new TextField(
                  controller : controllerPass,
                  decoration: new InputDecoration(
                      hintText: "pass",
                      labelText: "pass"
                  ),
                ),
                new Padding(padding: const EdgeInsets.all(10.0),),
                new RaisedButton(
                  child: new Text("Edit Data"),
                  color: Colors.blueAccent,
                  onPressed: (){
                    editData();
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
