import 'package:flutter/material.dart';
import 'package:lender/blocs/auth_bloc_provider.dart';
import 'package:lender/blocs/user_bloc_provider.dart';
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
  String type;
  String category;
  String itemName;
  String itemNotes;
  String personName;
  bool loading;
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
    return Container(
      child: ListView(
        children: <Widget>[
          Text("$category details"),
          SizedBox(height: 10.0,),
          TextField(
            onChanged: (value) => setState((){
              itemName = value;
            }),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Name"
            ),
          ),
          SizedBox(height: 10.0,),
          TextField(
            onChanged: (value) => setState((){
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
          TextField(
            onChanged: (value) => setState((){
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
    Map<String,dynamic> item = {
      "name":itemName,
      "category":category,
      "note":itemNotes,
      "person": {
        "name":personName
      }
    };
    
    bool res = await UserBlocProvider.of(context).addItem(item, type, 
      AuthBlocProvider.of(context).user.uid
    );

    if(!res) setState(() {
      loading = false;
    });
    if(res) Navigator.pop(context);


  }

}