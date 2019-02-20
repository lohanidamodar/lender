import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lender/blocs/user_bloc_provider.dart';
import 'package:lender/model/item.dart';

class DetailsPage extends StatelessWidget {
  final ItemModel item;
  final String type;
  final TextStyle style = const TextStyle(
    fontSize: 14.0
  );
  const DetailsPage({Key key, this.item, this.type}) : super(key: key);
  
  
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
                title: Text(item.category == 'Money' ? "${item.currency} ${item.amount}" : item.name),
                subtitle: item.note != null ? Text(item.note) :null,
                trailing: Icon(Icons.edit),
              ),
            ),
            SizedBox(height: 10.0,),
            Card(
              elevation: 5.0,
              child: ListTile(
                title: Text(item.person.name),
                trailing: Icon(Icons.edit),
              ),
            ),
            SizedBox(height: 40.0,),
            Card(
              elevation: 5.0,
              child: item.returned
              ? ListTile(
                title: Text("Mark as unreturned".toUpperCase(), style: style,),
                trailing: Icon(Icons.refresh),
                onTap: (){
                  UserBlocProvider.of(context).markAsUnreturned(
                    item.documentID, type);
                  Navigator.pop(context);
                },
              )
              : ListTile(
                title: Text("Mark as returned".toUpperCase(), style: style,),
                trailing: Icon(Icons.check),
                onTap: (){
                  UserBlocProvider.of(context).markAsReturned(
                    item.documentID, type);
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
                    item.documentID, type);
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