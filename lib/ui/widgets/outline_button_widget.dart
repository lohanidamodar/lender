
import 'package:flutter/material.dart';

class PBOutlineButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;

  PBOutlineButton({
    Key key, @required this.child, @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
      onPressed: onPressed,
      child: child
    );
  }
}