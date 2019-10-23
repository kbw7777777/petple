import 'package:petple/model/board/board_response.dart';
import 'package:petple/repository/board/board_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../BaseBlocWidget.dart';

class BoardBloc extends BaseBlocWidget {
  
  final BoardRepository repository = BoardRepository();
  final _fetcher = new PublishSubject<BoardResponse>();

  streams() => _fetcher.stream;

  getBoard(int pageIdx, int pageSize) async {
    BoardResponse response = await repository.getBoard(pageIdx, pageSize);
    try{
        _fetcher.sink.add(response);
    }
    catch(e){
       _fetcher.sink.addError(e,null);
    }
    
  }

  dispose() {
    _fetcher.close();
  }

  

}
//final blocBoard = BoardBloc();