import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haveliapp/models/user_model.dart';
import 'package:haveliapp/my_widget/chat_item.dart';
import 'package:haveliapp/repo.dart';
import 'package:haveliapp/utils.dart';


enum STATES {init,loading,loaded,failed}

class UsersScreen extends StatefulWidget {



  @override
  _UsersScreenState createState() => _UsersScreenState();

  STATES status = STATES.init;

  List<UserModel> list = [];

}

class _UsersScreenState extends State<UsersScreen> {


  @override
  Widget build(BuildContext context) {

    if(widget.status == STATES.init){
      setState(() {
        widget.status = STATES.loading;
        loadUsers();
      });
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text("Chat with..."),
      ),
      body: widget.status==STATES.loading?Center(
        child: CircularProgressIndicator(),
      ) :  widget.status==STATES.failed? Center(child: ElevatedButton(onPressed: (){
        setState(() {
          widget.status  = STATES.init;
        });
      },child: Text("TRY AGAIN"),),) : ListView.builder(
        itemBuilder: (_, index) {
          return ChatItem(widget.list[index]);
        },
        itemCount: widget.list.length,
      ),

    );
  }


  void loadUsers(){
    setState(() {
      widget.status = STATES.loading;
      Repo.loadUsers().then((response){
        setState(() {
          widget.status = STATES.loaded;
          widget.list = response.data.map<UserModel>((json){
            return UserModel.fromJson(json);
          }).toList();
        });
      }).catchError((error){
        print(error);


        if(error.response!=null){
          if(error.response.statusCode==403){
            deletToken().then((value) {
              Navigator.of(context).popUntil((route) => route.isFirst);
               reloadMainScreen!(null);
            });
          }

        }
        setState(() {
          widget.status = STATES.failed;
        });

      });
    });
  }
}
