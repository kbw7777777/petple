import 'package:dio/dio.dart';
import 'package:petple/model/user/user_response.dart';


class UserApiProvider {
  final String _endpoint = "https://randomuser.me/api/";
  Dio _dio;

  UserApiProvider() {
    //Options options = Options(receiveTimeout: 5000);
    _dio = Dio();
    //_setupLoggingInterceptor();
  }

  Future<UserResponse> getUser() async {
    try {
      Response response = await _dio.get(_endpoint);
      return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError(_handleError(error));
    }
  }

  String _handleError(Error error) {
    String errorDescription = error.toString();
    
    return errorDescription;
  }

  // void _setupLoggingInterceptor() {
  //   int maxCharactersPerLine = 200;

  //   _dio.interceptor.request.onSend = (Options options) {
  //     print("--> ${options.method} ${options.path}");
  //     print("Content type: ${options.contentType}");
  //     print("<-- END HTTP");
  //     return options;
  //   };

  //   _dio.interceptor.response.onSuccess = (Response response) {
  //     print(
  //         "<-- ${response.statusCode} ${response.request.method} ${response.request.path}");
  //     String responseAsString = response.data.toString();
  //     if (responseAsString.length > maxCharactersPerLine) {
  //       int iterations =
  //           (responseAsString.length / maxCharactersPerLine).floor();
  //       for (int i = 0; i <= iterations; i++) {
  //         int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
  //         if (endingIndex > responseAsString.length) {
  //           endingIndex = responseAsString.length;
  //         }
  //         print(responseAsString.substring(
  //             i * maxCharactersPerLine, endingIndex));
  //       }
  //     } else {
  //       print(response.data);
  //     }
  //     print("<-- END HTTP");
  //   };
  // }
}
