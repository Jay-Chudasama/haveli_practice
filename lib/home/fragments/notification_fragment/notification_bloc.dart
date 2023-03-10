

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/home/fragments/notification_fragment/notification_repo.dart';
import 'package:haveliapp/home/fragments/notification_fragment/notification_repo.dart';
import 'package:haveliapp/model/NotificationModel.dart';

import '../../../constants.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationRepo repo = NotificationRepo();

  NotificationBloc() : super(Init()) {
    on<LoadNotification>((event, emit) async {
      emit(Loading());
      try {
        var response = await repo.load();
        List<NotificationModel> searchlist = response.data['results'].map<NotificationModel>(
          (json) {
            return NotificationModel.fromJson(json);
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
        List<NotificationModel> list = (state as Loaded).list +
            response.data['results'].map<NotificationModel>((json) {
              return NotificationModel.fromJson(json);
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
