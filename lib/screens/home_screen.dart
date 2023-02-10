import 'package:flutter/material.dart';
import 'package:haveliapp/repo.dart';

enum STATUS { init, loading, loaded, failed }

class HomeScreen extends StatefulWidget {
  STATUS status = STATUS.init;
  Map<String, dynamic> data = {};

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
          widget.data = response.data;
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
              title: Text(widget.data["name"]),
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
                      title: Text((widget.data["students"] as List)[index]["name"]),
                      trailing: Text((widget.data["students"] as List)[index]["age"].toString()),
                    );
                  },
                  itemCount: (widget.data["students"] as List).length,
                ),
    );
  }
}
