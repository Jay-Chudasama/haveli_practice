// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/auth/auth_bloc.dart';
import 'package:haveliapp/auth/auth_state.dart';
import 'package:haveliapp/constants.dart';
import 'package:haveliapp/home/addpost.dart';
import 'package:haveliapp/home/fragments/home_fragment/home_bloc.dart';
import 'package:haveliapp/home/fragments/home_fragment/home_event.dart';
import 'package:haveliapp/home/fragments/home_fragment/home_fragment.dart';
import 'package:haveliapp/home/fragments/notification_fragment/notification_fragment.dart';
import 'package:haveliapp/home/fragments/profile_fragment/profile_bloc.dart';
import 'package:haveliapp/home/fragments/profile_fragment/profile_fragment.dart';
import 'package:haveliapp/home/fragments/search_fragment/search_fragment.dart';

import '../main.dart';
import '../model/User_details.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

HomeFragment homeview = HomeFragment();
ProfileFragment profileview = ProfileFragment(null);

class _HomeScreenState extends State<HomeScreen> {
  int selectedFragment = 0;

  var searchFragment = SearchFragment();
  var notificationFragment = NotificationFragment();

  @override
  Widget build(BuildContext context) {
    UserDetails userdata =
        (BlocProvider.of<AuthBloc>(context).state as Authenticated).userDetails;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Image.asset(
            "assets/images/logo.png",
            height: 40,
            width: 40,
          ),
        ),
        leadingWidth: 56,
        title: Image.asset(
          "assets/images/logo_text.png",
          height: 40,
        ),
      ),
      body: setFragment(selectedFragment),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        iconSize: 26,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedFragment,
        onTap: (int index) async {
          if (index == 2) {
            AddPost? addPost = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPostScreen(),
                ));
            if (addPost != null) {
              homebloc.add(addPost!);
            }

            return;
          }
          setState(() {
            selectedFragment = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.add,
                color: Colors.black,
              ),
              label: "add"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.heart), label: "notification"),
          BottomNavigationBarItem(
              icon: userdata.image == null
                  ? Icon(CupertinoIcons.person_alt_circle)
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        BASE_URL + userdata.image!,
                        height: 30,
                        width: 30,
                        fit: BoxFit.cover,
                      ),
                    ),
              label: "profile"),
        ],
      ),
    );
  }

  setFragment(selected) {
    switch (selected) {
      case 0:
        return homeview;
      case 1:
        return searchFragment;
      case 3:
        return notificationFragment;
      case 4:
        return profileview;
    }
  }
}
