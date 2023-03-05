import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class PostItem extends StatefulWidget {
  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  LikeButton likeBtn = LikeButton(
    size: 30,
    circleColor: CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
    bubblesColor: BubblesColor(
      dotPrimaryColor: Color(0xffd7227e),
      dotSecondaryColor: Color(0xffcc0000),
    ),
    likeBuilder: (bool isLiked) {
      return Icon(
        !isLiked ? CupertinoIcons.heart : CupertinoIcons.heart_fill,
        color: isLiked ? Colors.redAccent : Colors.black,
        size: 30,
      );
    },
    countBuilder: (likeCount, isLiked, text) {
      return Text("$text likes");
    },
    likeCount: 0,
  );

  double hoverScale = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 8, color: Colors.grey.shade200)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 19,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8&w=1000&q=80",
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dani",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "1 min ago",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () {

              likeBtn.onMyTap();
              setState(() {
                hoverScale = 1;
                Future.delayed(Duration(seconds: 1),(){
                  setState(() {
                    hoverScale = 0;
                  });
                });
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  "https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8&w=1000&q=80",
                  fit: BoxFit.cover,
                  width: screenWidth,
                  height: screenWidth * 9 / 16,
                ),
                AnimatedScale(
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 400),
                  scale: hoverScale,
                  child: Icon(
                    CupertinoIcons.heart_fill,
                    color: Colors.white.withAlpha(100),
                    size: 70,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Helloworld how ar you f.sdfa.f df.as fasfd sa fdsad.f asf a",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [likeBtn],
            ),
          )
        ],
      ),
    );
  }
}
