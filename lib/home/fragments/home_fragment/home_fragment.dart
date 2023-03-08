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
  bool dialogOpen = false,postingdialogOpen=false;

  Function? deleteCallback;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is StoriesLoaded && !(state is DeletingStory)) {
          if (deleteCallback != null) {
            deleteCallback!();
            deleteCallback = null;
          }
        }

        if (state is Posted) {
          if (postingdialogOpen) {
            postingdialogOpen = false;
            Navigator.pop(context);
          }
        }

        if (state is Posting) {
          postingdialogOpen = true;
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Posting..."),
                  ),
              barrierDismissible: false);
        }

        if (state is Failed) {
          if (deleteCallback != null) {
            deleteCallback!();
            deleteCallback = null;
          }
          if (state.message == UNAUTHENTICATED) {
            BlocProvider.of<AuthBloc>(context)
                .emit(AuthState.UnAuthenticated());
          }

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }

        if (state is UploadingStory) {
          dialogOpen = true;
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (dialogcontext) {
                return AlertDialog(
                  title: Text("Uploading story..."),
                );
              });
        } else if (dialogOpen) {
          dialogOpen = false;
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is Init) {
          UserDetails userDetails = (BlocProvider.of<AuthBloc>(context).state
                  as AuthState.Authenticated)
              .userDetails;
          BlocProvider.of<HomeBloc>(context).add(LoadStories(userDetails.id));
        }
        if (state is StoriesLoaded) {
          return RefreshIndicator(

            onRefresh: () async {
              BlocProvider.of<HomeBloc>(context).emit(Init());
            },
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return StoryShelf(
                    state,
                    uploadStory: (files) {
                      BlocProvider.of<HomeBloc>(context).add(UploadStory(files));
                    },
                    deleteStory: (int id, Function deleteCallback) {
                      this.deleteCallback = deleteCallback;
                      BlocProvider.of<HomeBloc>(context).add(DeletStory(id));
                    },
                  );
                }
                if (state is FeedLoded && state.feeds.length + 1 == index) {
                  if (state.nextUrl != null && !(state is LoadingMoreFeeds)) {
                    BlocProvider.of<HomeBloc>(context)
                        .add(LoadMoreFeeds(state.nextUrl!));
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is FeedLoded) {
                  return PostItem(state.feeds[index - 1]);
                }
              },
              itemCount: state is FeedLoded
                  ? state.nextUrl != null
                      ? state.feeds.length + 2
                      : state.feeds.length + 1
                  : 1,
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
