import 'package:flutter/material.dart';
import 'package:lender/blocs/auth_bloc_provider.dart';
import 'package:lender/blocs/user_bloc_provider.dart';
import 'package:lender/ui/widgets/item_details_form.dart';
import 'package:lender/ui/widgets/raised_button_widget.dart';

class AddPage extends StatefulWidget {
  final String type;

  const AddPage({Key key, this.type = "borrowed"}) : super(key: key);

  @override
  _AddPageState createState() {
    return new _AddPageState();
  }
}

class _AddPageState extends State<AddPage> {
  bool formOne;
  String category;
  String type;
  bool loading;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String,dynamic> _formData = {};

  final List<String> categories = ["Money", "Tech", "Books", "Games", "Clothes", "Others"];

  @override
  void initState() {
    super.initState();
    formOne = true;
    type = widget.type;
    loading = false;
  }

  Future<bool> _onWillPop() async {
    if(formOne)
      return true;
    else {
      setState(() {
        formOne = true;
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add new thing"),
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: formOne ? _buildFormOne(context) :_buildFormTwo(context),
        )
      ),
    );
  }

  void _changeType(String selectedType) {
    setState(() {
      type = selectedType;
    });
  }
  
  void _changeCategory(String selectedCategory) {
    setState(() {
      category = selectedCategory;
      formOne = false;
    });
  }

  Widget _buildFormOne(BuildContext context) {
    return ListView(
      children: <Widget>[
        Text("Type"),
        SizedBox(height: 5.0,),
        Wrap(
          spacing: 10.0,
          children: <Widget>[
            PBRaisedButton(
              color: type == 'borrowed' ? Theme.of(context).primaryColor : Colors.grey.shade700,
              child: Text("Borrow".toUpperCase()),
              onPressed: () => _changeType('borrowed'),
            ),
            PBRaisedButton(
              color: type == 'lent' ? Theme.of(context).primaryColor : Colors.grey.shade700,
              child: Text("Lend".toUpperCase()),
              onPressed: () => _changeType('lent'),
            ),
          ],
        ),
        SizedBox(height: 20.0,),
        Text("Category"),
        SizedBox(height: 10.0,),
        _buildCategories(),

      ],
    );
  }

  Widget _buildCategories() {
    return Container(
      height: 300,
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 3.5,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
        children: categories.map((cat)=>PBRaisedButton(
            color: category == cat ? Theme.of(context).primaryColor : Colors.grey.shade700,
            child: Text(cat.toUpperCase()),
            onPressed: () => _changeCategory(cat),
          )).toList(),
      ),
    );
  }

  Widget _buildFormTwo(BuildContext context) {
    return ItemDetailsForm(formKey: _formKey,onSaveField: _saveField,onSubmit: _save,loading: loading,type: type, category: category,);
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
    _formData['category'] = category;
    bool res = await UserBlocProvider.of(context).addItem(_formData, type);

    setState(() {
      loading = false;
    });
    if(res) Navigator.pop(context);


  }

}