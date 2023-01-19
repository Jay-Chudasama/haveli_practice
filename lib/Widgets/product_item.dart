import 'package:flutter/material.dart';
import 'package:haveliapp/models/product_model.dart';

class ProductItem extends StatefulWidget {
  ProductModel model;
  Function onRemove;

  ProductItem(this.model,this.onRemove);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(blurRadius: 25, color: Colors.black12)]),
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.black12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: Image.network(
                        widget.model.image,
                        height: 80,
                        width: 80,
                        fit: BoxFit.contain,
                      ),
                    )),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.model.title}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(8))
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: widget.model.quantity == 1? null: () {
                                      setState(() {
                                        widget.model.subtract();
                                      });
                                    }, icon: Icon(Icons.remove)),
                                Text(" ${widget.model.quantity} "),
                                IconButton(

                                    onPressed: widget.model.quantity == 5? null: () {
                                      setState(() {
                                        widget.model.add();
                                      });
                                    }, icon: Icon(Icons.add)),
                              ],
                            ),
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${widget.model.discountPrice}",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "${widget.model.price}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                    decorationThickness: 2),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(

                  style: ButtonStyle(

                      backgroundColor:
                          MaterialStateProperty.all(Colors.redAccent),
                      elevation: MaterialStateProperty.all(0)),
                  onPressed: ()=>widget.onRemove(),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Remove",
                    ),
                  ),
                )),
              ],
            )
          ],
        ));
  }
}
