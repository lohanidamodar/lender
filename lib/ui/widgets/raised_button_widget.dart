
import 'package:flutter/material.dart';

class PBRaisedButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;

  PBRaisedButton({
    Key key, @required this.child, @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      textColor: Colors.white,
      onPressed: onPressed,
      child: child
    );
  }
}