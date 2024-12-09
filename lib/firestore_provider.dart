import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mondian/model/attendance_model.dart';
import 'package:mondian/widget/gestbook_widget.dart';

class FirestoreProvider {
  Future<void> createGestBookItem(GestBookItem post) async {
    final postCollection = FirebaseFirestore.instance.collection('gestbook');
    await postCollection.add(post.toMap());
  }

  Future<List<GestBookItem>> fetchGestBookItems() async {
    final postCollection = FirebaseFirestore.instance.collection('gestbook');
    final snapshot = await postCollection.get();
    return snapshot.docs.map((doc) => GestBookItem.fromSnapshot(doc.data())).toList();
  }

  Future<void> createRSVPItem(AttendanceModel attendance) async {
    final rsvpCollection = FirebaseFirestore.instance.collection('rsvp');
    await rsvpCollection.add(attendance.toMap());
  }

  // serverTimestamp
  FieldValue serverTimestamp() {
    return FieldValue.serverTimestamp();
  }
}