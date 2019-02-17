import 'package:flutter/material.dart';
import 'package:lender/blocs/auth_bloc_provider.dart';

class SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Card(
            elevation: 5.0,
            child: ListTile(
              title: Text("Logout"),
              leading: Icon(Icons.exit_to_app),
              onTap: (){
                AuthBlocProvider.of(context).signOut();
              },
            ),
          )
        ],
      ),
    );
  }
}