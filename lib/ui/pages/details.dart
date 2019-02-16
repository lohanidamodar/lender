import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lender/blocs/user_bloc_provider.dart';

class DetailsPage extends StatelessWidget {
  final DocumentSnapshot document;
  final String type;

  const DetailsPage({Key key, this.document, this.type}) : super(key: key);
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(document['name']),
              trailing: Icon(Icons.edit),
            ),
            ListTile(
              title: Text(document['person']['name']),
              trailing: Icon(Icons.edit),
            ),
            document['returned']
            ? ListTile(
              title: Text("Mark as unreturned".toUpperCase()),
              trailing: Icon(Icons.refresh),
              onTap: (){
                UserBlocProvider.of(context).markAsUnreturned(
                  document.documentID, type);
                Navigator.pop(context);
              },
            )
            : ListTile(
              title: Text("Mark as returned".toUpperCase()),
              trailing: Icon(Icons.check),
              onTap: (){
                UserBlocProvider.of(context).markAsReturned(
                  document.documentID, type);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Delete".toUpperCase()),
              trailing: Icon(Icons.delete),
              onTap: (){
                UserBlocProvider.of(context).deleteItem(
                  document.documentID, type);
                Navigator.pop(context);
              },
            ),

          ],
        ),
      ),
    );
  }
}