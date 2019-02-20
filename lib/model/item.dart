import 'package:lender/model/person.dart';

class ItemModel {
  final String name;
  final String currency;
  final double amount;
  final String note;
  final String category;
  final Person person;
  final bool returned;
  final String documentID;

  ItemModel(this.name, this.currency, this.amount, this.note, this.category, this.person, this.returned,this.documentID);

  ItemModel.fromDocumentSnapshot(var data):
    name=data['name'],
    currency=data['currency'],
    amount=data['amount'],
    note=data['note'],
    category=data['category'],
    returned=data['returned'],
    documentID=data.documentID,
    person=Person.fromDocumentSnapshot(data['person']);

}