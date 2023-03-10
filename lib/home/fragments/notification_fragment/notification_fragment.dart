import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/home/fragments/notification_fragment/notification_bloc.dart';
import 'package:haveliapp/home/fragments/notification_fragment/notification_event.dart';
import 'package:haveliapp/home/fragments/notification_fragment/notification_state.dart';
import 'package:haveliapp/mywidgets/notification_item.dart';

import '../../../auth/auth_bloc.dart';
import '../../../auth/auth_state.dart' as AuthState;
import '../../../constants.dart';

class NotificationFragment extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationBloc, NotificationState>(listener: (context, state) {

      if (state is Failed) {
        if (state.message == UNAUTHENTICATED) {
          BlocProvider.of<AuthBloc>(context).emit(AuthState.UnAuthenticated());
        }

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.message)));
      }
    }, builder: (context, state) {

      if(state is Init){
        BlocProvider.of<NotificationBloc>(context).add(LoadNotification());
      }

      return state is Loaded
          ? ListView.builder(
        physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (state is Loaded) {
                  if (index == state.list.length) {
                    if(state.nextUrl != null && !(state is LoadingMore) ){
                      BlocProvider.of<NotificationBloc>(context).add(LoadMore(state.nextUrl!));
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
                return NotificationItem(state.list[index]);
              },
              itemCount: state is Loaded
                  ? state.nextUrl != null
                      ? state.list.length + 1
                      : state.list.length
                  : 0,
            )
          : state is Loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox();
    });
  }
}
