import 'package:cloud_firestore/cloud_firestore.dart';

class FireDatabase {
  FireDatabase._();

  static final _firebaseFirestore = FirebaseFirestore.instance;
  static Future<void> addData(
      String collection, Map<String, dynamic> data) async {
    try {
      await _firebaseFirestore.collection(collection).add(data);
    } catch (e) {
      print(e);
    }
  }

  static Future<void> updateData(
      String collection, String id, Map<String, dynamic> data) async {
    try {
      await _firebaseFirestore.collection(collection).doc(id).update(data);
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deleteData(String collection, String id) async {
    try {
      await _firebaseFirestore.collection(collection).doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> getData(String collection) async {
    try {
      final data = await _firebaseFirestore.collection(collection).get();
      return data.docs;
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> getDocument(String collection, String id) async {
    try {
      final data =
          await _firebaseFirestore.collection(collection).doc(id).get();
      return data.data();
    } catch (e) {
      print(e);
    }
  }

  static Stream<QuerySnapshot> streamData(String collection) {
    return _firebaseFirestore.collection(collection).snapshots();
  }

  static Stream<DocumentSnapshot> streamDocument(String collection, String id) {
    return _firebaseFirestore.collection(collection).doc(id).snapshots();
  }

  static Future<void> addDataWithId(
      String collection, String id, Map<String, dynamic> data) async {
    try {
      await _firebaseFirestore.collection(collection).doc(id).set(data);
    } catch (e) {
      print(e);
    }
  }
}
