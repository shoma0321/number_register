import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_intern_sample_app/ui/user/user_companys_detail_page.dart';
import 'package:firebase_intern_sample_app/ui/user/user_list_page.dart';
import 'package:firebase_intern_sample_app/ui/user/user_profile_page.dart';
import 'package:firebase_intern_sample_app/ui/user/user_register_page.dart';
import 'package:firebase_intern_sample_app/util/user_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onSearchProvider = StateProvider((ref) => false);
final StateProvider<List<int>> searchIndexListProvider =
    StateProvider((ref) => []);

class UserSearchPage extends ConsumerWidget {
  UserSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> wordList = [];
    List<String> numberList = [];
    List<String> idList = [];
    final onSearchNotifier = ref.watch(onSearchProvider.notifier);
    final onSearch = ref.watch(onSearchProvider);
    final searchIndexListNotifier = ref.watch(searchIndexListProvider.notifier);

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: FutureBuilder(
              future: FirebaseFirestore.instance.collection('companys').get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
                wordList = snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return data['name'].toString();
                }).toList();

                numberList =
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return data['number'].toString();
                }).toList();
                return onSearch
                    ? _searchTextField(context, ref, wordList, numberList)
                    : const Text("Search");
              }),
          actions: onSearch
              ? [
                  IconButton(
                      onPressed: () {
                        onSearchNotifier.state = false;
                      },
                      icon: const Icon(Icons.clear)),
                ]
              : [
                  IconButton(
                      onPressed: () {
                        onSearchNotifier.state = true;
                        searchIndexListNotifier.state = [];
                      },
                      icon: const Icon(Icons.search)),
                ]),
      body: FutureBuilder(
          future: FirebaseFirestore.instance.collection('companys').get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
            wordList = snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return data['name'].toString();
            }).toList();

            numberList = snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return data['number'].toString();
            }).toList();

            idList = snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return data['id'].toString();
            }).toList();

            return onSearch
                ? _searchListView(context, idList, ref, wordList, numberList)
                : _defaultListView(context, idList, wordList, numberList);
          }),
    );
  }

  Widget _searchTextField(BuildContext context, WidgetRef ref,
      List<String> wordList, List<String> numberList) {
    final searchIndexListNotifier = ref.watch(searchIndexListProvider.notifier);
    final List<int> searchIndexList = ref.watch(searchIndexListProvider);
    return TextField(
      cursorColor: Colors.black,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.search, color: Colors.black),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.black),
        ),
        hintText: '会社名または番号',
      ),
      onChanged: (String text) {
        searchIndexListNotifier.state = [];
        for (int i = 0; i < wordList.length | numberList.length; i++) {
          if (wordList[i].contains(text) | numberList[i].contains(text)) {
            searchIndexListNotifier.state.add(i);
          }
        }
      },
    );
  }

  Widget _searchListView(BuildContext context, List<String> idList,
      WidgetRef ref, List<String> wordList, List<String> numberList) {
    final searchIndexListNotifier = ref.watch(searchIndexListProvider.notifier);
    final searchIndexList = ref.watch(searchIndexListProvider);
    return Scaffold(
      body: ListView.builder(
          itemCount: searchIndexList.length,
          itemBuilder: (context, int index) {
            index = searchIndexListNotifier.state[index];

            return Card(
              child: ListTile(
                title: Text(wordList[index]),
                subtitle: Text(numberList[index]),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () async {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserCompanysDetailPage(
                                documentId: idList[index],
                              )));
                },
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => UserRegisterPage()));
        },
      ),
    );
  }

  Widget _defaultListView(BuildContext context, List<String> idList,
      List<String> wordList, List<String> numberList) {
    return Scaffold(
      body: ListView.builder(
        itemCount: wordList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(wordList[index]),
              subtitle: Text(numberList[index]),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () async {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserCompanysDetailPage(
                              documentId: idList[index],
                            )));
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => UserRegisterPage()));
        },
      ),
    );
  }
}
