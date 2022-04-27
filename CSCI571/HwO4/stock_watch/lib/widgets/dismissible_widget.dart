import 'package:flutter/material.dart';

class DismissibleWidget<T> extends StatelessWidget {

  final T item;
  final Widget child;
  final DismissDirectionCallback onDismissed;
  final ConfirmDismissCallback confirmDismissed;

  const DismissibleWidget({
      Key? key,
      required this.item,
      required this.child,
      required this.confirmDismissed,
      required this.onDismissed,
  }): super(key: key);


  @override
  Widget build(BuildContext context) => Dismissible(
      key: ObjectKey(item),
      child: child,
      direction: DismissDirection.endToStart,
      onDismissed: onDismissed,
      confirmDismiss: confirmDismissed,
      background: buildSwipeActionRight(),
  );

  Widget buildSwipeActionRight() => Container(
    alignment: Alignment.centerRight,
    padding:  const EdgeInsets.symmetric(horizontal: 32.0),
    color: Colors.red,
    child: const Icon(Icons.delete_forever, color: Colors.white, size: 32.0,),
  );

}