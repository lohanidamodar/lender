import 'package:flutter/material.dart';
import 'package:lender/ui/pages/add.dart';
import 'package:lender/ui/pages/home.dart';

void main() => runApp(Lender());

class Lender extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lender',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: HomePage(),
      routes: {
        'add': (_)=> AddPage()
      },
    );
  }
}
