import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  //新規登録機能
  static Future<UserCredential> signUp(
      {required String email, required String pass}) async {
    try {
      UserCredential newAccount = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      print('authサインアップ完了');
      return newAccount;
    } catch (e) {
      print('authサインアップエラー: $e');
      rethrow;
    }
  }

  //ログイン機能
  static Future<User?> signIn(
      {required String email, required String pass}) async {
    try {
      final UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      final currentFirebaseUser = result.user;
      print('authサインイン完了');
      return currentFirebaseUser;
    } catch (e) {
      print('authサインインエラー');
      rethrow;
    }
  }

// // Googleを使ってサインイン
// static Future<UserCredential> signInWithGoogle() async {
//   // 認証フローのトリガー
//   final googleUser = await GoogleSignIn(scopes: [
//     'email',
//   ]).signIn();
//   // リクエストから、認証情報を取得
//   final googleAuth = await googleUser?.authentication;
//   // クレデンシャルを新しく作成
//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth?.accessToken,
//     idToken: googleAuth?.idToken,
//   );
//   // サインインしたら、UserCredentialを返す
//   return FirebaseAuth.instance.signInWithCredential(credential);
// }
}
