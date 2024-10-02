import 'package:cloud_firestore/cloud_firestore.dart';

class FireDatabase {
  FireDatabase._();

  static final _firebaseFirestore = FirebaseFirestore.instance;
  static Future<void> addData({
    required String collection,
    String? doc,
    required Map<String, dynamic> data,
  }) async {
    try {
      if (doc != null) {
        await _firebaseFirestore.collection(collection).doc(doc).set(data);
      } else {
        await _firebaseFirestore.collection(collection).add(data);
      }
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

  static Future<dynamic> getData(
    String collection, {
    String? orderBy,
    bool descending = false,
    int? limit,
    dynamic startAfterValue, // for next page
    dynamic endBeforeValue, // for previous page
    bool isPrevious = false, // flag to detect if it is a previous page query
  }) async {
    try {
      Query<Map<String, dynamic>> query =
          _firebaseFirestore.collection(collection);

      // Apply ordering
      if (orderBy != null) {
        query = query.orderBy(orderBy, descending: descending);
      }

      // For next page
      if (startAfterValue != null && !isPrevious) {
        query = query.startAfter([startAfterValue]);
      }

      // For previous page (reverse the order)
      if (endBeforeValue != null && isPrevious) {
        query = query.endBefore([endBeforeValue]);
      }

      // Apply limit
      if (limit != null) {
        if (isPrevious) {
          query = query.limitToLast(limit);
        } else {
          query = query.limit(limit);
        }
      }

      // Get results
      return await query.get();
    } catch (e) {
      print(e);
      return null;
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
