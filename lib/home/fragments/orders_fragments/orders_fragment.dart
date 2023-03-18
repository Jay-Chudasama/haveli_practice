import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haveliapp/MyWidget/order_item.dart';
import 'package:haveliapp/home/fragments/orders_fragments/orders_bloc.dart';
import 'package:haveliapp/home/fragments/orders_fragments/orders_event.dart';
import 'package:haveliapp/home/fragments/orders_fragments/orders_state.dart';
import 'package:haveliapp/screens/OrderDetails/order_bloc.dart';

import '../../../screens/OrderDetails/order_detils.dart';

class OrderFragment extends StatelessWidget {
  const OrderFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<OrderBloc, OrderState>(
          listener: (context, state) {
            //todo
          },
          builder: (context, state) {
            if (state is Init) {
              BlocProvider.of<OrderBloc>(context).add(Order());
            }
            if (state is Loaded) {
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    if (state is Loaded) {
                      if (index == state.list.length) {
                        if (state.nextUrl != null && !(state is LoadingMore)) {
                          BlocProvider.of<OrderBloc>(context)
                              .add(LoadMore(state.nextUrl!));
                        }
                        return Center(child: CircularProgressIndicator());
                      }
                    }
                    return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                  create: (context) => OrderDetailsBloc(),
                                  child: OderDetails(state.list[index].id)),
                            )),
                        child: OrderList(state.list[index]));
                  },
                  itemCount: state is Loaded
                      ? state.nextUrl != null
                          ? state.list.length + 1
                          : state.list.length
                      : 0,
                ),
              );
            }
            if (state is Loading) {
              CircularProgressIndicator();
            }
            if (state is Failed) {
              return Center(
                child: Text("Failed"),
              );
            }
            return CircularProgressIndicator();
          },
        )
      ],
    );
  }
}
