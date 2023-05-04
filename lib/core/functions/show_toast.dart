import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(
  String msg, {
  Color color = Colors.red,
  ToastGravity gravity = ToastGravity.BOTTOM,
}) =>
    Fluttertoast.showToast(
      toastLength: Toast.LENGTH_LONG,
      msg: msg,
      backgroundColor: color,
      gravity: gravity,
    );

void cancelToast() => Fluttertoast.cancel();
