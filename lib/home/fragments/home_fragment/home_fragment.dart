import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/auth/auth_bloc.dart';
import 'package:haveliapp/auth/auth_state.dart' as AuthState;
import 'package:haveliapp/constants.dart';
import 'package:haveliapp/home/fragments/home_fragment/home_bloc.dart';
import 'package:haveliapp/home/fragments/home_fragment/home_state.dart';
import 'package:haveliapp/model/User_details.dart';

import '../../../mywidgets/postitem.dart';
import '../../../mywidgets/storyshelf.dart';
import 'home_event.dart';

class HomeFragment extends StatelessWidget {

  bool dialogOpen = false;

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

        if(state is UploadingStory){
          dialogOpen = true;
          showDialog(context: context,barrierDismissible: false, builder: (dialogcontext){

            return AlertDialog(title: Text("Uploading story..."),);
          });
        }else if(dialogOpen){
          dialogOpen = false;
          Navigator.pop(context);
        }

      },
      builder: (context, state) {

        if(state is Init){
          UserDetails userDetails = (BlocProvider.of<AuthBloc>(context).state as AuthState.Authenticated).userDetails;
          BlocProvider.of<HomeBloc>(context).add(LoadStories(userDetails.id));

        }



        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            if (index == 0) {

              return StoryShelf(state,(files){
                BlocProvider.of<HomeBloc>(context).add(UploadStory(files));
              });
            }
            return PostItem();
          },
          itemCount: 5,
        );
      },
    );
  }
}
