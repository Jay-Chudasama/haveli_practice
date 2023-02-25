import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/home/home_cubit.dart';
import 'package:haveliapp/home/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
        builder: (context, HomeState state) {
          if(state is Init){
            BlocProvider.of<HomeCubit>(context).loadJoke();
          }

      if (state is Init || state is Loading) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      if(state is Loaded){
        return Scaffold(
          appBar: AppBar(
            title: Text("Home"),
          ),
          body: Center(
            child: Text(state.joke),
          ),
        );
      }
       return Text("FAiled");

    });
  }
}
