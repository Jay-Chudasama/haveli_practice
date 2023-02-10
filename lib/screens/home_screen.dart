import 'package:flutter/material.dart';
import 'package:haveliapp/repo.dart';

enum STATUS { init, searching, loaded, failed }

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  STATUS status = STATUS.init;
  List list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: status != STATUS.searching
          ? AppBar(
              leading: Icon(Icons.search),
              title: TextField(
                onSubmitted: (value) {
                  if (value.isEmpty) {
                    return;
                  }

                  setState(() {
                    status = STATUS.searching;
                  });

                  Repo.search(value).then((response) {
                    setState(() {
                      status = STATUS.loaded;
                      list = response.data;
                    });
                  }).catchError((error) {
                    setState(() {
                      status = STATUS.failed;
                    });
                  });
                },
              ),
            )
          : null,
      body: status == STATUS.searching
          ? Center(
              child: CircularProgressIndicator(),
            )
          : status == STATUS.failed
              ? Center(
                  child: Text("Failed"),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(list[index]["title"]),
                    );
                  },
                  itemCount: list.length,
                ),
    );
  }
}
