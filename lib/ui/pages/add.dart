import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new thing"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Text("Add New Thing"),
      )
    );
  }
}