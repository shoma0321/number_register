import 'package:flutter/material.dart';

import 'sign_in_page.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController selfIntroductionController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('新規登録ページ'),
      ),
      body: Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 50, right: 50),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 80,
                    child: Icon(Icons.add),
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: userNameController,
                  decoration: const InputDecoration(hintText: 'ユーザー名'),
                  maxLength: 10,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: selfIntroductionController,
                  decoration: const InputDecoration(hintText: '自己紹介'),
                  maxLength: 25,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: 'メールアドレス'),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: passController,
                  obscureText: true,
                  decoration: const InputDecoration(hintText: 'パスワード'),
                ),
                const SizedBox(height: 80),
                SizedBox(
                  height: 40,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInPage()));
                    },
                    child: const Text(
                      '新規登録',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
