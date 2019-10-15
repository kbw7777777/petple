
import 'package:flutter/material.dart';
import 'package:petple/bloc/board/board_bloc.dart';
import 'package:petple/model/board/board.dart';
import 'package:petple/model/board/board_response.dart';

import 'detail_page.dart';

class BoardPet extends StatefulWidget {
  @override
  _BoardPetState createState() => _BoardPetState();
}

class _BoardPetState extends State<BoardPet> {

  static int pageIdx = 0;
  int pageSize = 20;
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    blocBoard.getBoard(pageIdx, pageSize);
  }

  _scrollListener() {
     if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        print("reach the bottom");
        //TODO page idx 증가 시키는데,, 이거 읽은 데이터 클라에서 캐싱해야하나?? 고민해보자
        ++pageIdx;
        blocBoard.getBoard(pageIdx, pageSize);
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        print("reach the top");
        if (0 < pageIdx){
            --pageIdx;
        }
        
        blocBoard.getBoard(pageIdx, pageSize);
      });
    }
 }
  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder<BoardResponse>(
      stream: blocBoard.subject.stream,
      builder: (context, AsyncSnapshot<BoardResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildBoardList(snapshot.data);
        } 
        else {
          return _buildLoadingWidget();
        }
      },
    );
    
  }

  Widget _buildBoardList (BoardResponse data) {
    Board board = data.results[0];
    print(board.idx);

    ListTile makeListTile(Board lesson) => ListTile(
        contentPadding:
            EdgeInsets.symmetric(horizontal: 20.0, vertical: 55.0),
        title: Text(
          lesson.title,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(lesson.content, style: TextStyle(color: Colors.black)),
        
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailPage(lesson: lesson)));
        },
      );

    Card makeCard(Board lesson) => Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          // decoration: BoxDecoration(color: Color.fromRGBO(255, 75, 90, .9)),
          //decoration: BoxDecoration(color: Color.fromRGBO(255, 75, 90, .9)),
          child: makeListTile(lesson),
        ),
      );

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
      controller: _controller,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: data.results.length,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(data.results[index]);
      },
      ),
    );
   
    return Scaffold(
      backgroundColor: Colors.white,
      body: makeBody,
      
    );
    // return ListView.builder(
    //       itemExtent: 150.0,
    //       padding: const EdgeInsets.all(8),
    //       controller: _controller,
    //       itemCount: data.results.length,
    //       itemBuilder: (BuildContext context, int index) {
    //       //_controller.animateTo(index * 20.0, duration: new Duration(seconds: 1), curve: Curves.ease);
    //       return Container(
    //         height: 50,
    //         color: Colors.lightBlue[100 * (index % 9)],
    //         child:Center(child: 
    //         Text(
    //           "${data.results[index].title} ${data.results[index].content}",
    //           style: Theme.of(context).textTheme.title, ) 
    //           ),
            
    //       );
  
    //     }
    //   );

    // return CustomScrollView(
    //   controller: _controller,
      
    //   slivers: <Widget>[
        
    //     SliverFixedExtentList(
    //       itemExtent: 150.0,
          
    //       delegate: SliverChildBuilderDelegate(
    //             (BuildContext context, int index) {
    //               //_controller.animateTo(20, duration: new Duration(seconds: 1), curve: Curves.ease);
    //           return Container(
    //             alignment: Alignment.center,
    //             color: Colors.lightBlue[100 * (index % 9)],
                
    //             child: Text("${data.results[index].title} ${data.results[index].content}"),
                
    //           );
    //         },
    //         childCount: 20,
    //       ),
    //     ),
    //   ],
    // );
  
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Loading data from API...",
            style: Theme.of(context).textTheme.subtitle),
        Padding(
          padding: EdgeInsets.only(top: 5),
        ),
        CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),)
      ],
    ));
  }


  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error", style: Theme.of(context).textTheme.subtitle),
      ],
    ));
  }

}