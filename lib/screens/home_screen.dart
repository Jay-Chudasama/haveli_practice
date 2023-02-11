import 'package:flutter/material.dart';
import 'package:haveliapp/models/todo_model.dart';
import 'package:haveliapp/mywidget/todo_item.dart';
import 'package:haveliapp/repo.dart';

enum TODOS_STATUS { init, loading, loded, faild }

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var status = TODOS_STATUS.init;
  List<TodoModel> list = [];
  List<TodoModel>? searchList;

  @override
  Widget build(BuildContext context) {
    if (status == TODOS_STATUS.init) {
      loadTodos();
    }
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          enabled: status == TODOS_STATUS.loded,
          onSubmitted: (value) {
            if (value.isEmpty) {
              setState(() {
                searchList = null;
              });
              return;
            }
            searchTodo(value);
          },
          decoration: InputDecoration(hintText: "search hear"),
        ),
        leading: Icon(Icons.search),
      ),
      body: status == TODOS_STATUS.init || status == TODOS_STATUS.loading
          ? Center(child: CircularProgressIndicator())
          : status == TODOS_STATUS.faild
              ? Center(
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          status = TODOS_STATUS.init;
                        });
                      },
                      child: Text("TRY AGAIN")),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return searchList == null
                        ? TodoItem(list[index])
                        : TodoItem(searchList![index]);
                  },
                  itemCount:
                      searchList == null ? list.length : searchList!.length,
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //todo
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void loadTodos() {
    status = TODOS_STATUS.loading;
    Repo.loadTodos().then((response) {
      setState(() {
        status = TODOS_STATUS.loded;
        List<TodoModel> completedTodods = [];
        List<TodoModel> pendingToddos = [];
        response.data.forEach((json) {
          if (json['completed']) {
            completedTodods.add(TodoModel.fromJson(json));
          } else {
            pendingToddos.add(TodoModel.fromJson(json));
          }
        });
        pendingToddos.add(TodoModel.divider());
        list = pendingToddos + completedTodods;
      });
    }).catchError((error) {
      setState(() {
        print(error);
        status = TODOS_STATUS.faild;
      });
    });
  }

  void searchTodo(String search) {
    setState(() {
      status = TODOS_STATUS.loading;
      Repo.serchTodo(search).then((response) {
        setState(() {
        status = TODOS_STATUS.loded;
          searchList = response.data.map<TodoModel>((json) {
            return TodoModel.fromJson(json);
          }).toList();
        });
      }).catchError((error) {
        setState(() {
          status = TODOS_STATUS.faild;
        });
        print(error);
      });
    });
  }
}
