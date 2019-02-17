import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lender/blocs/user_bloc_provider.dart';

class DetailsPage extends StatelessWidget {
  final DocumentSnapshot document;
  final String type;
  final TextStyle style = const TextStyle(
    fontSize: 14.0
  );
  const DetailsPage({Key key, this.document, this.type}) : super(key: key);
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            Card(
              elevation: 5.0,
              child: ListTile(
                title: Text(document['name']),
                subtitle: document['note'] != null ? Text(document['note']) :null,
                trailing: Icon(Icons.edit),
              ),
            ),
            SizedBox(height: 10.0,),
            Card(
              elevation: 5.0,
              child: ListTile(
                title: Text(document['person']['name']),
                trailing: Icon(Icons.edit),
              ),
            ),
            SizedBox(height: 40.0,),
            Card(
              elevation: 5.0,
              child: document['returned']
              ? ListTile(
                title: Text("Mark as unreturned".toUpperCase(), style: style,),
                trailing: Icon(Icons.refresh),
                onTap: (){
                  UserBlocProvider.of(context).markAsUnreturned(
                    document.documentID, type);
                  Navigator.pop(context);
                },
              )
              : ListTile(
                title: Text("Mark as returned".toUpperCase(), style: style,),
                trailing: Icon(Icons.check),
                onTap: (){
                  UserBlocProvider.of(context).markAsReturned(
                    document.documentID, type);
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(height: 10.0,),
            Card(
              elevation: 5.0,
              child: ListTile(
                title: Text("Delete".toUpperCase(), style: style,),
                trailing: Icon(Icons.delete),
                onTap: (){
                  UserBlocProvider.of(context).deleteItem(
                    document.documentID, type);
                  Navigator.pop(context);
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}