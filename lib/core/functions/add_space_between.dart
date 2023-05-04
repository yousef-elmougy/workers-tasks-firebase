import 'package:flutter/material.dart';

List<Widget> addSpaceBetween({
  required List<Widget> children,
  required Widget space,
}) {
  if (children.isEmpty) return <Widget>[];
  if (children.length == 1) return children;

  final list = [children.first, space];
  for (int i = 1; i < children.length - 1; i++) {
    final child = children[i];
    list.add(child);
    list.add(space);
  }
  list.add(children.last);

  return list;
}
