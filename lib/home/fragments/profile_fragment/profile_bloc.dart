import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/home/fragments/profile_fragment/profile_event.dart';
import 'package:haveliapp/home/fragments/profile_fragment/profile_repo.dart';
import 'package:haveliapp/home/fragments/profile_fragment/profile_state.dart';
import 'package:haveliapp/model/PostModel.dart';
import 'package:haveliapp/model/User_details.dart';

import '../../../constants.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  MyProfileBloc() : super(Init()) {
    MyProfileRepo repo = MyProfileRepo();
    on<LoadDetails>((event, emit) async {
      emit(Loading());
      try {
        var response = await repo.loadDetails(event.id);
        emit(Loaded(UserDetails.fromJson(response.data)));
        add(LoadPost(response.data['id']));
      } catch (value) {
        DioError error = value as DioError;
        if (error.response != null) {
          if (error.response!.statusCode == 403 ||
              error.response!.statusCode == 401) {
            emit(Failed(UNAUTHENTICATED));
          } else {
            emit(Failed("Something went wrong!"));
          }
        } else {
          if (error.type == DioErrorType.unknown) {
            emit(Failed("Connection Failed"));
          } else {
            emit(Failed("${error.message}"));
          }
        }
      }
    });
    on<LoadPost>((event, emit) async {
      emit(LoadingPost((state as Loaded).model));

      try {
        var response = await repo.loadPost(event.id);
        List<PostModel> list = response.data['results'].map<PostModel>((json) {
          return PostModel.fromJson(json);
        }).toList();
        emit(PostLoaded((state as Loaded).model, response.data['next'], list));
      } catch (value) {
        print(value);
        DioError error = value as DioError;
        if (error.response != null) {
          if (error.response!.statusCode == 403 ||
              error.response!.statusCode == 401) {
            emit(Failed(UNAUTHENTICATED));
          } else {
            emit(Failed("Something went wrong!"));
          }
        } else {
          if (error.type == DioErrorType.unknown) {
            emit(Failed("Connection Failed"));
          } else {
            emit(Failed("${error.message}"));
          }
        }
      }
    });

    on<LoadMorePost>((event, emit) async {
      emit(LoadingMorePosts((state as PostLoaded).model,
          (state as PostLoaded).nextUrl, (state as PostLoaded).list));
      try {
        var response = await repo.loadeMore(event.nextUrl);
        List<PostModel> list = (state as PostLoaded).list +
            response.data['results'].map<PostModel>((json) {
              return PostModel.fromJson(json);
            }).toList();
        emit(PostLoaded(
            (state as PostLoaded).model,  response.data['next'],list));
      } catch (value) {
        DioError error = value as DioError;
        if (error.response != null) {
          if (error.response!.statusCode == 403 ||
              error.response!.statusCode == 401) {
            emit(Failed(UNAUTHENTICATED));
          } else {
            emit(Failed("Something went wrong!"));
          }
        } else {
          if (error.type == DioErrorType.unknown) {
            emit(Failed("Connection Failed"));
          } else {
            emit(Failed("${error.message}"));
          }
        }
      }
    });
  }
}
