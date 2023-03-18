import 'package:flutter/material.dart';
import 'package:haveliapp/model/order_model.dart';
import 'package:jiffy/jiffy.dart';

class OrderList extends StatelessWidget {
  Ordermodel model;

  OrderList(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Jiffy(model.createdAt).format('yyyy'),
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
              Text(
                model.id,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    color: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Row(
            children: [
              Text(
                Jiffy(model.createdAt).format('dd'),
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 40,
                    color: Colors.black),
              ),
              SizedBox(
                width: 52,
              ),
              Text(
                model.type,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Color.fromRGBO(146, 155, 67, 1)),
              ),
              Spacer(),
              Text(
                model.orderStatus,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.red),
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            Jiffy(model.createdAt).format('MMM'),
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 20,
                color: Colors.grey),
          )
        ],
      ),
    );
  }
}
