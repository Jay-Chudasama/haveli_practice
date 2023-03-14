import 'package:flutter/material.dart';

class CartTotal extends StatelessWidget {
  const CartTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(24),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 14),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Item Price",
                style: TextStyle(fontSize: 22),
              ),
              Spacer(),
              Text(
                "₹40",
                style: TextStyle(fontSize: 22),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text(
                "Delivery Price",
                style: TextStyle(fontSize: 22),
              ),
              Spacer(),
              Text(
                "₹40",
                style: TextStyle(fontSize: 22),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text(
                "Total Amount",
                style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Text(
                "₹40",
                style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
