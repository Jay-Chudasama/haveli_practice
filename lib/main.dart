// ignore_for_file: prefer_const_constructors

import 'package:haveliapp/auth/auth_bloc.dart';
import 'package:haveliapp/auth/auth_event.dart';
import 'package:haveliapp/auth/auth_state.dart';
import 'package:haveliapp/profile/profile_bloc.dart';
import 'package:haveliapp/profile/profile_screen.dart';
import 'package:haveliapp/sign_up/sign_up_bloc.dart';
import 'package:haveliapp/sign_up/sign_up_scren.dart';
import 'package:haveliapp/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home/fragments/home_fragment/home_bloc.dart';
import 'home/fragments/profile_fragment/profile_bloc.dart';
import 'home/home_screen.dart';

void run() {
  if (!appInitialized) {
    appInitialized = true;
    runApp(BlocProvider(
      create: (context) => authBloc,
      child: MyApp(),
    ));
  }
}

AuthBloc authBloc = AuthBloc(run);
HomeBloc homebloc = HomeBloc();
MyProfileBloc profileBloc = MyProfileBloc();
bool appInitialized = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await getToken();

  if (TOKEN != null) {
    // deletToken();
    print(TOKEN);
    authBloc.add(Authenticat(false));
  } else {
    run();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        //todo
        if (state is UnAuthenticated) {
          deletToken();
        }
        if (state is Authenticated) {}
      },
      builder: (context, state) {
        return MaterialApp(
          theme: ThemeData(fontFamily: 'Kanit-Regular'),
          debugShowCheckedModeBanner: false,
          home: state is Failed || state is Authenticating
              ? Scaffold(
                  body: Center(
                    child: state is Failed
                        ? ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<AuthBloc>(context)
                                  .add(Authenticat(false));
                            },
                            child: Text("TRY AGAIN"))
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                )
              : state is Authenticated
                  ? state.setupAccount
                      ? BlocProvider(
                          create: (context) => ProfileBloc(),
                          child: ProfileScreen(),
                        )
                      : MultiBlocProvider(providers: [
                          BlocProvider<HomeBloc>(
                            create: (BuildContext context) => homebloc,
                          ),
                          BlocProvider<MyProfileBloc>(
                            create: (BuildContext context) => profileBloc,
                          ),
                        ], child: HomeScreen())
                  : BlocProvider(
                      create: (context) => SignUpBloc(),
                      child: SignUpScreen(),
                    ),
        );
      },
    );
  }
}
