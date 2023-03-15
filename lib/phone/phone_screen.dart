import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/Otp/otp_cubit.dart';
import 'package:haveliapp/Otp/otp_screen.dart';
import 'package:haveliapp/phone/phone_cubit.dart';
import 'package:haveliapp/phone/phone_state.dart';

class PhoneScreen extends StatefulWidget {
  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  bool enableButton = false;
  String phoneNo = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PhoneCubit, PhoneState>(
        listener: (context, state) {
          if (state is Submitted) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => OtpCubit(),
                    child: OtpScreen(phoneNo),
                  ),
                ));
          }
          if (state is Failed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 150, right: 24, left: 24),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    height: 80,
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        enableButton = value.length == 10;
                        phoneNo = value;
                      });
                    },
                    keyboardType: TextInputType.number,
                    enabled: !(state is Submitting),
                    maxLength: 10,
                    decoration: InputDecoration(
                        hintText: "Enter Phone No",
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  state is Submitting
                      ? CircularProgressIndicator(
                          strokeWidth: 5,
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 120,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                        ),
                        onPressed: state is Submitting || !enableButton
                            ? null
                            : () {
                                BlocProvider.of<PhoneCubit>(context)
                                    .getOtp(phoneNo);
                              },
                        child: Text(
                          "Get Otp",
                          style: TextStyle(fontSize: 18),
                        )),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
