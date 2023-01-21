import 'package:flutter/material.dart';
import 'package:haveliapp/screens/add_todo_screen.dart';
import 'package:haveliapp/widgets/todo_item.dart';

import '../models/todo_model.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TodoModel> list = [
    TodoModel("Flutter coding..."),
    TodoModel("Dart coding..."),
    TodoModel("Object oops coding..."),
    TodoModel("JAVA coding..."),
    TodoModel("Node js coding..."),
  ];

  List<TodoModel> filterList = [];
  TextEditingController _controller = TextEditingController();



  @override
  Widget build(BuildContext context) {

    var renderlist = _controller.text.isEmpty ? list : filterList;


    return Scaffold(
      body: Stack(
        children: [

          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 80,),

                ...renderlist.map((TodoModel model) => !model.completed?TodoItem.withDone(model,(){
                  setState(() {
                    model.completed = true;
                  });
                }):SizedBox()),

                if(_controller.text.isEmpty)
               ...[ SizedBox(height: 8,),
                Text("Already Completed",style: TextStyle(fontSize: 12,color: Colors.grey),),
                Divider()],

                ...renderlist.map((TodoModel model) => model.completed?TodoItem(model):SizedBox()),

              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 16)],
                borderRadius: BorderRadius.circular(8)
            ),
            child: TextField(
              controller: _controller,
              onChanged: (value){
                if(_controller.text.isNotEmpty){
                  setState(() {

                  });
                }
              },
              onSubmitted: (value){
                setState(() {
                  filterList.clear();
                  if(value.isEmpty){
                    return;
                  }

                  list.forEach((element) {
                    if(element.task.contains(value)){
                      filterList.add(element);
                    }
                  });
                });
              },
              decoration: InputDecoration(
                  hintText: "Search task",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: _controller.text.isEmpty?null:IconButton(icon: Icon(Icons.close),onPressed: (){
                    _controller.text = "";
                    setState(() {

                    });
                  },)
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTodoScreen((TodoModel model){
          setState(() {
            list = [model,...list];
          });
        })));
      },),
    );
  }
}
