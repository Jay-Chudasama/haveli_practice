import 'package:flutter/material.dart';
import 'package:haveliapp/repo.dart';

import '../models/Model.dart';

enum STATUS { init, loading, loaded, failed }

class HomeScreen extends StatefulWidget {
  STATUS status = STATUS.init;
 late Model model;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    if (widget.status == STATUS.init) {
      widget.status = STATUS.loading;
      Repo.getData().then((response) {
        setState(() {
          widget.status = STATUS.loaded;
          widget.model = Model.fromJson(response.data);
        });
      }).catchError((error) {
        setState(() {
          widget.status = STATUS.failed;
        });
      });
    }

    return Scaffold(
      appBar: widget.status == STATUS.loaded
          ? AppBar(
              title: Text(widget.model.name),
            )
          : null,
      body: widget.status == STATUS.init || widget.status == STATUS.loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : widget.status == STATUS.failed
              ? Center(
                  child: Text("failed to load data"),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(widget.model.students[index].name),
                      trailing: Text(widget.model.students[index].age.toString()),
                    );
                  },
                  itemCount: widget.model.students.length,
                ),
    );
  }
}
