import 'package:flutter/material.dart';

class CartTotal extends StatelessWidget {

  int itemPrice,deliveryPrice;


  CartTotal(this.itemPrice, this.deliveryPrice);

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
                "₹$itemPrice",
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
                "₹$deliveryPrice",
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
                "₹${itemPrice+deliveryPrice}",
                style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
