
import 'package:flutter/material.dart';

import '../../bar.dart';
import 'items/write_item_page.dart';

class AppRouter {
  static Route<MaterialPageRoute> onNavigate(RouteSettings settings) {
    late final Widget selectedPage;

    switch (settings.name) {
      case WriteItemPage.route:
        selectedPage =  WriteItemPage();
        break;
      default:
        selectedPage = const HomePages();
        break;
    }

    return MaterialPageRoute(builder: (context) => selectedPage);
  }
}
