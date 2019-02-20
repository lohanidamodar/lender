import 'package:flutter/material.dart';
import 'package:lender/blocs/user_bloc_provider.dart';
import 'package:lender/model/item.dart';
import 'package:lender/ui/widgets/raised_button_widget.dart';

class EditPage extends StatefulWidget {
  final String type;
  final ItemModel item;

  const EditPage({Key key, this.type, this.item}) : super(key: key);

  @override
  _EditPageState createState() {
    return new _EditPageState(item);
  }
}

class _EditPageState extends State<EditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String type;
  String itemName;
  String itemNotes;
  String personName;
  bool loading;
  double amount;
  String currency;
  final ItemModel item;

  _EditPageState(this.item);

  @override
  void initState() {
    super.initState();
    type = widget.type;
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new thing"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: _buildFormTwo(context),
      )
    );
  }

  Widget _buildFormTwo(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Text("${item.category} details"),
          SizedBox(height: 10.0,),
          TextFormField(
            initialValue: item.category == 'Money' ? "${item.amount}" : item.name,
            onSaved: (value) => setState((){
              if(item.category=="Money") {
                amount = double.parse(value);
              }else {
                itemName = value;
              }
            }),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: item.category == 'Money' ? "Amount" : "Name"
            ),
          ),
          item.category == 'Money'
            ? SizedBox(height: 10.0,): Container(height: 0,),
          item.category == 'Money'
            ? TextFormField(
              initialValue: item.currency,
              onSaved: (value) => setState((){
                currency = value;
              }),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Currency"
              ),
            ) : Container(height: 0,),
          SizedBox(height: 10.0,),
          TextFormField(
            initialValue: item.note,
            onSaved: (value) => setState((){
              itemNotes = value;
            }),
            maxLines: 3,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Additional notes"
            ),
          ),
          SizedBox(height: 30.0,),
          Text(type=='borrowed' ? "Borrowed from" : "Lent to"),
          SizedBox(height: 10.0,),
          TextFormField(
            initialValue: item.person.name,
            onSaved: (value) => setState((){
              personName = value;
            }),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Name"
            ),
          ),
          SizedBox(height: 10.0,),
          PBRaisedButton(
            child: Text("Save".toUpperCase()),
            onPressed: loading ? null : () => _save(context),
          )
        ],
      ),
    );
  }

  void _save(BuildContext context) async {
    setState(() {
      loading = true;
    });
    _formKey.currentState.save();
    Map<String,dynamic> updated;
    if(item.category == 'Money') {
     updated = {
        "amount":amount,
        "currency":currency,
        "category":item.category,
        "note":itemNotes,
        "person": {
          "name":personName
        }
      };
    }else{
      updated = {
        "name":itemName,
        "category":item.category,
        "note":itemNotes,
        "person": {
          "name":personName
        }
      };
    }
    print(updated);
    bool res = await UserBlocProvider.of(context).updateItem(item.documentID,updated, type);

    setState(() {
      loading = false;
    });
    if(res) Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));


  }

}