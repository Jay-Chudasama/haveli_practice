import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/phone/phone_cubit.dart';
import 'package:haveliapp/phone/phone_state.dart';

class PhoneScreen extends StatefulWidget {
  bool enableButton = false;
  String phoneno= "";

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PhoneCubit, PhoneState>(
        listener: (context, state) {
          if (state is Failed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.msg!),
              ),
            );
          }
        },
        builder: (_, PhoneState stat) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Image.asset(
                "assets/images/logo.png",
                height: 80,
                width: 80,
              ),
              SizedBox(
                height: 80,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    widget.enableButton = value.length == 10;
                    widget.phoneno = value;
                  });
                },
                keyboardType: TextInputType.number,
                enabled: !(stat is Submiting),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 10,
                decoration: InputDecoration(
                    prefixText: "+91 ",
                    prefixStyle: TextStyle(
                      color: Colors.black,
                    ),
                    hintText: "Enter Phone no.",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.black,
                    )),
              ),
              Spacer(),
              SizedBox(
                width: 80,
                child: stat is Submiting
                    ? LinearProgressIndicator(color: Colors.black, minHeight: 2)
                    : null,
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: stat is Submiting || !widget.enableButton
                      ? null
                      : () {
                          BlocProvider.of<PhoneCubit>(context).getOtp(widget.phoneno);
                        },
                  child: Text(
                    "GET OTP",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              )
            ],
          ),
        ),
      ),
    );
  }
}
