import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/auth/auth_cubit.dart';
import 'package:haveliapp/auth/auth_state.dart';
import 'package:haveliapp/auth/user/user_cubit.dart';
import 'package:haveliapp/auth/user/user_state.dart';
import 'package:haveliapp/home/fragments/cart_fragments/cart_bloc.dart';
import 'package:haveliapp/home/fragments/home_fragments/home_bloc.dart';
import 'package:haveliapp/home/fragments/orders_fragments/orders_bloc.dart';
import 'package:haveliapp/home/fragments/profile_fragments/profile_bloc.dart';
import 'package:haveliapp/home/fragments/profile_fragments/profile_fragmnet.dart';
import 'package:haveliapp/home/home_screen.dart';
import 'package:haveliapp/phone/phone_cubit.dart';
import 'package:haveliapp/phone/phone_screen.dart';
import 'package:haveliapp/utils.dart';

import 'Location/location_screen.dart';
import 'MyWidget/notification_icon_btn.dart';

HomeBloc homeBloc = HomeBloc();
final NotificationCountCubit notificationCountCubit = NotificationCountCubit(0);

//  background listening
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('on recieve');
  String? value = await storage.read(key: "notificationCount");
  if(value != null){
    value = (int.parse(value)+1).toString();
  }else{
    value = "1";
  }
  await storage.write(key: "notificationCount", value: value);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  try {
    await getToken();
  } catch (e) {
    print(e);
  }

  if (TOKEN != null) {
    await authCubit.loaduserDetails();
  }
  runApp(BlocProvider(create: (context) => authCubit, child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp(){
    WidgetsBinding.instance!
        .addObserver(LifecycleEventHandler(resumeCallBack: () async {
      String? value = await storage.read(key: "notificationCount");
      await storage.write(key: "notificationCount", value: "0");
      if(value != null){
        if(int.parse(value) != 0) {
          notificationCountCubit.setCount(notificationCountCubit.state + int.parse(value));
        }
      }

    }));

    //    recieves msg when app is closed
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print('new message');
      }
    });

//  foreground listening
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        notificationCountCubit.setCount(notificationCountCubit.state + 1);
      }
    });

//    when app is opened in background and user taps on notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.notification != null) {
        print("on tapped");
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            //todo
          },
          builder: (context, state) {
            if (state is Authenticated) {
              notificationCountCubit.setCount(state.model.notifications);
              return MultiBlocProvider(providers: [
                BlocProvider(create: (_) => homeBloc),
                BlocProvider(create: (_) => notificationCountCubit),
                BlocProvider(create: (_) => UserCubit(UserState(state.model))),
                BlocProvider(create: (_) => ProfileBloc()),
              ], child: HomeScreen());
            }
            if (state is Failed) {
              return Scaffold(
                body: Center(
                  child: ElevatedButton(
                    child: Text("Retry"),
                    onPressed: () {
                      BlocProvider.of<AuthCubit>(context).loaduserDetails();
                    },
                  ),
                ),
              );
            }
            return BlocProvider(
              create: (context) => PhoneCubit(),
              child: PhoneScreen(),
            );
          },
        ));
  }
}
