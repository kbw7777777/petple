import 'package:flutter/material.dart';
import 'package:petple/page/NavigationBar/my.dart';
import 'package:petple/page/NavigationBar/serach.dart';
import 'package:petple/page/NavigationBar/writing.dart';
import 'package:petple/page/board_tab_page.dart';
import 'package:petple/page/layout_type.dart';





class MainPage extends StatefulWidget {
   
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>  {
    
    LayoutGroup _layoutGroup = LayoutGroup.scrollable;
    LayoutType _layoutSelection = LayoutType.home;

    //TODO Page 선택된 페이지(UI widget) 저장할수 있도록
    //TODO layout page 더 만들어야함
    Widget _buildBody() {
    return  <LayoutType, WidgetBuilder> {
          LayoutType.home :(_)    => TabPage(),
          LayoutType.search :(_)  => SearchPage(layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle),
          LayoutType.notify :(_)  => SearchPage(layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle),
          LayoutType.my :(_)      => MyPage(layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle),
          LayoutType.writing :(_) => WritingPage(layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle),

    }[_layoutSelection](context);
  }


  void _onLayoutGroupToggle() {
    setState(() {
      _layoutGroup = _layoutGroup == LayoutGroup.scrollable
          ? LayoutGroup.scrollable
          : LayoutGroup.scrollable;
    });
  }

BottomNavigationBarItem _buildItem(
      {IconData icon, LayoutType layoutSelection}) {
    String text = layoutNames[layoutSelection];
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: Colors.black26,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: Colors.black26,
        ),
      ),
    );
  }

  void _onLayoutSelected(LayoutType selection) {
    setState(() {
        _layoutSelection = selection;
    });
  }

  void _onSelectTab(int index) {
    _onLayoutSelected(LayoutType.values[index]);
  }

Widget _buildBottomNavigationBar() {
   
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          _buildItem(
              icon: Icons.home, layoutSelection: LayoutType.home),
          _buildItem(
              icon: Icons.search, layoutSelection: LayoutType.search),
          _buildItem(icon: Icons.notifications, layoutSelection: LayoutType.notify),
          _buildItem(icon: Icons.settings, layoutSelection: LayoutType.my),
          _buildItem(icon: Icons.add_comment, layoutSelection: LayoutType.writing),
        ],
        onTap: _onSelectTab,
      );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
