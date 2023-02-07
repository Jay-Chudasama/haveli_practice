import 'package:flutter/material.dart';

import '../repo.dart';


class HomeScreen extends StatefulWidget {
  List? list;



  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    if(widget.list==null){
      Repo.getData().then((res){




        setState(() {
          widget.list = res.data.map((element){
            return {
              "userId":element["userId"],
              "id":element["id"],
              "title":element["title"],
              "completed":element["completed"],
            };
          }).toList();
        });
      });
    }


    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: widget.list==null? Center(child: Text("Loading..."),) : ListView.builder(
          itemBuilder: (context, index) => ItemView(widget.list![index]["userId"], widget.list![index]["id"], widget.list![index]["title"], widget.list![index]["completed"]),
          itemCount: widget.list!.length,
        ));
  }
}

class ItemView extends StatelessWidget {

  int userId,id;
  String title;
  bool completed;


  ItemView(this.userId, this.id, this.title, this.completed);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      color: Colors.grey,
      child: Column(
        children: [
          Text("title : $title"),
          Text("userId : $userId"),
          Text("id : $id"),
          Text(completed?"completed":"incomplete"),

        ],
      ),
    );
  }
}
