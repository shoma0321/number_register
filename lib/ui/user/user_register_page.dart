import 'package:firebase_intern_sample_app/ui/screen.dart';
import 'package:firebase_intern_sample_app/ui/user/user_search_page.dart';
import 'package:flutter/material.dart';
import '../../model/account_model.dart';
import '../../util/user_firestore.dart';
import '../Screen1.dart';

class UserRegisterPage extends StatefulWidget {
  const UserRegisterPage({Key? key}) : super(key: key);

  @override
  _UserRegisterPageState createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController commentController = TextEditingController();
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
                  controller: numberController,
                  decoration: const InputDecoration(hintText: 'ハイフンあり電話番号'),
                  maxLength: 20,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return value!.isEmpty ? '入力必須です' : null;
                  },
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: companyNameController,
                  decoration: const InputDecoration(hintText: '会社名'),
                  maxLength: 25,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return value!.isEmpty ? '入力必須です' : null;
                  },
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: commentController,
                  decoration: const InputDecoration(hintText: '電話内容'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    return value!.isEmpty ? '入力必須です' : null;
                  },
                ),
                const SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Screen1()));
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
                            final newComapny = CompanyAccount(
                                number: numberController.text,
                                companyName: companyNameController.text,
                                comment: commentController.text);
                            await CompanyFirestore.setCompany(newComapny);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Screen1()));
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
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
