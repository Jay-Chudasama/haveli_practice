import 'package:flutter/material.dart';
import 'package:haveliapp/models/student_model.dart';

class MyListItem extends StatefulWidget {
  StudentModel model;

  MyListItem(this.model);

  @override
  State<MyListItem> createState() => _MyListItemState();
}

class _MyListItemState extends State<MyListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(blurRadius: 25,color: Colors.black12)]
      ),
      padding: EdgeInsets.all(16),
        child: Column(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black12
              ),
                child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              child: Image.network(
                widget.model.image,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name : ${widget.model.name}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                SizedBox(height: 8,),
                Text("DOB : ${widget.model.dob}"),
                SizedBox(height: 8,),
                Text("Semester : ${widget.model.semester}"),
                SizedBox(height: 8,),
                Text("Phone : ${widget.model.phone}"),
              ],
            )
          ],
        ),
        SizedBox(height: 8,),
        Row(
          children: [


            widget.model.present ? Expanded(child: OutlinedButton(
              onPressed: (){
                   setState(() {
                     widget.model.present = false;
                   });
              },
              style: ButtonStyle(
                side: MaterialStateProperty.all(BorderSide.none)
              ),
              child: Text("Absent",style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold),),
            ))
            :
            Expanded(child: ElevatedButton(
              style: ButtonStyle(elevation: MaterialStateProperty.all(0)),
              onPressed: (){
              setState(() {
                widget.model.present = true;
              });
              },
              child: Text("Present",),
            )),
          ],
        )
      ],
    ));
  }
}
