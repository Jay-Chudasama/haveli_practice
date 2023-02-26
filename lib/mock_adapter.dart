// TODO    ONLY FOR DEMO SERVER DELETE BEFORE PRODUCTION

import 'constant.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

final dioAdapter = DioAdapter(dio: DIO);
const duration = Duration(seconds: 2);

void mockResponseAdapter() {

  _getOtp();
  _verifyOtp();
  _updateProfile();

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
        {'detail': 'invalid otp!'},
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


