import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_intern_sample_app/util/user_firestore.dart';
import 'package:flutter/material.dart';
import '../start_up/sign_in_page.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
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
      body: SafeArea(
        child: FutureBuilder<List<Map<String, dynamic>>>(
            future: UserFirestore.listFavorite(UserFirestore.myAccount!),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('取得できませんでした'),
                );
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> company = snapshot.data![index];
                  return SizedBox(
                    height: 80,
                    child: Card(
                      child: ListTile(
                        title: Text(company['name']),
                        subtitle: Text(company['number']),
                        trailing: IconButton(
                          onPressed: () async {
                            await UserFirestore.removeFavorite(
                                UserFirestore.myAccount!, company['id']);
                            setState(() {});
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
