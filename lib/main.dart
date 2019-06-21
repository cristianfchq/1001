import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto1001/detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Firebase'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  Future _data;

  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('items').getDocuments();
    return qn.documents;
  }

  navigateToDetail(DocumentSnapshot items){
  //Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(items: items,)));
  //Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(items: items,)));
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(items: items,)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _data = getPosts();

  }  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: _data,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Cargando... "),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index){
                  return ListTile(
                    title: Text(snapshot.data[index].data['name']),
                    onTap: () => navigateToDetail(snapshot.data[index]),
                  );
                }
              );
            }
          }),
    );
  }
}