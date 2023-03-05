// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors

import 'dart:io';

import 'package:haveliapp/auth/auth_bloc.dart';
import 'package:haveliapp/auth/auth_state.dart' as AuthState;
import 'package:haveliapp/constants.dart';
import 'package:haveliapp/model/user_details.dart';
import 'package:haveliapp/profile/profile_bloc.dart';
import 'package:haveliapp/profile/profile_event.dart';
import 'package:haveliapp/profile/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();

  String username = "";

  XFile? image;

  File? file;

  late UserDetails model;
  @override
  Widget build(BuildContext context) {
    model =
        (BlocProvider.of<AuthBloc>(context).state as AuthState.Authenticated)
            .userDetails;
    return Scaffold(
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is Failed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("done")));
          }
          if (state is Failed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  GestureDetector(
                    onTap: () {
                      pickImage();
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: image == null && model.image == null
                          ? Icon(
                              Icons.account_circle,
                              size: 100,
                            )
                          : file != null
                              ? Image.file(
                                  file!,
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  BASE_URL + model.image!,
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                    ),
                  ),

                  SizedBox(
                    height: 12,
                  ),
                  Text("Tap the above icon to update your profile photo"),
                  //-------------------------------------------------------UserName<---------------------------------
                  SizedBox(
                    height: 60,
                  ),
                  TextFormField(
                    initialValue: model.username,
                    onChanged: (value) {
                      username = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "UserName",
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  state is Submitting
                      ? CircularProgressIndicator()
                      : SizedBox(),
                  SizedBox(
                    height: 80,
                  ),
                  //-------------------------------------------setUp Acount<---------------------------
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: state is Submitting
                          ? null
                          : () {
                              BlocProvider.of<ProfileBloc>(context)
                                  .add(SetupProfile(username, file));   
                            },
                      child: Text(
                        "Setup Account",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void pickImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    file = File(image!.path);
    setState(() {});
  }
}
