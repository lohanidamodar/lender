import 'package:flutter/material.dart';
import 'package:lender/ui/widgets/raised_button_widget.dart';

class AddPage extends StatefulWidget {
  final String type;

  const AddPage({Key key, this.type = "borrow"}) : super(key: key);

  @override
  _AddPageState createState() {
    return new _AddPageState();
  }
}

class _AddPageState extends State<AddPage> {
  bool formOne;
  String type;
  String category;
  final List<String> categories = ["Money", "Tech", "Books", "Games", "Clothes", "Others"];

  @override
  void initState() {
    super.initState();
    formOne = true;
    type = widget.type;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new thing"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: _buildFormOne(context),
      )
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
    });
  }

  Widget _buildFormOne(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Type"),
        SizedBox(height: 5.0,),
        Wrap(
          spacing: 10.0,
          children: <Widget>[
            PBRaisedButton(
              color: type == 'borrow' ? Theme.of(context).primaryColor : Colors.grey.shade700,
              child: Text("Borrow".toUpperCase()),
              onPressed: () => _changeType('borrow'),
            ),
            PBRaisedButton(
              color: type == 'lend' ? Theme.of(context).primaryColor : Colors.grey.shade700,
              child: Text("Lend".toUpperCase()),
              onPressed: () => _changeType('lend'),
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

}