import 'package:flutter/material.dart';
import 'package:lender/ui/tabs/borrowed_tab.dart';
import 'package:lender/ui/tabs/lent_tab.dart';
import 'package:lender/ui/tabs/settings_tab.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(top: 40),
            child: TabBar(
              unselectedLabelColor: Colors.white54,
              labelColor: Colors.white,
              isScrollable: false,
              tabs: <Widget>[
                Tab(child: Text("Borrowed"),),
                Tab(child: Text("Lent"),),
                Tab(child: Text("Settings"),),
              ],
            ),
          ),
        ),
        body: TabBarView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            BorrowedTab(),
            LentTab(),
            SettingsTab(),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            Navigator.pushNamed(context, 'add');
          },
        ),
      ),
    );
  }
}
