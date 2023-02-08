import 'package:flutter/material.dart';
import 'package:haveliapp/models/Model.dart';

class TodoItem extends StatelessWidget {
  Model model;


  TodoItem(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(children: [
            Text("id : ${model.id}"),
            Text("userId : ${model.userId}"),
          ],),
          Row(children: [
            Expanded(child: Text("title : ${model.title}")),
            Text("completed : ${model.completed?"complete":"incomplete"}"),
          ],)
        ],
      ),
    );
  }
}
