import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../../util/authentication.dart';
import '../../util/user_firestore.dart';
import '../Screen1.dart';
import 'create_account_page.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // final _auth = FirebaseAuth.instance;
  @override
  // void initState() {
  //   super.initState();
  //   _auth.authStateChanges().listen((User? user) {
  //     if (user == null) {
  //       print('User is currently signed out!');
  //     } else {
  //       print('User is signed in!');
  //     }
  //   });
  // }

  Widget build(BuildContext context) {
    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user == null) {
    //     print('User is currently signed out!');
    //   } else {
    //     print('User is signed in!');
    //   }
    // });
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('サインインページ'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 50, right: 50),
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: 'メールアドレス'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return value!.isEmpty ? '入力必須です' : null;
                  },
                ),
                const SizedBox(height: 50),
                TextFormField(
                  controller: passController,
                  obscureText: true,
                  decoration: const InputDecoration(hintText: 'パスワード'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return value!.isEmpty ? '入力必須です' : null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('登録をしていない方は'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CreateAccountPage()));
                      },
                      child: const Text('こちら'),
                    ),
                  ],
                ),
                const SizedBox(height: 100),
                SizedBox(
                  height: 40,
                  width: 100,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (!formKey.currentState!.validate()) return;
                        try {
                          final User? user = await Authentication.signIn(
                            email: emailController.text,
                            pass: passController.text,
                          );
                          await UserFirestore.getUser(user!.uid);
                          print(user!.uid);
                          // await UserFirestore.getUser(user!.uid);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Screen1()));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('エラーが発生しました。もう一度お試しください'),
                            backgroundColor: Colors.red,
                          ));
                        }
                      },
                      child: const Text(
                        'ログイン',
                        style: TextStyle(fontSize: 15),
                      )),
                ),
                const SizedBox(height: 100),
                // SizedBox(
                //   height: 40,
                //   width: 500,
                //   child: SignInButton(
                //     Buttons.Google,
                //     onPressed: () async {
                //       try {
                //         final userCredential =
                //             await Authentication.signInWithGoogle();
                //       } on FirebaseAuthException catch (e) {
                //         print('FirebaseAuthException');
                //         print('${e.code}');
                //       } on Exception catch (e) {
                //         print('Exception');
                //         print('${e.toString()}');
                //       }
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
