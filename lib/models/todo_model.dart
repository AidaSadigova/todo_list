import 'package:flutter/material.dart';

class Task {
  String title;
  String description;
  DateTime date;
  TimeOfDay time;

  Task(
      {required this.title,
      required this.date,
      required this.time,
      required this.description});
}
