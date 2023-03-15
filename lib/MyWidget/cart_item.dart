import 'package:flutter/material.dart';
import 'package:haveliapp/constant.dart';
import 'package:haveliapp/home/fragments/cart_fragments/cart_event.dart';
import 'package:haveliapp/model/cart_model.dart';

class CartItem extends StatelessWidget {
  CartModel model;

  CartItem(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 14),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.network(
              BASE_URL + model.image,
              height: 100,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    model.price.toString(),
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              onPressed: () {
                                //todo
                              },
                              icon: Icon(Icons.add),
                            ),
                            Text(model.qty.toString()),
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              onPressed: () {
                                //todo
                              },
                              icon: Icon(Icons.remove),
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.delete,
                        size: 32,
                        color: Colors.red,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
