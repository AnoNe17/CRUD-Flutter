import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import './editdata.dart';
import 'package:http/http.dart' as http;

class Detail extends StatefulWidget {

  //constructor list dan index untuk MENGAMBIL data dari cardView pada main.dart yang tadi kita tap
  final List list;
  // LIST DISINI ADALAH SEMUA DATA .. TERMASUK KOLOM YAKNI ['id'],['nama'],['pass']

  final int index;
  Detail({this.index,this.list});


  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {

  void deleteData(){
    //mengirimkan data id ke localhost nama folder dan nama file dengan metode POST
    //variabel 'id' mengambil dari data list yang tadi kita klick
    //di file PHP DeleteData nya sendiri mengambil data "id" yang diambil dari sini
    //kemudian menghapusnya dengan query WHERE 'id'
    var url = "http://192.168.0.200/belajar_crud_flutter/deletedata.php";
    http.post(url, body: {
      'id' : widget.list[widget.index]['id']
    });
  }

  //fungsi ini seperti peringatan untuk menanyakan kembali apakah ingin dihapus
  void confirm(){
    AlertDialog alertDialog = new AlertDialog(
      //judulnya
      content: new Text("Serius pengen delete '${widget.list[widget.index]['nama']}'"),

      actions: [
        new RaisedButton(
          //Tombol Okehh yang ketika dklick akan memanggil fungsi deleteData() dan akan kembali lagi ke main.dart / MyApp()
          child: new Text("Okehh"),
          color: Colors.red,
          onPressed: () {
            deleteData();
            Navigator.push(context, new MaterialPageRoute(builder: (context) => new MyApp()));
          }
        ),
        new RaisedButton(
            //Tombol Jgn di hapus yang ketika diklick menu peringatan atau AlertDialog akan menghilang
            child: new Text("Aja di hapus"),
            color: Colors.green,
            onPressed: ()=> Navigator.pop(context),
        )
      ],
    );
    
    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      //data yang tadi diambil dari cardView main.dart . Kemudian merubahnya menjadi tampilan dengan
      //widget.list sebagai list yang tadi kita klick
      // LIST DISINI ADALAH SEMUA DATA .. TERMASUK KOLOM YAKNI ['id'],['nama'],['pass']
      //widget.index sebagai index keberapa yang tadi kita klick
      //['id'] nama kolom yang diambil

      appBar: new AppBar(title: new Text("${widget.list[widget.index]['id']}"),),
      body: new Container(
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Text(widget.list[widget.index]['id'], style: new TextStyle(fontSize: 40.0),),
                new Text("Nama : ${widget.list[widget.index]['nama']}", style: new TextStyle(fontSize: 20.0),),
                new Text("Pass : ${widget.list[widget.index]['pass']}", style: new TextStyle(fontSize: 20.0),),
                new Padding(padding: const EdgeInsets.only(top: 30.0),),
                new Row(
                  //membuat button ke tengah
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    //button Edit yang ketika di klick memanggil class EditData dan mengirim list dan indexnya
                    new RaisedButton(
                      child: new Text("Edit"),
                      color: Colors.green,
                      //Menggunakan Navigator.of push agar ketika kita memanggil class . Maka aplikasi akan hot raload (refresh) dengan otomatis
                      //memanggil class EditData() dan MENGIRIM data list dan index
                      // LIST DISINI ADALAH SEMUA DATA .. TERMASUK KOLOM YAKNI ['id'],['nama'],['pass']
                      onPressed: ()=> Navigator.of(context).push(
                        new MaterialPageRoute(
                          //harus menggunakan widget untuk mengirimnya jadi "widget.list"
                            builder: (BuildContext context)=>new EditData(list: widget.list, index: widget.index,),
                        ),
                      ),
                    ),
                    //button Delete yanbg ketika di klick memanggil fungsi confirm()
                    new RaisedButton(
                      child: new Text("Delete"),
                      color: Colors.red,
                      onPressed: ()=> confirm(),
                    ),
                  ],
                )
              ],
            ), 
          ),
        ),
      ),
    );
  }
}
