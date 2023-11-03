import '../data/api/api_function.dart';
import '../data/handler/api_url.dart';
import '../res/color_print.dart';

class HomeRepository {
  Future<dynamic> homeApi(dynamic data) async {
    try {
      await APIFunction().postApiCall(apiName: ApiUrls.dashboardUrl).then(
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
