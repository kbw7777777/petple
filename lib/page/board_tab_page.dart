import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'board/board_pet.dart';
import 'board/call_screen.dart';

const int tabItemLenth = 4;

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
      appBar: AppBar(
        title: Text("Petple"),
        
        elevation: 1.0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.pink,
          tabs: <Widget>[
           
            Tab(text: "타임라인"),
            Tab(
              text: "산책벙개",
            ),
            Tab(
              text: "펫이야기",
            ),
            Tab(icon: Icon(Icons.settings)),
          ],
        ),
        actions: <Widget>[
          Icon(Icons.search),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
          ),
          Icon(Icons.more_vert),
          
            
         ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          CallsScreen(),
          CallsScreen(),
          BoardPet(),
          CallsScreen(),
          
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

  

