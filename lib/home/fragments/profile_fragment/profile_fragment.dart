import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/constants.dart';
import 'package:haveliapp/home/fragments/profile_fragment/profile_bloc.dart';
import 'package:haveliapp/home/fragments/profile_fragment/profile_event.dart';
import 'package:haveliapp/home/fragments/profile_fragment/profile_state.dart';
import 'package:haveliapp/mywidgets/postitem.dart';

import '../../../auth/auth_bloc.dart';
import '../../../auth/auth_state.dart' as AuthState;

class ProfileFragment extends StatelessWidget {
  int? id;

  ProfileFragment(this.id);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyProfileBloc, MyProfileState>(
        listener: (context, state) {

      if (state is Failed) {
        if (state.message == UNAUTHENTICATED) {
          BlocProvider.of<AuthBloc>(context).emit(AuthState.UnAuthenticated());
        }

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.message)));
      }
    }, builder: (context, state) {
      if (state is Init) {
        BlocProvider.of<MyProfileBloc>(context).add(LoadDetails(id));
      }
      if (state is Loaded) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.grey, blurRadius: 4),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(2),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.blue, width: 3),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            progressIndicatorBuilder:
                                (context, url, progress) => Center(
                              child: CircularProgressIndicator(
                                value: progress.progress,
                              ),
                            ),
                            fit: BoxFit.cover,
                            imageUrl: BASE_URL + state.model.image,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        state.model.username,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        "${state.model.followers} Followers",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Spacer(),
                      Text(
                        "${state.model.following} Following",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(state.model.bio),
                      Spacer(),
                      if (id != null)
                        ElevatedButton(
                            onPressed: () {
                              //todo
                            },
                            child: Text("Follow")),
                      Spacer(),
                      Text(
                        "Post  ${state.model.posts}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  if (state is PostLoaded) {
                    if (index == state.list.length) {
                      if (state.nextUrl != null && !(state is LoadingMorePosts)) {
                        BlocProvider.of<MyProfileBloc>(context)
                            .add(LoadMorePost(state.nextUrl!));
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return PostItem(state.list[index]);
                  }
                },
                itemCount: state is PostLoaded
                    ? state.nextUrl != null
                        ? state.list.length + 1
                        : state.list.length
                    : 0,
              ),
            )
          ],
        );
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
