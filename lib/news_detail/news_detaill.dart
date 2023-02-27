import 'package:flutter/material.dart';
import 'package:haveliapp/models/news_model.dart';

class NewsDetail extends StatelessWidget {
NewsModel model;
NewsDetail(this.model);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,

              child: Image.network(
                model.image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              ),
            Text(model.title,style: TextStyle(color: Colors.white,fontSize: 28),),
            SizedBox(
              height: 8,
            ),
            Text(model.details,style: TextStyle(color: Colors.white,fontSize: 16),),
          ],
        ),
      ),
    );
  }
}
