import 'package:flutter/material.dart';
import 'package:haveliapp/models/student_model.dart';

class MyListItem extends StatelessWidget {
  final StudentModel model;

  MyListItem(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [BoxShadow(blurRadius: 26, color: Colors.black12)],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(4), // Border width
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNrFreR1vBsHpmIybfANeQEc7yaNemXqnM7JNcuDjN&s',
                    fit: BoxFit.cover,
                    height: 80,
                    width: 80,
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name : ${model.name}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text("DOB : ${model.dob}"),
                  SizedBox(
                    height: 8,
                  ),
                  Text("Semester : ${model.semester}"),
                  SizedBox(
                    height: 8,
                  ),
                  Text("Phone no. : ${model.phone}"),
                ],
              ))
            ],
          ),
          SizedBox(height: 12,),
          Row(
            children: [
              Expanded(
                  child: OutlinedButton(
            style: ButtonStyle(side: MaterialStateProperty.all(BorderSide(style: BorderStyle.none))),
                    onPressed: (){
                      print("absent");
                    },
                child: Text("Absent",
                    style: TextStyle(
                        color: Colors.redAccent, fontWeight: FontWeight.bold)),
              )),
              Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(elevation: MaterialStateProperty.all(0)),
                    onPressed: (){
                      print("present");
                    },
                    child: Text("Present",
                        style: TextStyle(
                             fontWeight: FontWeight.bold)),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
