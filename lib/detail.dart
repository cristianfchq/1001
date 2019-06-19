import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailPage extends StatefulWidget {

  final DocumentSnapshot items;
  DetailPage({this.items});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.items.data['name']),
      ),
      body: Container(
        child: Card(
          child: ListTile(
            title: Text(widget.items.data['name']),
            subtitle: Text(widget.items.data['modAdministracion']),
          ),
        ),
      ),
    );
  }
}
