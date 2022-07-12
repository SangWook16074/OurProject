import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;

  const ActionButton({Key? key, required this.onPressed, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        color: Theme.of(context).primaryColor,
        elevation: 4.0,
        child: IconButton(onPressed: onPressed, icon: icon));
  }
}
