import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_intern_sample_app/ui/screen.dart';
import 'package:firebase_intern_sample_app/ui/user/user_list_page.dart';
import 'package:firebase_intern_sample_app/ui/user/user_profile_page.dart';
import 'package:firebase_intern_sample_app/ui/user/user_search_page.dart';
import 'package:flutter/material.dart';
import '../../model/account_model.dart';
import '../../util/user_firestore.dart';
import '../Screen1.dart';
import '../start_up/sign_in_page.dart';
import 'edit_user_profile_page.dart';

class UserCompanysDetailPage extends StatefulWidget {
  const UserCompanysDetailPage({required this.documentId, Key? key})
      : super(key: key);
  final String documentId;

  @override
  _UserCompanysDetailPageState createState() => _UserCompanysDetailPageState();
}

class _UserCompanysDetailPageState extends State<UserCompanysDetailPage> {
  TextEditingController commentController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> InputDialog(BuildContext context) async {
    //処理が重い(?)からか、非同期処理にする
    return showDialog(
        context: context,
        builder: (context) {
          return Form(
            key: formKey,
            child: AlertDialog(
              title: Text('コメント入力'),
              content: TextFormField(
                controller: commentController,
                decoration: InputDecoration(hintText: "ここに入力"),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return value!.isEmpty ? '入力必須です' : null;
                },
              ),
              actions: <Widget>[
                TextButton(
                  // color: Colors.white,
                  // textColor: Colors.blue,
                  child: Text('キャンセル'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  // color: Colors.white,
                  // textColor: Colors.blue,
                  child: Text('OK'),
                  onPressed: () async {
                    final companyComment = commentController.text;
                    await CompanyFirestore.addComment(
                        widget.documentId, companyComment);

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Screen()));
                  },
                ),
              ],
            ),
          );
        });
  }

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
      body: FutureBuilder(
          future: CompanyFirestore.getCompany(widget.documentId),
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('予期せぬエラーが発生しました。もう一度お試しください。'),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text('予期せぬエラーが発生しました。もう一度お試しください。'),
              );
            }
            final CompanyAccount companyAccount = CompanyAccount(
                id: snapshot.data!['id'],
                companyName: snapshot.data!['name'],
                number: snapshot.data!['number'],
                comment: snapshot.data!['comment']);
            return Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Text(
                    companyAccount.companyName,
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 40,
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () async {
                        final favorite = await UserFirestore.addFavorite(
                            UserFirestore.myAccount!, widget.documentId);

                        if (favorite == true) {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Screen(),
                              ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('既にお気に入り登録がされています。'),
                            backgroundColor: Colors.red,
                          ));
                        }
                      },
                      child: const Text(
                        'Myリストに登録',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 80,
                    child: Card(
                      child: ListTile(
                        title: Center(
                          child: Text(
                            companyAccount.number,
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          InputDialog(context);
                        },
                        title: Text(
                          "コメントを追加する",
                          style: TextStyle(fontSize: 15),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: Card(
                      child: ListTile(
                        title: Text(
                          "電話内容",
                          style: TextStyle(fontSize: 15),
                        ),
                        subtitle: Text(
                          companyAccount.comment,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 40,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Screen1()));
                      },
                      child: const Text(
                        '戻る',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
