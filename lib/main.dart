import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/auth/auth_bloc.dart';
import 'package:haveliapp/auth/auth_event.dart';
import 'package:haveliapp/auth/auth_state.dart';
import 'package:haveliapp/signup/sign_up_screen.dart';
import 'package:haveliapp/signup/signup_bloc.dart';
import 'package:haveliapp/utils.dart';


void run(){
  if (!appInitialized) {
    appInitialized = true;
    runApp(BlocProvider(create: (_) => authBloc, child: MyApp()));
  }
}

AuthBloc authBloc = AuthBloc(run);

bool appInitialized = false;

void main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await getToken();

  if (TOKEN != null) {
    authBloc.add(Authenticate());
  }else{
    run();
  }


}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          //  todo
        },
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
              home: state is Failed || state is Authenticating
                  ? Scaffold(
                      body: Center(
                        child: state is Failed
                            ? ElevatedButton(
                                child: Text("TRY AGAIN"),
                                onPressed: () {
                                  BlocProvider.of<AuthBloc>(context)
                                      .add(Authenticate());
                                },
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              ),
                      ),
                    )
                  : state is Authenticated
                      ? Text("HOME")
                      : BlocProvider(
                          create: (_) => SignUpBloc(), child: SignUpScreen()),
            ));
  }
}
