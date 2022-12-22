import 'package:firebase_intern_sample_app/ui/user/user_list_page.dart';
import 'package:firebase_intern_sample_app/ui/user/user_profile_page.dart';
import 'package:firebase_intern_sample_app/ui/user/user_search_page.dart';
import 'package:firebase_intern_sample_app/ui/user/user_setting.dart';
import 'package:flutter/material.dart';

class _Screen2State extends State<Screen2> {
  int selectedIndex = 2;
  List<Widget> pageList = [UserListPage(), UserSearchPage(), UserSettingPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: '登録リスト'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '番号検索'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定')
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  _Screen2State createState() => _Screen2State();
}
