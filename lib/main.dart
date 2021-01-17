import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import './detail.dart';
import './adddata.dart';

void main() {
  runApp(new MaterialApp(
    title: "Njajal",
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  //Mengambil data yang sudah di ubah menjadi JSON dari database dan menyimpannya di sebuah List

  Future<List> getData() async{
    //mengambil dari sumber JSONnya disini diambil dari ip localhost dan file php yang dimana ada JSON yang sudah ditampilkan
    final response = await http.get("http://192.168.0.200/belajar_crud_flutter/index.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Njajal"),),
      //Membuat floating action button yang ada di sebelah kanan bawah layar
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          //ketika di klick akan memanggil class AddData() dengan Navigator.push agar merefresh otomatis
          onPressed: ()=> Navigator.of(context).push(
            new MaterialPageRoute(
              builder: (BuildContext context) => new AddData(),
            )
          ),
        ),
      body: new FutureBuilder<List>(

        //mengambil data
        future: getData(),

        builder: (context, snapshot){
          //jika error tampilkan error (biasanya muncul merah di ketika di run)
          if(snapshot.hasError) print(snapshot.error);

          return snapshot.hasData

              //jika data snapshotnya ada panggil class ItemList dengan parameter list yang tadi kita buat yang isinya kita ambil dari database tadi
              ? new ItemList(list: snapshot.data,)

              //jika tidak ada data snapshotnya akan gluwer bae
              : new Center(child: new CircularProgressIndicator(),);
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {

  //constructor dari kelas ItemList
  final List list;
  ItemList({this.list});
  
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(

      //jika list = null maka 0 , jika tidak null itemCount = list.length (itemCount akan berisi panjang dari list
      itemCount: list == null ? 0 : list.length,

      //context = data .. i = indexnya
      itemBuilder: (context, i){

        //penanganan ketika cardView di tap maka akan memanggil class Detail() yang mengirimkan data list dari index keberapa yang tadi kita tap
        //ibarat kata recyclerView dan intent jika di java
        return new Container(
          padding: const EdgeInsets.all(0.0),
          child: new GestureDetector(
            onTap: ()=>Navigator.of(context).push(
              new MaterialPageRoute(

                 //memanggil class Detail() dan MENGIRIM data list dan index keberapa dari cardView yang kita tap
                // LIST DISINI ADALAH SEMUA DATA .. TERMASUK KOLOM YAKNI ['id'],['nama'],['pass']
                  builder: (BuildContext context)=> new Detail(list: list, index: i)
              )
            ),

            //membuat cardView dengan data list ditampilkan secara spesifik sesuai dengan kolom yang terdapat pada tabel yang dibuat
            child: new Card(
              child: new ListTile(
                //$list[i]['nama'] adalah list dari i (i adalah index) keberapa pada kolom 'nama'
                title: new Text("Nama : ${list[i]['nama']}", style: new TextStyle(fontSize: 20.0),),
                leading: new Text(list[i]['id'], style: new TextStyle(fontSize: 30.0),),
                subtitle: new Text("Pass : ${list[i]['pass']}"),
              ),
            ),
          ),
        );
      },
    );
  }
}
