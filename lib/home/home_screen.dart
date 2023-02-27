import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/home/home_cubit.dart';
import 'package:haveliapp/myWidget/news_widget.dart';

import 'home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {
                //todo
              },
              icon: Icon(Icons.account_circle))
        ],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/images/logo.png",
            height: 34,
            width: 34,
          ),
        ),
        title: Center(child: Text("NEWS")),
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is Failed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.msg!),
              ),
            );
          }
        },
        builder: (context, HomeState state) {
          if (state is Init) {
            BlocProvider.of<HomeCubit>(context).loadNews();
          }

          if (state is Loaded) {
            return ListView.builder(
              itemCount: state.list.length,
              itemBuilder: (context, index) => NewsWidget(state.list[index]),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
