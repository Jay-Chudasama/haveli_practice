import 'package:flutter/material.dart';
import 'package:haveliapp/Widgets/my_list_item.dart';

import '../models/student_model.dart';

class HomeScreen extends StatelessWidget {

  List<StudentModel> list = [
    StudentModel("ronak", "6th jan 2001", "77878788686", "4th", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLy0iBBKr839kRpNKRTr4nh7y-uMIeqgboOH6-O-9h&s",true),
    StudentModel("ronak", "6th jan 2001", "77878788686", "4th", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLy0iBBKr839kRpNKRTr4nh7y-uMIeqgboOH6-O-9h&s",false),
    StudentModel("ronak", "6th jan 2001", "77878788686", "4th", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLy0iBBKr839kRpNKRTr4nh7y-uMIeqgboOH6-O-9h&s",true),
    StudentModel("ronak", "6th jan 2001", "77878788686", "4th", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLy0iBBKr839kRpNKRTr4nh7y-uMIeqgboOH6-O-9h&s",false),
    StudentModel("ronak", "6th jan 2001", "77878788686", "4th", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLy0iBBKr839kRpNKRTr4nh7y-uMIeqgboOH6-O-9h&s",false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
          ...list.map((StudentModel element)=>MyListItem(element)).toList()
          ],
        ),
      ),
    );
  }
}
