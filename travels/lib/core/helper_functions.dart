import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

String formatDateForApi(DateTime date) {
  return DateFormat('dd-MM-yyyy').format(date);
}

void showMessage(BuildContext context , String msg){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}