import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petple/page/user/user_widget.dart';
import 'board/board_pet.dart';
import 'board/call_screen.dart';


const int tabItemLenth = 4;

class CustomeAppBar extends PreferredSize {
  CustomeAppBar({Key key, Widget title, TabBar bottom, double elevation}) : super(
    key: key,
    preferredSize: Size.fromHeight(50),
    child: AppBar(
      title: title,
      bottom: bottom,
      elevation: elevation,
      // maybe other AppBar properties
    ),
  );
}


class TabPage extends StatefulWidget {
  @override
  _TabPage createState() => _TabPage();
}

class _TabPage extends State<TabPage> 
  with SingleTickerProviderStateMixin {
  
  TabController _tabController;
   bool showFab = false;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, initialIndex: 1, length: tabItemLenth);
    _tabController.addListener(() {
      if (_tabController.index == 2) {
        showFab = true;
      } else {
        showFab = false;
      }
      setState(() {});
    });
   
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: CustomeAppBar(
        
        elevation: 2.0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.pink,
          tabs: <Widget>[
            Tab(text: "타임라인"),
            Tab(text: "산책벙개"),
            Tab(text: "펫이야기"),
            Tab(text: "Sponsored"),
          ],
        ),
        
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          CallsScreen(),
          CallsScreen(),
          BoardPet(),
          UserWidget(),
          
          ],
      ),
      floatingActionButton: showFab
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).accentColor,
              child: Icon(
                Icons.message,
                color: Colors.white,
              ),
              onPressed: () => print("open chats"),
            )
          : null,
    );
  }

    
  }

  

