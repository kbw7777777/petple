
import 'board.dart';

class BoardResponse {
  final List<Board> results;
  final String error;

  BoardResponse(this.results, this.error);

  BoardResponse.fromJson(Map<String, dynamic> json)
      : results =
            (json["content"] as List).map((i) => new Board.fromJson(i)).toList(),
        error = "";

  BoardResponse.withError(String errorValue)
      : results = List(),
        error = errorValue;
}
