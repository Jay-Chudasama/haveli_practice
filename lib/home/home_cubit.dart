import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/models/news_model.dart';
import 'package:haveliapp/home/home_repo.dart';
import 'package:haveliapp/home/home_state.dart';
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(Init());
  HomeRepo homerepo = HomeRepo();

  void loadNews() {
    emit(Loading());
    homerepo.newsApi().then((response) {
      List<NewsModel> list =  response.data.map<NewsModel>((jsonObject) {
        return NewsModel.fromJson(jsonObject);
      }).toList();
      emit(Loaded(list));
    }).catchError((value) {
      DioError error = value;
      if (error.response != null) {
        try {
          emit(Failed(error.response!.data));
        } catch (e) {
          emit(Failed(error.response!.data['detail']));
        }
      } else {
        if (error.type == DioErrorType.unknown) {
          emit(Failed("Please check your internt connection"));
        } else {
          emit(Failed(error.message));
        }
      }
    });
  }
}
