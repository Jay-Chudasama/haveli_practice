import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haveliapp/repo.dart';
import 'package:haveliapp/utils.dart';

enum STATES { init, loading, loaded, failed }

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var image;

  STATES states = STATES.init;

  @override
  Widget build(BuildContext context) {
    if (states == STATES.init) {
      userdata();
    }
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 100),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: ClipRRect(
                  child: image == null
                      ? Icon(Icons.person)
                      : Image.network(
                          "https://cdn.statusqueen.com/dpimages/thumbnail/whatsapp%20dp%20image6-601.jpg",
                          height: 100,
                          width: 100),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("change profile picture"),
              ),
              SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: () {
                  logout();
                },
                child: Text("logOut"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void userdata() {
    Repo.imageload().then((response) {
      print(response.data['iamge']);
      image = response.data['image'];
      print(image);
    }).catchError((error) {
      print(error);
    });
  }

  void logout() {
    Repo.logout().then((response) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      reloadMainScreen!(null);
      print(response.data);
    }).catchError((error) {
      print(error);

      if (error.response != null) {
        if (error.response.statusCode == 403) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          reloadMainScreen!(null);
        }
      }
    });
  }
}
