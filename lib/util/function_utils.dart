// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
//
// class FunctionUtils {
//   static Future<String> uploadImage(
//       {required String uid, required File image}) async {
//     try {
//       final FirebaseStorage storageInstance = FirebaseStorage.instance;
//       final Reference ref = storageInstance.ref();
//       await ref.child(uid).putFile(image);
//       String downloadUrl = await storageInstance.ref(uid).getDownloadURL();
//       print('image_path: $downloadUrl');
//       return downloadUrl;
//     } catch (e) {
//       rethrow;
//     }
//   }
//
//   static Future<XFile?> getImageFromGallery() async {
//     ImagePicker picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     return pickedFile;
//   }
// }
