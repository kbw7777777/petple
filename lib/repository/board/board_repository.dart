import 'package:petple/model/board/board_response.dart';
import 'board_api_provider.dart';

class BoardRepository{
  BoardApiProvider apiProvider = BoardApiProvider();

  Future<BoardResponse> getBoard(int pageIdx, int pageSize){
    return apiProvider.getBoard(pageIdx, pageSize);
  }
}