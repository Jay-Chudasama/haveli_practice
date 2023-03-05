import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/auth/auth_bloc.dart';
import 'package:haveliapp/auth/auth_state.dart' as AuthState;
import 'package:haveliapp/constants.dart';
import 'package:haveliapp/home/fragments/home_fragment/home_bloc.dart';
import 'package:haveliapp/home/fragments/home_fragment/home_state.dart';

import '../../../mywidgets/postitem.dart';
import '../../../mywidgets/storyshelf.dart';
import 'home_event.dart';

class HomeFragment extends StatelessWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is Failed) {
          if (state.message == UNAUTHENTICATED) {
            BlocProvider.of<AuthBloc>(context)
                .emit(AuthState.UnAuthenticated());
          }

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {

        if(state is Init){

          BlocProvider.of<HomeBloc>(context).add(LoadStories());

        }

        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            if (index == 0) {

              return StoryShelf(state);
            }
            return PostItem();
          },
          itemCount: 5,
        );
      },
    );
  }
}
