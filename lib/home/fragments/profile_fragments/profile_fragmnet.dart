// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/auth/auth_cubit.dart';
import 'package:haveliapp/auth/user/user_cubit.dart';
import 'package:haveliapp/home/fragments/profile_fragments/profile_bloc.dart';
import 'package:haveliapp/home/fragments/profile_fragments/profile_event.dart';
import 'package:haveliapp/home/fragments/profile_fragments/profile_state.dart';
import 'package:haveliapp/model/User_model.dart';

class ProfileFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserModel model = BlocProvider.of<UserCubit>(context).state.userdata;
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 350,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  color: Color.fromRGBO(230, 109, 70, 1.0)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Align(
                      child: Row(
                        children: [
                          Text(
                            "Profile",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              TextEditingController _controller =
                                  TextEditingController(text: model.name);
                              showModalBottomSheet(
                                  context: context,
                                  builder: (_) {
                                    return Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Name",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          TextFormField(
                                            controller: _controller,
                                            decoration: InputDecoration(
                                                hintText: "Enter Name",
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                )),
                                          ),
                                          SizedBox(
                                            height: 18,
                                          ),
                                          SizedBox(
                                            width: 200,
                                            height: 50,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  BlocProvider.of<UserCubit>(
                                                          context)
                                                      .state
                                                      .userdata
                                                      .name = _controller.text;
                                                  Navigator.pop(context);
                                                  BlocProvider.of<ProfileBloc>(
                                                          context)
                                                      .add(ProfileEvent(
                                                    _controller.text,
                                                  ));
                                                },
                                                child: Text(
                                                  "Update",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                )),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            },
                            icon: Icon(Icons.edit),
                          ),
                        ],
                      ),
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 14.0),
                    child: CircleAvatar(
                      radius: 47,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://avatars.mds.yandex.net/i?id=d4abcb99b86e99d3aff0bd407085450db353bea3-9137660-images-thumbs&n=13&exp=1",
                        ),
                        radius: 45,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          model.name,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    model.phone,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(context: context, builder: (context){
                        return AlertDialog(
                          title: Text("Are you sure you want to logout?"),
                          actions: [
                            TextButton(onPressed: (){
                            BlocProvider.of<AuthCubit>(context).logout();
                            Navigator.pop(context);

                            }, child: Text("YES")),
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: Text("NO")),
                          ],
                        );
                      });
                    },
                    icon: Icon(
                      Icons.power_settings_new_sharp,
                      size: 60,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 48.0, bottom: 24),
              child: Text(
                "Total No. Of Orders",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            Text(
              model.orders.toString(),
              style: TextStyle(color: Colors.black, fontSize: 28),
            ),
            SizedBox(
              height: 18,
            ),
            Divider(),
          ],
        ),
      );
    });
  }
}
