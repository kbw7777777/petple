import 'package:dio/dio.dart';
import 'package:petple/model/board/board_response.dart';



class BoardApiProvider {
  
  //http://10.0.2.2:8080/board/list
  final String endpoint = "http://localhost:8080/board/list";
  Dio dio;

  BoardApiProvider() {
    //Options options = Options(receiveTimeout: 5000);
    dio = Dio();
    //_setupLoggingInterceptor();
  }

  Future<BoardResponse> getBoard(int pageIdx, int pageSize) async {
    try {
      Response response = await dio.get(endpoint, queryParameters: {"page":pageIdx, "size":pageSize});
      return BoardResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BoardResponse.withError(_handleError(error));
    }
  }

  String _handleError(Error error) {
    String errorDescription = error.toString();
    
    return errorDescription;
  }

}
