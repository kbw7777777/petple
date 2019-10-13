
class Board {
  final num idx;
  final String title;
  final String subTitle;
  final String content;
  final String boardType;

  Board(this.idx, this.title, this.subTitle, this.content, this.boardType);

  Board.fromJson(Map<String, dynamic> json)
      : idx = json["idx"],
        title = json["title"],
        subTitle = json["subTitle"],
        content = json["content"],
        boardType = json["boardType"];    
}