import 'package:petple/model/board/board_response.dart';
import 'package:petple/repository/board/board_repository.dart';
import 'package:rxdart/rxdart.dart';

class BoardBloc {
  final BoardRepository repository = BoardRepository();
  final BehaviorSubject<BoardResponse> _subject =
      BehaviorSubject<BoardResponse>();

  getBoard(int pageIdx, int pageSize) async {
    BoardResponse response = await repository.getBoard(pageIdx, pageSize);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<BoardResponse> get subject => _subject;

}
final blocBoard = BoardBloc();