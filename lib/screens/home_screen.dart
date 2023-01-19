import 'package:flutter/material.dart';
import 'package:haveliapp/Widgets/MyListItem.dart';
import 'package:haveliapp/models/student_model.dart';

class HomeScreen extends StatelessWidget {

  List<StudentModel> list = [
    StudentModel("Ronak pithva", "9th May 1999", "4th", "9765678767", false),
    StudentModel("Ronak pithva", "9th May 1999", "4th", "9765678767", false),
    StudentModel("Ronak pithva", "9th May 1999", "4th", "9765678767", false),
    StudentModel("Ronak pithva", "9th May 1999", "4th", "9765678767", false),
    StudentModel("Ronak pithva", "9th May 1999", "4th", "9765678767", false),
    StudentModel("Ronak pithva", "9th May 1999", "4th", "9765678767", false),
    StudentModel("Ronak pithva", "9th May 1999", "4th", "9765678767", false),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...list.map((e) => MyListItem(e)),
          ],
        ),
      ),
    );
  }
}


