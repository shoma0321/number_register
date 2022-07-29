import 'package:firebase_intern_sample_app/model/account_model.dart';
import 'package:firebase_intern_sample_app/ui/user/edit_user_profile_page.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  Account myAccount = Account(
    id: '1',
    imagePath:
        'https://reraku.jp/wp-content/themes/reraku/src/images/shared/courses/hiro.jpg',
    userName: 'ユーザー1',
    selfIntroduction: 'ユーザー1の紹介',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 50, right: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              foregroundImage: NetworkImage(myAccount.imagePath),
              child: const Icon(
                Icons.face,
                size: 50,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              myAccount.userName,
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 30),
            Text(
              myAccount.selfIntroduction,
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 80),
            SizedBox(
              height: 40,
              width: 100,
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditUserProfilePage()));
                },
                child: const Text(
                  '編集',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
