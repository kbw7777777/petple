import 'package:flutter/material.dart';
import 'package:petple/page/board_tab_page.dart';




class MainPage extends StatefulWidget {
   
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>  {
  
    //TODO Page 선택된 페이지(UI widget) 저장할수 있도록
    Widget _buildBody() {
    return  <int, WidgetBuilder> {
          1 :(_) => TabPage(),
    }[1](context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      //bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
