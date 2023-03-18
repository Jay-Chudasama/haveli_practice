import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/auth_cubit.dart';
import '../auth/auth_state.dart';

class NotificationIconBtn extends StatelessWidget {
  var onPressed;

  NotificationIconBtn({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCountCubit,int>(
        builder: (context,state) {
          return InkWell(
            onTap: (){
              (context.read<AuthCubit>().state as Authenticated).model.notifications = 0;
              context.read<NotificationCountCubit>().setCount(0);

              onPressed();
            },
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.notifications),
                ),
                if(state >0)
                  Positioned(
                    child: Chip(
                      visualDensity: VisualDensity.compact,
                      labelPadding: EdgeInsets.zero,
                      backgroundColor: Colors.orange,
                      label: Text(
                        state.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    top: 0,
                    right: 0,
                  ),
              ],
            ),
          );
        }
    );
  }
}

class NotificationCountCubit extends Cubit<int>{
  NotificationCountCubit(int initialState) : super(initialState);

  void setCount(int count){
    emit(count);
  }
}