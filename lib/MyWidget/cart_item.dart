import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/constant.dart';
import 'package:haveliapp/home/fragments/cart_fragments/cart_bloc.dart';
import 'package:haveliapp/home/fragments/cart_fragments/cart_event.dart';
import 'package:haveliapp/model/cart_model.dart';

import '../auth/user/user_cubit.dart';

class CartItem extends StatefulWidget {
  CartModel model;

  CartItem(this.model);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
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
              BASE_URL + widget.model.image,
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
                    widget.model.name,
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.model.price.toString(),
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
                                setState(() {
                                  widget.model.qty++;
                                });
                                BlocProvider.of<CartBloc>(context).add(
                                    UpdateQty(
                                        widget.model.id, widget.model.qty));
                              },
                              icon: Icon(Icons.add),
                            ),
                            Text(widget.model.qty.toString()),
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              onPressed: widget.model.qty == 1
                                  ? null
                                  : () {
                                      setState(() {
                                        widget.model.qty--;
                                      });
                                      BlocProvider.of<CartBloc>(context).add(
                                          UpdateQty(widget.model.id,
                                              widget.model.qty));
                                    },
                              icon: Icon(Icons.remove),
                            )
                          ],
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<UserCubit>(context)
                              .removeToCart(widget.model.id);
                          BlocProvider.of<CartBloc>(context)
                              .add(Remove(widget.model));
                        },
                        icon: Icon(
                          Icons.delete,
                          size: 32,
                          color: Colors.red,
                        ),
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
