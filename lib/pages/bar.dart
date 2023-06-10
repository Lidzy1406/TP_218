import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:todoapp/pages/Todo/printtodo.dart';
import 'package:todoapp/pages/categories/addcategories.dart';
import 'package:todoapp/pages/categories/formpage.dart';
import 'package:todoapp/pages/profil/profil.dart';
import 'package:todoapp/pages/profil/users.dart';

import 'Todo/addtodo.dart';

const _kPages = <String, Widget>{
  'Home': PrintTodo(),
  // 'search': SearchPage(),
  // ignore: unnecessary_const
  'Categories': ListPage(),
  'Profil':Profil(),
  // 'statut': StatusPage(),
};

/*child: Consumer(builder: (context, watch, _) {
                    final viewModel = watch(viewModelProvider);
                    return viewModel.buildInputForm();
                  }),
                ),
              ),
            ],*/
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  TabStyle _tabStyle = TabStyle.reactCircle;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  for (final icon in _kPages.values) icon,
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.flip,
          backgroundColor: Colors.orangeAccent,
          items: const <TabItem>[
            TabItem(icon: Icon(Icons.house_rounded), title: 'Home'),
            // TabItem(icon: Icon(Icons.search), title: 'search'),
            TabItem(icon: Icon(Icons.add_card_rounded), title: 'Categories'),
            // TabItem(icon: Icon(Icons.chat), title: 'chat'),
            TabItem(icon: Icon(Icons.account_box_rounded), title: 'Profil'),
          ],
          color: Color.fromARGB(255, 206, 161, 12),
          activeColor: Color.fromARGB(255, 27, 27, 26),
          onTap: (int i) => print('click index=$i'),
        ),
      ),
    );
  }
}