import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lender/blocs/auth_bloc_provider.dart';
import 'package:lender/blocs/user_bloc_provider.dart';

class BorrowedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if(AuthBlocProvider.of(context).user == null) return CircularProgressIndicator();
    return StreamBuilder(
      stream: UserBlocProvider.of(context).borrowed(
        AuthBlocProvider.of(context).user.uid),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.connectionState == ConnectionState.active) {
          if(!snapshot.hasData || snapshot.hasError) return _buildEmptyView();
          var documents = snapshot.data.documents;
          if(documents.length < 1) return _buildEmptyView();
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int i){
              return ListTile(
                title: Text(documents[i]['name']),
                subtitle: Text(documents[i]['from']['name']),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: (){},
              );
            },
          );
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }

  Container _buildEmptyView() {
    return Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Nothing here"),
                Text("Use add button to add your first item")
              ],
            ),
          );
  }
}