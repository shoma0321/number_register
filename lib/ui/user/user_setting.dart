import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_intern_sample_app/ui/user/user_companys_detail_page.dart';
import 'package:firebase_intern_sample_app/ui/user/user_profile_page.dart';
import 'package:flutter/material.dart';
import '../../util/authentication.dart';
import '../../util/user_firestore.dart';
import '../Screen1.dart';
import '../start_up/sign_in_page.dart';

class UserSettingPage extends StatefulWidget {
  const UserSettingPage({Key? key}) : super(key: key);

  @override
  State<UserSettingPage> createState() => _UserSettingPageState();
}

class _UserSettingPageState extends State<UserSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('設定'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SignInPage()));
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        child: ListView(
          children: <Widget>[
            Divider(
              height: 3,
              thickness: 1,
            ),
            ListTile(
              title: Text('マイページ編集'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () async {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => UserProfilePage()));
              },
            ),
            Divider(
              height: 3,
              thickness: 1,
            ),
            ListTile(
              title: Text('レビューを書く'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () async {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => UserProfilePage()));
              },
            ),
            Divider(
              height: 3,
              thickness: 1,
            ),
            ListTile(
              title: Text('プライバシーポリシー'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () async {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => UserProfilePage()));
              },
            ),
            Divider(
              height: 3,
              thickness: 1,
            ),
            ListTile(
              title: Text('利用規約'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () async {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => UserProfilePage()));
              },
            ),
            Divider(
              height: 3,
              thickness: 1,
            ),
            ListTile(
              title: Text('特定商取引法に基づく表記'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () async {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => UserProfilePage()));
              },
            ),
            Divider(
              height: 3,
              thickness: 1,
            ),
            ListTile(
              title: Text('ご利用ガイド'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () async {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => UserProfilePage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
