import 'package:flutter/material.dart';
import 'package:haveliapp/home/fragments/cart_fragments/cart_fragment.dart';
import 'package:haveliapp/home/fragments/home_fragments/home_fragment.dart';
import 'package:haveliapp/home/fragments/orders_fragments/orders_fragment.dart';
import 'package:haveliapp/home/fragments/profile_fragments/profile_fragmnet.dart';

class DrawerItem {
  String title;
  IconData icon;

  DrawerItem(this.title, this.icon);
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedFragment = 0;

  var homeFragment = HomeFragment();
  var orderFragment = OrderFragment();
  var carFragment = CartFragmemnt();
  var profileFragment = ProfileFragment();

  final drawerItems = [
    new DrawerItem("Home", Icons.home),
    new DrawerItem("Orders", Icons.shopping_bag_outlined),
    new DrawerItem("Cart", Icons.shopping_cart_rounded),
    new DrawerItem("Profile", Icons.person),
    new DrawerItem("LogOut", Icons.logout_rounded),
  ];

  onSelectItem(int index) {
    setState(() {
      selectedFragment = index;
    });
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (int i = 0; i < drawerItems.length; i++) {
      var d = drawerItems[i];
      drawerOptions.add(
        ListTile(
          leading: Icon(d.icon),
          title: Text(d.title),
          selected: i == selectedFragment,
          onTap: () {
            onSelectItem(i);
          },
        ),
      );
    }
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.notifications_active_sharp),
            )
          ],
        ),
        body: setFragments(selectedFragment),
        floatingActionButton: selectedFragment == 0
            ? Stack(
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      //todo
                    },
                    child: Icon(Icons.shopping_cart),
                  ),
                  Positioned(
                      top: 12.0,
                      right: 12.0,
                      child: new Center(
                        child: Container(
                          height: 15.0,
                          width: 15.0,
                          decoration: const BoxDecoration(
                            color: Colors.blueGrey,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              "10",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )),
                ],
              )
            : null,
        drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ), //BoxDecoration
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.green),
                  accountName: Text(
                    "Sahil Viradiya",
                    style: TextStyle(fontSize: 18),
                  ),
                  accountEmail: Text("sahilviradiya7190@gmail.com"),
                  currentAccountPictureSize: Size.square(50),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 165, 255, 137),
                    child: Text(
                      "S",
                      style: TextStyle(fontSize: 30.0, color: Colors.blue),
                    ), //Text
                  ), //circleAvatar
                ), //UserAccountDrawerHeader
              ),
              Column(
                children: drawerOptions,
              )
            ],
          ),
        ));
  }

  setFragments(selected) {
    switch (selected) {
      case 0:
        return homeFragment;
      case 1:
        return orderFragment;
      case 2:
        return carFragment;
      case 3:
        return profileFragment;
    }
  }
}
