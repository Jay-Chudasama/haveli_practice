import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:haveliapp/constant.dart';
import 'package:haveliapp/screens/OrderDetails/order_bloc.dart';
import 'package:haveliapp/screens/OrderDetails/order_event.dart';
import 'package:haveliapp/screens/OrderDetails/order_state.dart';

class OderDetails extends StatelessWidget {
  String id;

  OderDetails(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<OrderDetailsBloc, OrderDetailsState>(
          listener: (context, state) {
            //todo
          },
          builder: (context, state) {
            if (state is Init) {
              BlocProvider.of<OrderDetailsBloc>(context).add(OrderDetails(id));
            }
            return state is Loaded
                ? Column(
                    children: [
                      Row(
                        children: [
                          Text(state.model.id),
                          Spacer(),
                          Text(state.model.createdAt),
                        ],
                      ),
                      Text(
                        state.model.type,
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        state.model.orderStatus,
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        state.model.address,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      ...state.model.items
                          .map((e) => Container(
                                margin: EdgeInsets.symmetric(horizontal: 18),
                                padding: EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12, blurRadius: 14),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: Image.network(
                                        BASE_URL + e.image,
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              e.name,
                                              style: TextStyle(fontSize: 17),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              e.price.toString(),
                                              style: TextStyle(fontSize: 17),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(e.qty.toString()),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                      Container(
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
                                  state.model.itemsPrice.toString(),
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
                                  state.model.deliveryPrice.toString(),
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
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Text(
                                  state.model.totalAmount.toString(),
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text(
                        state.model.paymentId.toString(),
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        state.model.paymentStatus.toString(),
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      state.model.orderStatus == "DELIVERED"
                          ? RatingBar.builder(
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                BlocProvider.of<OrderDetailsBloc>(context).add(
                                    Rating(state.model.id, rating.toInt()));
                              },
                            )
                          : SizedBox(),
                    ],
                  )
                : SizedBox();
          },
        ),
      ),
    );
  }
}
