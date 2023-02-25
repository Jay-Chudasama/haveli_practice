import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/home/home_state.dart';
import 'home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, HomeState state) {
              if (state is Counter) {
                return Text(
                  "count : ${state.count}",
                  style: TextStyle(fontSize: 20),
                );
              }else{
                return Text("NONE");
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    BlocProvider.of<HomeCubit>(context).remove();
                  },
                  icon: Icon(Icons.remove)),
              IconButton(
                  onPressed: () {
                    BlocProvider.of<HomeCubit>(context).add();
                  },
                  icon: Icon(Icons.add))
            ],
          )
        ],
      ),
    );
  }
}
