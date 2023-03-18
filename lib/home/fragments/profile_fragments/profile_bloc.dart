import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/home/fragments/profile_fragments/profile_event.dart';
import 'package:haveliapp/home/fragments/profile_fragments/profile_repo.dart';
import 'package:haveliapp/home/fragments/profile_fragments/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepo repo = ProfileRepo();

  ProfileBloc() : super(ProfileState()) {
    on<ProfileEvent>((event, emit) async {
      emit(ProfileState());
      try {
        var response = await repo.name(event.name);
      } catch (value) {
        print(value);
      }
    });
  }
}
