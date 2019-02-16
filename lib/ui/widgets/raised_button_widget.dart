
import 'package:flutter/material.dart';

class PBRaisedButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final Color color;

  PBRaisedButton({
    Key key, @required this.child, @required this.onPressed, this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: color == null ? Theme.of(context).buttonTheme.colorScheme : color,
      textColor: Colors.white,
      onPressed: onPressed,
      child: child
    );
  }
}