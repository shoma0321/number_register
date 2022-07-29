import 'package:firebase_intern_sample_app/model/account_model.dart';
import 'package:flutter/material.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List accountList = [
    Account(
        id: '1',
        imagePath:
            'https://reraku.jp/wp-content/themes/reraku/src/images/shared/courses/hiro.jpg',
        userName: 'ユーザー1',
        selfIntroduction: 'ユーザー1の紹介'),
    Account(
        id: '2',
        imagePath:
            'https://reraku.jp/wp-content/themes/reraku/src/images/shared/courses/hiro.jpg',
        userName: 'ユーザー2',
        selfIntroduction: 'ユーザー2の紹介'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ユーザーリスト'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: accountList.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 80,
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    foregroundImage: NetworkImage(accountList[index].imagePath),
                    child: Icon(
                      Icons.face,
                      size: 20,
                    ),
                  ),
                  title: Text(accountList[index].userName),
                  subtitle: Text(accountList[index].selfIntroduction),
                ),
              ),
            );
          }),
    );
  }
}
