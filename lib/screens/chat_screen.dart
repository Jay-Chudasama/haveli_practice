import 'package:flutter/material.dart';
import 'package:haveliapp/my_widget/message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leadingWidth: 24,
        leading: BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [

            SizedBox(
              width: 40,
              child: ClipRRect(
                child: Image.network("https://www.unigreet.com/wp-content/uploads/2022/01/today-best-whatsapp-dp-2022-1008x1024.jpg"),
              borderRadius: BorderRadius.circular(100),
              ),

            ),
            Container(
              padding: EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Iswani",style: TextStyle(color: Colors.black,fontSize: 20),),
                  Text("online",style: TextStyle(color: Colors.black,fontSize: 14)),
                ],
              ),
            )

          ],
        ),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return Message();

      },itemCount: 5,),
    );
  }
}
