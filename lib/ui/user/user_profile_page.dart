import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_intern_sample_app/model/account_model.dart';
import 'package:firebase_intern_sample_app/ui/user/edit_user_profile_page.dart';
import 'package:firebase_intern_sample_app/ui/user/user_list_page.dart';
import 'package:firebase_intern_sample_app/ui/user/user_search_page.dart';
import 'package:flutter/material.dart';
import '../../util/user_firestore.dart';
import '../start_up/sign_in_page.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  Account myAccount = UserFirestore.myAccount!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        padding: EdgeInsets.only(left: 50, right: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
