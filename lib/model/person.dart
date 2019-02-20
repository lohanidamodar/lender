class Person {
  final String name;

  Person(this.name);

  Person.fromDocumentSnapshot(var data):
    name=data['name'];

}