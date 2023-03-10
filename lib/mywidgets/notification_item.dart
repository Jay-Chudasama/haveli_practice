import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:haveliapp/constants.dart';
import 'package:haveliapp/model/NotificationModel.dart';

class NotificationItem extends StatelessWidget {

  NotificationModel model;


  NotificationItem(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      margin: EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(2),
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.blue,
                width: 3,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: model.notificationBy!.image==null? Icon(Icons.account_circle) :  CachedNetworkImage(
                  progressIndicatorBuilder: (context, url, progress) =>
                      Center(
                        child: CircularProgressIndicator(
                          value: progress.progress,
                        ),
                      ),
                  fit: BoxFit.cover,
                  imageUrl: BASE_URL+model.notificationBy!.image),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            // widget.model.username,
            model.notificationBy!.username,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 12,),
          Text(
            // widget.model.email,
            model.post==null? " started following you" :"liked your post",
            style: TextStyle(color: Colors.black),
          ),


        ],
      ),
    );
  }
}
