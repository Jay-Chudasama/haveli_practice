import 'package:flutter/material.dart';
import 'package:haveliapp/models/todo_model.dart';

class TodoItem extends StatefulWidget {
  TodoModel model;
  bool showDone = false;

  Function? onDone;

  TodoItem(this.model);

  TodoItem.withDone(this.model,this.onDone);


  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          widget.showDone = !widget.showDone;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 25)],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      color: widget.model.completed ? Colors.grey : Colors.orangeAccent,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Color.fromRGBO(232, 232, 232, 1.0), width: 4)),
                  child: Center(
                    child: Text(
                      widget.model.symbol,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: Text(
                  widget.model.task,
                  style: TextStyle(color: widget.model.completed ? Colors.grey : null),
                ))
              ],
            ),
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
                  child: Text(
                    "1h ago",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
                Spacer(),
                if (!widget.model.completed && widget.showDone)
                  TextButton.icon(
                      onPressed: () {
                        widget.onDone!();
                      },
                      icon: Icon(Icons.check),
                      label: Text(
                        "DONE",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
