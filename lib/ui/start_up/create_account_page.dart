import 'package:firebase_intern_sample_app/util/authentication.dart';
import 'package:flutter/material.dart';
import '../../model/account_model.dart';
import '../../util/user_firestore.dart';
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 50, right: 50),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: userNameController,
                  decoration: const InputDecoration(hintText: 'ユーザー名'),
                  maxLength: 10,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return value!.isEmpty ? '入力必須です' : null;
                  },
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: selfIntroductionController,
                  decoration: const InputDecoration(hintText: '自己紹介'),
                  maxLength: 25,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return value!.isEmpty ? '入力必須です' : null;
                  },
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: 'メールアドレス'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return value!.isEmpty ? '入力必須です' : null;
                  },
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: passController,
                  obscureText: true,
                  decoration: const InputDecoration(hintText: 'パスワード'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return value!.isEmpty ? '入力必須です' : null;
                  },
                ),
                const SizedBox(height: 80),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                        '戻る',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  SizedBox(
                    height: 40,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (!formKey.currentState!.validate()) return;
                        try {
                          final credential = await Authentication.signUp(
                            email: emailController.text,
                            pass: passController.text,
                          );

                          final newAccount = Account(
                              id: credential.user!.uid,
                              userName: userNameController.text,
                              selfIntroduction:
                                  selfIntroductionController.text);
                          await UserFirestore.setUser(newAccount);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInPage()));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('エラーが発生しました。もう一度お試しください'),
                            backgroundColor: Colors.red,
                          ));
                        }
                      },
                      child: const Text(
                        '新規登録',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          )),
    );
  }
}
