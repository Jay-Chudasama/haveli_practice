// TODO    ONLY FOR DEMO SERVER DELETE BEFORE PRODUCTION

import 'constant.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

final dioAdapter = DioAdapter(dio: DIO);
const duration = Duration(seconds: 2);

void mockResponseAdapter() {
  _userDetails();
  _getOtp();
  _verifyOtp();
  _updateProfile();
  _newslist();
}

void _getOtp() {
  dioAdapter.onPost(
    "$BASE_URL/getotp/",
    (server) {
      server.reply(
        200,
        {'detail': 'server error!'},
        // Reply would wait for one-sec before returning data.
        delay: duration,
      );
    },
  );
}

void _verifyOtp() {
  dioAdapter.onPost(
    "$BASE_URL/verifyotp/",
    (server) {
      server.reply(
        200,
        {
          'token': 'fasd7f8as7df987as8dfy98asf',
        },
        // Reply would wait for one-sec before returning data.
        delay: duration,
      );
    },
  );
}

void _updateProfile() {
  dioAdapter.onPost(
    "$BASE_URL/updateprofile/",
    (server) {
      server.reply(
        200,
        {'detail': 'Sucess'},
        // Reply would wait for one-sec before returning data.
        delay: duration,
      );
    },
  );
}

void _newslist() {
  dioAdapter.onGet(
    "$BASE_URL/newslist/",
    (server) {
      server.reply(
        200,
        [
          {
            'details': 'i am sahil viradiya',
            'id': 1,
            'title': 'Wallstreet Carshed!!',
            'image':
                "https://thumbs.dreamstime.com/b/bad-news-newspaper-roll-white-background-34903718.jpg",
          },
          {
            'details':
                'i am sahil viradiya i am sahil viradiyai am sahil viradiya i am sahil viradiya i am sahil viradiya i am sahil viradiya i am sahil viradiya i am sahil viradiya i am sahil viradiya i am sahil viradiyai am sahil viradiya i am sahil viradiya',
            'id': 2,
            'title': 'Haveli Carshed!!',
            'image':
                "https://thumbs.dreamstime.com/b/bad-news-newspaper-roll-white-background-34903718.jpg",
          },
          {
            'details': 'i am sahil viradiya',
            'id': 3,
            'title': 'Wallstreet Carshed!!',
            'image':
                "https://thumbs.dreamstime.com/b/bad-news-newspaper-roll-white-background-34903718.jpg",
          },
        ],
        // Reply would wait for one-sec before returning data.
        delay: duration,
      );
    },
  );
}

void _userDetails() {
  dioAdapter.onGet(
    "$BASE_URL/userdetails/",
    (server) {
      server.reply(
        200,
        {
          'id': 113,
          "name": "john doe",
          "phone": "3493094303",
          'image': "https://dq1eylutsoz4u.cloudfront.net/2019/04/25103004/letting-go-of-a-relationship1.jpg"
        },
        // Reply would wait for one-sec before returning data.
        delay: duration,
      );
    },
  );
}
