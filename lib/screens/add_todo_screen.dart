import 'package:flutter/material.dart';
import 'package:haveliapp/models/todo_model.dart';

class AddTodoScreen extends StatelessWidget {

  Function onAdd;


  AddTodoScreen(this.onAdd);

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(239, 239, 239, 1.0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            Text(
              "ADD TASK",
              style: TextStyle(fontSize: 24),
            ),
            Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: TextField(
                controller: _controller,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Type here...",
                  contentPadding: EdgeInsets.all(16),
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0)
                        ),
                          onPressed: () {
                            if(_controller.text.isNotEmpty){
                              TodoModel model = TodoModel(_controller.text);
                              onAdd(model);
                            }
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Add",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
