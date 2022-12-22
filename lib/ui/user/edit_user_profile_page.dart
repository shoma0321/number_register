import 'package:firebase_intern_sample_app/ui/user/user_list_page.dart';
import 'package:firebase_intern_sample_app/ui/user/user_profile_page.dart';
import 'package:firebase_intern_sample_app/ui/user/user_search_page.dart';
import 'package:flutter/material.dart';
import '../../model/account_model.dart';
import '../../util/user_firestore.dart';
import '../Screen2.dart';
import '../screen.dart';

class EditUserProfilePage extends StatefulWidget {
  const EditUserProfilePage({Key? key}) : super(key: key);

  @override
  State<EditUserProfilePage> createState() => _EditUserProfilePageState();
}

class _EditUserProfilePageState extends State<EditUserProfilePage> {
  Account myAccount = UserFirestore.myAccount!;
  TextEditingController userNameController = TextEditingController();
  TextEditingController selfIntroductionController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController =
        TextEditingController(text: myAccount.userName);
    TextEditingController selfIntroductionController =
        TextEditingController(text: myAccount.selfIntroduction);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
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
                  decoration: const InputDecoration(hintText: '名前'),
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
                const SizedBox(height: 80),
                SizedBox(
                  height: 40,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;
                      try {
                        final account = Account(
                            id: myAccount.id,
                            userName: userNameController.text,
                            selfIntroduction: selfIntroductionController.text);
                        await UserFirestore.updateUser(account);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Screen2()));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('エラーが発生しました。もう一度お試しください'),
                          backgroundColor: Colors.red,
                        ));
                      }
                    },
                    child: const Text(
                      '登録',
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
