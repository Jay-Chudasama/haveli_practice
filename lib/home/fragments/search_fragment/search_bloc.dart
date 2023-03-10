import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/home/fragments/search_fragment/search_event.dart';
import 'package:haveliapp/home/fragments/search_fragment/search_repo.dart';
import 'package:haveliapp/home/fragments/search_fragment/search_state.dart';
import 'package:haveliapp/model/SearchModel.dart';

import '../../../constants.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchRepo repo = SearchRepo();

  SearchBloc() : super(Init()) {
    on<Search>((event, emit) async {
      emit(Loading());
      try {
        var response = await repo.search(event.searchUser);
        List<SearchModel> searchlist = response.data['results'].map<SearchModel>(
          (json) {
            return SearchModel.fromJson(json);
          },
        ).toList();
        emit(Loaded(searchlist, response.data['next']));
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

    on<LoadMore>((event, emit) async {
      emit(LoadingMore((state as Loaded).list,
          (state as Loaded).nextUrl));
      try {
        var response = await repo.loadeMore(event.nextUrl);
        List<SearchModel> list = (state as Loaded).list +
            response.data['results'].map<SearchModel>((json) {
              return SearchModel.fromJson(json);
            }).toList();
        emit(Loaded(list, response.data['next']));
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
