import '../data/api/api_function.dart';
import '../data/handler/api_url.dart';
import '../res/color_print.dart';

class AuthRepository {
  Future<dynamic> loginApi(dynamic data) async {
    try {
      await APIFunction().postApiCall(apiName: ApiUrls.loginUrl).then(
        (response) async {
          return response;
        },
      );
    } catch (e) {
      printErrors(type: this, errText: "$e");
      rethrow;
    }
  }

  Future<dynamic> signUpApi(dynamic data) async {
    try {
      await APIFunction().postApiCall(apiName: ApiUrls.registerUrl).then(
        (response) async {
          return response;
        },
      );
    } catch (e) {
      printErrors(type: this, errText: "$e");
      rethrow;
    }
  }
}
