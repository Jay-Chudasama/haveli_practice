import 'package:flutter/material.dart';
import 'package:haveliapp/constant.dart';
import 'package:haveliapp/models/news_model.dart';
import 'package:haveliapp/news_detail/news_detaill.dart';

class NewsWidget extends StatelessWidget {
NewsModel model;
NewsWidget(this.model);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetail(model),));
        },
        child: Container(
          height: 200,
          width: double.infinity,
          child: Stack(
            children: [
              Image.network(
                BASE_URL+model.image,
                height: 200,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  color: Color.fromARGB(100, 22, 44, 33),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.title,
                        style: TextStyle(
                            color: Colors.white, fontSize: 25),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                          model.details,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          // softWrap: false,

                          style: TextStyle(
                              color: Colors.white, fontSize: 12.5))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
