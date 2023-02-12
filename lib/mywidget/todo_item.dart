import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haveliapp/models/todo_model.dart';

class TodoItem extends StatelessWidget {
  TodoModel model;
  Function onPressed;
  Function onRemove;
  TodoItem(this.model,this.onPressed,this.onRemove);

  @override
  Widget build(BuildContext context) {
    if (model.divider) {
      return Column(
        children: [
          Text("Already Completed"),
          Divider(),
        ],
      );
    }
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 25,
          )
        ],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 16),
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: model.completed
                      ? Colors.grey.shade300
                      : Colors.orange.shade300,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300, width: 4),
                ),
                child: Center(
                  child: Text(
                    model.toDo[0],
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                  child: Text(
                model.toDo,
                style: TextStyle(
                    color: model.completed ? Colors.grey : Colors.black),
              ))
            ],
          ),
          Row(children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Text(
                model.dateTime,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Spacer(),
            Row(
              children: [
                TextButton(onPressed: () {
                onRemove(model.id);
                }, child: Row(
                  children: [
                    Icon(Icons.remove_circle),
                    Text("Remove")
                  ],
                ))
              ],
            ),
            model.completed
                ? SizedBox()
                : TextButton(
                    onPressed: () {
                      onPressed(model.id);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.check),
                        Text(
                          " DONE",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ))
          ]),
        ],
      ),
    );
  }
}
