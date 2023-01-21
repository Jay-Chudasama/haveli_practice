import 'package:flutter/material.dart';
import 'package:haveliapp/models/todo_model.dart';

class TodoItem extends StatelessWidget {
  TodoModel model;


  TodoItem(this.model);

  @override
  Widget build(BuildContext context) {


    return  Container(
      padding:EdgeInsets.all(16),
      margin:EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 25)],
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
                    color: model.completed?Colors.grey: Colors.orangeAccent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Color.fromRGBO(
                        232, 232, 232, 1.0),width: 4)
                ),

                child: Center(
                  child: Text(model.symbol,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                ),
              ),
              SizedBox(width: 16,),
              Expanded(child: Text(model.task,style: TextStyle(color: model.completed?Colors.grey:null),))
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 4),
                child: Text("1h ago",style: TextStyle(fontSize: 12,color: Colors.grey),),
              ),
              Spacer(),
              if(!model.completed)
              TextButton.icon(onPressed: (){
              //  todo
              },icon: Icon(Icons.check), label: Text("DONE",style: TextStyle(fontWeight: FontWeight.bold),))
            ],
          )
        ],
      ),
    );
  }
}
