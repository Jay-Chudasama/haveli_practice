import 'package:flutter/material.dart';
import 'package:haveliapp/mywidgets/todo_item.dart';
import 'package:haveliapp/repo.dart';

import '../models/Model.dart';

class HomeScreen extends StatefulWidget {


  List<Model>? list;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {




  @override
  Widget build(BuildContext context) {

    if(widget.list==null){
      Repo.getData().then((response){

        setState(() {
          widget.list = response.data.map<Model>((jsonObject){
            return Model.fromJson(jsonObject);
          }).toList();
        });
      }).catchError((error){
        print(error);
        setState(() {
          widget.list = [];
        });
      });
    }
    return Scaffold(
      appBar: AppBar(title: Text("todos"),),
      body: widget.list==null? Center(child: CircularProgressIndicator(),) : ListView.builder(itemBuilder: (context,index){
        return TodoItem(widget.list![index]);
      },itemCount: widget.list!.length,),

    );
  }
}
