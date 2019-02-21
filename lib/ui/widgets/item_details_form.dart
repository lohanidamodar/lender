import 'package:flutter/material.dart';
import 'package:lender/model/item.dart';
import 'package:lender/ui/widgets/raised_button_widget.dart';


class ItemDetailsForm extends StatelessWidget {
  const ItemDetailsForm({
    Key key,
    @required GlobalKey<FormState> formKey,
    this.item,
    this.category,
    @required this.type,
    @required this.loading,
    @required this.onSubmit,
    @required this.onSaveField,
  }) : _formKey = formKey, super(key: key);

  final GlobalKey<FormState> _formKey;
  final ItemModel item;
  final String category;
  final String type;
  final bool loading;
  final Function onSubmit;
  final Function onSaveField;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Text("${item != null ? item.category : category} details"),
          SizedBox(height: 10.0,),
          TextFormField(
            initialValue: item != null ? item.category == 'Money' ? "${item.amount}" : item.name : "",
            onSaved: (value) {
              onSaveField(
                (item != null ? item.category == "Money" : category == "Money") ? "amount": "name",  (item != null ? item.category == "Money" : category == "Money") ? double.parse(value) :value);
            },
            validator: (value){
              if(value.isEmpty)
                return (item != null ? item.category == "Money" : category == "Money")
                  ? "Amount is required"
                  : "Item name is required";
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: (item != null ? item.category == "Money" : category == "Money") ? "Amount" : "Name"
            ),
          ),
          (item != null ? item.category == "Money" : category == "Money")
            ? SizedBox(height: 10.0,): Container(height: 0,),
          (item != null ? item.category == "Money" : category == "Money")
            ? TextFormField(
              initialValue: item != null ? item.currency : "NPR",
              onSaved: (value)=> onSaveField("currency", value),
              validator: (value){
                if(value.isEmpty)
                  return "Currency is required";
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Currency"
              ),
            ) : Container(height: 0,),
          SizedBox(height: 10.0,),
          TextFormField(
            initialValue: item != null ? item.note : "",
            onSaved: (value)=> onSaveField("note", value),
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
            initialValue: item != null ? item.person.name : "",
            onSaved: (value)=> onSaveField("person", {"name":value}),
            validator: (value){
              if(value.isEmpty)
                return "Person name is required";
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Name"
            ),
          ),
          SizedBox(height: 10.0,),
          PBRaisedButton(
            child: Text("Save".toUpperCase()),
            onPressed: loading ? null : () => onSubmit(context),
          )
        ],
      ),
    );
  }
}