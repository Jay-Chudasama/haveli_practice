import 'package:flutter/material.dart';
import 'package:haveliapp/repo.dart';

enum ADD_STATUS {newAdded,notAdded}
class AddTodo extends StatefulWidget {
  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "type hear",
              border: OutlineInputBorder(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if(_controller.text.isEmpty){
                Navigator.pop(context,ADD_STATUS.notAdded);
                return;
              }
              setState(() {
                Repo.addTodo(_controller.text).then((response)  {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sucess")));
                  Navigator.pop(context,ADD_STATUS.newAdded);
                }).catchError((error){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed")));
                  print(error);
                });


              });
            },
            child: Text("Add"),
          )
        ],
      ),
    );
  }
}
