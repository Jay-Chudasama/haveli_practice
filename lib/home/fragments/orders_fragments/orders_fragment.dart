import 'package:flutter/material.dart';

class OrderFragment extends StatelessWidget {
  const OrderFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            "Order List",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        Container(
          margin: EdgeInsets.all(18),
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 14),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "2023",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Text(
                    "Order :#",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        color: Colors.grey),
                  ),
                  Text("3254",style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      color: Colors.black),),
                ],
              ),
              SizedBox(height: 6,),

              Row(
                children: [
                  Text(
                    "23",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 40,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 52,
                  ),
                  Text(
                    "Lunch",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Color.fromRGBO(146, 155, 67, 1)),
                  ),
                  Spacer(),
                  Text(
                    "OnHold",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.red),
                  ),
                ],
              ),
              SizedBox(height: 6,),
              Text(
                "March",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    color: Colors.grey),
              )
            ],
          ),
        )
      ],
    );
  }
}
