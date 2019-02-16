import 'package:flutter/material.dart';

class PBTextField extends StatelessWidget {
  final Key key;
  final IconData leadingIcon;
  final String hintText;
  final Function onSaved;
  final String initialValue;
  final bool obscureText;
  final Function validator;
  final TextEditingController controller;

  PBTextField({
    this.key,
    @required this.leadingIcon,
    this.hintText,
    this.onSaved,
    this.initialValue,
    this.obscureText = false,
    this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
        color: Color(0xfff4f8f7)
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            margin: EdgeInsets.only(right: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                bottomLeft: Radius.circular(40.0)),
              color: Color(0xffe8ebea),
            ),
            child: Icon(leadingIcon,color: Color(0xff424242),)),
          Expanded(child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText
            ),
            onSaved: onSaved,
            initialValue: initialValue,
            key: key,
            obscureText: obscureText,
            validator: validator,
          ),)
        ],
      ),
    );
  }
}