
import 'package:flutter/material.dart';
import 'package:petple/bloc/board/board_bloc.dart';
import 'package:petple/model/board/board.dart';
import 'package:petple/model/board/board_response.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'detail_page.dart';


class Item extends StatefulWidget {
  final String title;

  Item({this.title});

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
        child: Center(
          child: Text(widget.title),
        ),
      ),
      height: 100.0,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

class BoardPet extends StatefulWidget {
  @override
  _BoardPetState createState() => _BoardPetState();
}

class _BoardPetState extends State<BoardPet> {

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<Board> _dataList = [];
  
  static int pageIdx = 1;
  int pageSize = 5;
  ScrollController _controller;
 BoardBloc blocBoard = new BoardBloc();
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    blocBoard.getBoard(pageIdx, pageSize);
  }

   @override
  void dispose() {
    blocBoard.dispose();
    super.dispose();
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


// Widget buildCtn() {
//     return CustomScrollView(
//       slivers: <Widget>[
//         SliverToBoxAdapter(),
//         SliverAppBar(
//           title: Text("SliverAppBar"),
//           expandedHeight: 100.0,
//         ),
//         SliverList(
//           delegate: SliverChildBuilderDelegate(
//             (c, i) => Item(title: _data[i]),
//             childCount: _data.length,
//           ),
//         )
//       ],
//     );
//   }

  @override
  Widget build(BuildContext context) {
    
    // return StreamBuilder<BoardResponse>(
    //   stream: blocBoard.streams(),
    //   builder: (context, AsyncSnapshot<BoardResponse> snapshot) {
    //     if (snapshot.hasData) {
    //       if (snapshot.data.error != null && snapshot.data.error.length > 0) {
    //         return _buildErrorWidget(snapshot.data.error);
    //       }
    //       return _buildBoardList(snapshot.data);
    //     } 
    //     else {
    //       return _buildLoadingWidget();
    //     }
    //   },
    // );
    
    return blocBoard.streamBuilder<BoardResponse>(
      stream: blocBoard.streams(),
      success: (data){
        var r = data as BoardResponse;
        
        
        //return _buildBoardList(data);
           return SmartRefresher(
                    controller: _refreshController,
                    enablePullUp: true,
                    child: _buildBoardList(data),
                    header: WaterDropHeader(),
                    onRefresh: () async {
                      //monitor fetch data from network
                      
                      await Future.delayed(Duration(milliseconds: 1000));
                      // 새글 가져오기!!

                      // if (_data.length == 0) {
                      //   for (int i = 0; i < 10; i++) {
                      //     _data.add("Item $i");
                      //   }
                      // }
                      
                    print("reach the top");
                      if (0 < pageIdx){
                          --pageIdx;
                      }
                      
                      blocBoard.getBoard(pageIdx, pageSize);
                      
                      
                      if (mounted) setState(() {});
                      _refreshController.refreshCompleted();

                      /*
                      if(failed){
                      _refreshController.refreshFailed();
                      }
                    */
                    },
      onLoading: () async {
        //monitor fetch data from network
        await Future.delayed(Duration(milliseconds: 1000));
        // for (int i = 0; i < 10; i++) {
        //   _data.add("Item $i");
        // }
        
        // 계속 불러오기
        print("reach the bottom");
        ++pageIdx;
        blocBoard.getBoard(pageIdx, pageSize);
        

        
      
        if (mounted) setState(() {});
        _refreshController.loadComplete();
      },
    );
  }  ,    

      
      loading: (){
        return  _buildLoadingWidget();
      },
      error: (err){
         return _buildErrorWidget(err);
      },
    );
  }

  Widget _buildBoardList (BoardResponse data) {
    if (1 == pageIdx){
      _dataList.clear();
    }
    _dataList.addAll(data.results);
    Board board = data.results[0];
    print( '_buildBoardList ${board.idx}');

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

    // final makeBody = Container(
    //   // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
    //   child: ListView.builder(
    //   controller: _controller,
    //   scrollDirection: Axis.vertical,
    //   shrinkWrap: true,
    //   itemCount: data.results.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return makeCard(data.results[index]);
    //   },
    //   ),
    // );
   
    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   body: makeBody,
    // );


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
    //       itemExtent: 200.0,
    //       delegate: SliverChildBuilderDelegate(
    //             (BuildContext context, int index) {
    //               //_controller.animateTo(20, duration: new Duration(seconds: 1), curve: Curves.ease);
    //               print(index);
    //           return Container(
    //             alignment: Alignment.center,
    //             color: Colors.lightBlue[100 * (index % 9)],
    //             child: makeCard(data.results[index]),
    //           );
    //         },
    //         childCount: data.results.length,
    //       ),
    //     ),
    //   ],
    // );

return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(),
      
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (c, i) {
              return Container(
                 alignment: Alignment.center,
                 color: Colors.white,
                 child: makeCard(_dataList[i]),
               );
            },
            childCount: _dataList.length,
          ),
        )
      ],
    );
    
  
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





