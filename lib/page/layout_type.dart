import 'package:flutter/foundation.dart';

enum LayoutGroup {
   scrollable,
}

abstract class HasLayoutGroup {
  LayoutGroup get layoutGroup;
  VoidCallback get onLayoutToggle;
}

enum LayoutType {
  
  home,
  search,
  notify,
  my,
  writing,
}

Map<LayoutType, String> layoutNames = {
  LayoutType.home: 'home',
  LayoutType.search: 'search',
  LayoutType.notify: 'notify',
  LayoutType.my: 'setting',
  LayoutType.writing: 'writing',
  
};
