import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/constants.dart';
import 'package:haveliapp/home/fragments/home_fragment/home_event.dart';
import 'package:haveliapp/home/fragments/home_fragment/home_repo.dart';
import 'package:haveliapp/home/fragments/home_fragment/home_state.dart';
import 'package:haveliapp/model/StoryModel.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepo repo = HomeRepo();

  HomeBloc() : super(Init()) {
    on<LoadStories>((event, emit) async {
      emit(LoadingStories());
      try {
        var response = await repo.loadStories();
        List<StoryModel> list = response.data
            .map<StoryModel>((json) => StoryModel.fromJson(json))
            .toList();

        emit(StoriesLoaded(list));
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

    on<UploadStory>((event, emit) async {
      emit(UploadingStory(
          state is StoriesLoaded ? (state as StoriesLoaded).stories : []));
      try {
        var response = await repo.uploadStories(event.files);
        StoryModel model = StoryModel.fromJson(response.data);
        if ((state as StoriesLoaded).stories[0].id == model.id) {
          (state as StoriesLoaded).stories[0] = model;
        } else {
          (state as StoriesLoaded).stories.insert(0, model);
        }

        emit(StoriesLoaded((state as StoriesLoaded).stories));
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

    on<DeletStory>((event, emit) async {
      emit(DeletingStory(
          state is StoriesLoaded ? (state as StoriesLoaded).stories : []));
      try {
        var response = await repo.deletstory(event.id);
        if (response.data != null) {
          StoryModel model = StoryModel.fromJson(response.data);
          if ((state as StoriesLoaded).stories[0].id == model.id) {
            (state as StoriesLoaded).stories[0] = model;
          }
        } else {
          (state as StoriesLoaded).stories.removeAt(0);
        }
        emit(StoriesLoaded((state as StoriesLoaded).stories));
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
