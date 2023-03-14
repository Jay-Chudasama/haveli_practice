import 'package:flutter/material.dart';

class PhoneScreen extends StatelessWidget {
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 150, right: 24, left: 24),
          child: Column(
            children: [
              Image.asset("assets/images/logo.png", height: 80, ),
              SizedBox(
                height: 120,
              ),
              TextFormField(
                  validator: (value) {
                    //todo
                  },
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
              CircularProgressIndicator(
                strokeWidth: 5,
              ),
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
                    onPressed: () {
                      //todo
                    },
                    child: Text(
                      "Get Otp",
                      style: TextStyle(fontSize: 18),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
