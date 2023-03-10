import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/home/fragments/profile_fragment/profile_bloc.dart';
import 'package:haveliapp/home/fragments/profile_fragment/profile_fragment.dart';

class AccountScreen extends StatelessWidget {

  int id;
  Function follow;


  AccountScreen(this.id,this.follow);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create:(_)=>MyProfileBloc(),child: Scaffold(body: ProfileFragment(id,follow: follow,)));
  }
}
