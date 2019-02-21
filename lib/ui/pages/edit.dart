import 'package:flutter/material.dart';
import 'package:lender/blocs/user_bloc_provider.dart';
import 'package:lender/model/item.dart';
import 'package:lender/ui/widgets/item_details_form.dart';

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
  bool loading;
  final Map<String,dynamic> _formData = {};
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
        title: Text("Edit"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: _buildFormTwo(context),
      )
    );
  }

  Widget _buildFormTwo(BuildContext context) {
    return ItemDetailsForm(
      formKey: _formKey,
      item: item,
      type: type,
      loading: loading,
      onSubmit: _save,
      onSaveField: _saveField,
    );
  }

  void _saveField(String key, dynamic value) {
    _formData[key] = value;
  }

  void _save(BuildContext context) async {
    if(!_formKey.currentState.validate())
      return;
    setState(() {
      loading = true;
    });
    _formKey.currentState.save();
    bool res = await UserBlocProvider.of(context).updateItem(item.documentID,_formData, type);

    setState(() {
      loading = false;
    });
    if(res) Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));


  }

}

