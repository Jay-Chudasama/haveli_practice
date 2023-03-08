import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/constants.dart';
import 'package:haveliapp/home/fragments/home_fragment/home_event.dart';
import 'package:haveliapp/home/fragments/home_fragment/home_repo.dart';
import 'package:haveliapp/home/fragments/home_fragment/home_state.dart';
import 'package:haveliapp/model/PostModel.dart';
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
        add(LoadFeeds());
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
        if ((state as StoriesLoaded).stories.length != 0) {
          if ((state as StoriesLoaded).stories[0].id == model.id) {
            (state as StoriesLoaded).stories[0] = model;
          } else {
            (state as StoriesLoaded).stories.insert(0, model);
          }
        } else {
          (state as StoriesLoaded).stories.add(model);
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

    on<LoadFeeds>((event, emit) async {
      emit(LoadingFeeds((state as StoriesLoaded).stories));
      try {
        var response = await repo.loadFeeds();
        List<PostModel> list = response.data['results'].map<PostModel>((json) {
          return PostModel.fromJson(json);
        }).toList();
        emit(FeedLoded(
            (state as StoriesLoaded).stories, list, response.data['next']));
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
    on<LoadMoreFeeds>((event, emit) async {
      emit(LoadingMoreFeeds((state as FeedLoded).stories,
          (state as FeedLoded).feeds, (state as FeedLoded).nextUrl));
      try {
        var response = await repo.loadeMore(event.nextUrl);
        List<PostModel> list = (state as FeedLoded).feeds +
            response.data['results'].map<PostModel>((json) {
              return PostModel.fromJson(json);
            }).toList();
        emit(FeedLoded(
            (state as StoriesLoaded).stories, list, response.data['next']));
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

    on<AddPost>((event, emit) async {
      emit(Posting((state as StoriesLoaded).stories, (state as FeedLoded).feeds,
          (state as FeedLoded).nextUrl));
      try {
        var response = await repo.addPost(event.caption, event.file);
        (state as FeedLoded).feeds.insert(0, PostModel.fromJson(response.data));
        if ((state as FeedLoded).nextUrl != null) {
          (state as FeedLoded).feeds.removeLast();
        }
        emit(Posted((state as FeedLoded).stories,
            (state as FeedLoded).feeds, (state as FeedLoded).nextUrl));
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
  }
}
