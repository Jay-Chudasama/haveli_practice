import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/auth/auth_cubit.dart';
import 'package:haveliapp/auth/auth_state.dart';
import 'package:haveliapp/home/fragments/home_fragments/home_bloc.dart';
import 'package:haveliapp/home/fragments/profile_fragments/profile_fragmnet.dart';
import 'package:haveliapp/home/home_screen.dart';
import 'package:haveliapp/phone/phone_cubit.dart';
import 'package:haveliapp/phone/phone_screen.dart';
import 'package:haveliapp/utils.dart';

import 'Location/location_screen.dart';

HomeBloc homeBloc = HomeBloc();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  const MyApp({Key? key}) : super(key: key);

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
              return MultiBlocProvider(
                  providers: [BlocProvider(create: (_) => homeBloc)],
                  child: HomeScreen());
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
