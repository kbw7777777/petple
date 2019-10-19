



class Board {
    List<int> createdDate;
    List<int> modifiedDate;
    int idx;
    String title;
    String subTitle;
    String content;
    String boardType;

    Board({
        this.createdDate,
        this.modifiedDate,
        this.idx,
        this.title,
        this.subTitle,
        this.content,
        this.boardType,
    });

    factory Board.fromJson(Map<String, dynamic> json) => Board(
        createdDate: List<int>.from(json["createdDate"].map((x) => x)),
        modifiedDate: List<int>.from(json["modifiedDate"].map((x) => x)),
        idx: json["idx"],
        title: json["title"],
        subTitle: json["subTitle"],
        content: json["content"],
        boardType: json["boardType"],
    );

    Map<String, dynamic> toJson() => {
        "createdDate": List<dynamic>.from(createdDate.map((x) => x)),
        "modifiedDate": List<dynamic>.from(modifiedDate.map((x) => x)),
        "idx": idx,
        "title": title,
        "subTitle": subTitle,
        "content": content,
        "boardType": boardType,
    };
}
// To parse this JSON data, do
//
//     final board = boardFromJson(jsonString);



// Board boardFromJson(String str) => Board.fromJson(json.decode(str));

// String boardToJson(Board data) => json.encode(data.toJson());

// class Board {
//     Data data;
//     List<dynamic> errors;

//     Board({
//         this.data,
//         this.errors,
//     });

//     factory Board.fromJson(Map<String, dynamic> json) => Board(
//         data: Data.fromJson(json["content"]),
//         errors: List<dynamic>.from(json["errors"].map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "data": data.toJson(),
//         "errors": List<dynamic>.from(errors.map((x) => x)),
//     };
// }

// class Data {
//     DateTime createdDate;
//     DateTime modifiedDate;
//     int idx;
//     String title;
//     String subTitle;
//     String content;
//     String boardType;

//     Data({
//         this.createdDate,
//         this.modifiedDate,
//         this.idx,
//         this.title,
//         this.subTitle,
//         this.content,
//         this.boardType,
//     });

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         createdDate: json["createdDate"],
//         modifiedDate: json["modifiedDate"],
//         idx: json["idx"],
//         title: json["title"],
//         subTitle: json["subTitle"],
//         content: json["content"],
//         boardType: json["boardType"],
//     );

//     Map<String, dynamic> toJson() => {
//         "createdDate": createdDate,
//         "modifiedDate": modifiedDate,
//         "idx": idx,
//         "title": title,
//         "subTitle": subTitle,
//         "content": content,
//         "boardType": boardType,
//     };
// }
