import 'package:flutter/material.dart';
import 'package:lender/model/item.dart';
import 'package:lender/ui/pages/details.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    Key key,
    @required this.item, this.type,
  }) : super(key: key);

  final ItemModel item;
  final String type;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.category == 'Money' ? "${item.currency} ${item.amount}" : item.name,
        style: TextStyle(
          decoration: item.returned ? TextDecoration.lineThrough : TextDecoration.none
        )
      ),
      subtitle: Text(item.person.name,
        style: TextStyle(
          decoration: item.returned ? TextDecoration.lineThrough : TextDecoration.none
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => DetailsPage(item: item, type:type)
        ));
      },
    );
  }
}