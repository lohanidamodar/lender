import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lender/blocs/user_bloc_provider.dart';
import 'package:lender/model/item.dart';
import 'package:lender/ui/widgets/item_widget.dart';

class LentTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if(UserBlocProvider.of(context).user == null)
      return CircularProgressIndicator();
    return StreamBuilder(
      stream: UserBlocProvider.of(context).lent(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.connectionState == ConnectionState.active) {
          if(!snapshot.hasData || snapshot.hasError) return _buildEmptyView();
          var documents = snapshot.data.documents;
          if(documents.length < 1) return _buildEmptyView();
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int i){
              final item = ItemModel.fromDocumentSnapshot(documents[i]);
              return ItemWidget(item: item, type: 'lent');
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
