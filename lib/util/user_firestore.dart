import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/account_model.dart';

class UserFirestore {
  static final firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference users =
      firestoreInstance.collection('users');

  //新規ユーザーの登録関数
  static Future<void> setUser(Account newAccount) async {
    try {
      await users.doc(newAccount.id).set({
        'name': newAccount.userName,
        'self_introduction': newAccount.selfIntroduction,
      });
      print('ユーザー登録完了');
    } catch (e) {
      print('ユーザー登録エラー: $e');
      rethrow;
    }
  }

  //ユーザー情報の取得
  static Account? myAccount;
  static Future<void> getUser(String uid) async {
    try {
      DocumentSnapshot documentSnapshot = await users.doc(uid).get();
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      Account account = Account(
        id: uid,
        userName: data['name'],
        selfIntroduction: data['self_introduction'],
      );
      myAccount = account;
      print('ユーザー取得完了');
    } catch (e) {
      print('ユーザー取得エラー: $e');
      rethrow;
    }
  }

  //ユーザー情報の編集
  static Future<void> updateUser(Account account) async {
    try {
      await users.doc(account.id).update({
        'name': account.userName,
        'self_introduction': account.selfIntroduction,
      });
      myAccount = account;
      print('ユーザー情報の更新完了');
    } catch (e) {
      print('ユーザ情報更新エラー: $e');
      rethrow;
    }
  }

  //お気に入りリストに登録
  static Future<bool> addFavorite(Account account, String documentId) async {
    DocumentSnapshot documentSnapshot = await users.doc(account.id).get();
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    List<dynamic>? favoriteList = data['favorite'];

    if (favoriteList != null && favoriteList.contains(documentId)) return false;
    try {
      favoriteList != null
          ? favoriteList.add(documentId)
          : favoriteList = [documentId];
      await users.doc(account.id).update({'favorite': favoriteList});
      print('お気に入り登録完了');
      return true;
    } catch (e) {
      print('お気に入り登録エラー: $e');
      rethrow;
    }
  }

  //お気に入りリストを表示
  static Future<List<Map<String, dynamic>>> listFavorite(
      Account account) async {
    DocumentSnapshot documentUserSnapshot = await users.doc(account.id).get();
    Map<String, dynamic> userData =
        documentUserSnapshot.data() as Map<String, dynamic>;
    List<dynamic>? favoriteList = userData['favorite'];

    if (favoriteList == null) return [];

    List<Map<String, dynamic>> companyList = [];
    try {
      await Future.forEach(favoriteList!, (dynamic id) async {
        final doc = await CompanyFirestore.companys.doc(id.toString()).get();
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        companyList.add(data);
      });
      return companyList;
    } catch (e) {
      rethrow;
    }
  }

  //お気に入りにした会社を削除
  static Future<void> removeFavorite(Account account, String id) async {
    DocumentSnapshot documentSnapshot = await users.doc(account.id).get();
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    List<dynamic>? favoriteList = data['favorite'];

    try {
      favoriteList!.remove(id);
      await users.doc(account.id).update({'favorite': favoriteList});
      print('お気に入り削除完了');
    } catch (e) {
      print('お気に入り削除エラー: $e');
      rethrow;
    }
  }
}

class CompanyFirestore {
  static final firestoreInstance = FirebaseFirestore.instance;
  static final CollectionReference companys =
      firestoreInstance.collection('companys');

  //会社を登録する関数
  static Future<void> setCompany(CompanyAccount newCompany) async {
    try {
      final companyDoc = companys.doc();
      await companyDoc.set({
        'id': companyDoc.id,
        'name': newCompany.companyName,
        'number': newCompany.number,
        'comment': newCompany.comment,
      });
      print('会社登録完了');
    } catch (e) {
      print('会社登録エラー: $e');
      rethrow;
    }
  }

  //会社情報を取得する
  static Future<Map<String, dynamic>> getCompany(String id) async {
    try {
      DocumentSnapshot documentSnapshot = await companys.doc(id).get();
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      return data;
      print('会社取得完了');
    } catch (e) {
      print('会社取得エラー: $e');
      rethrow;
    }
  }

  //会社のコメントを追加する関数
  static Future<void> addComment(String documentId, String comment) async {
    DocumentSnapshot documentSnapshot = await companys.doc(documentId).get();
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    List<dynamic>? commentList = data['comment'];

    try {
      commentList!.add(comment);
      await companys.doc(documentId).update({'comment': commentList});
      print('コメント追加完了');
    } catch (e) {
      print('コメント追加エラー: $e');
      rethrow;
    }
  }
}
