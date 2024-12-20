import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
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
    return snapshot.docs.map((doc) => GestBookItem.fromSnapshot(doc.data()))
        .toList();
  }

  Future<void> createRSVPItem(AttendanceModel attendance) async {
    final rsvpCollection = FirebaseFirestore.instance.collection('rsvp');
    await rsvpCollection.add(attendance.toMap());
  }

  // serverTimestamp
  FieldValue serverTimestamp() {
    return FieldValue.serverTimestamp();
  }

  /// 랜덤 Salt 생성
  String generateSalt([int length = 16]) {
    final random = Random.secure();
    final values = List<int>.generate(length, (i) => random.nextInt(256));
    return base64Url.encode(values);
  }

  /// 비밀번호와 Salt를 결합하여 해시 생성
  String hashPasswordWithSalt(String password, String salt) {
    final combined = password + salt; // 비밀번호와 Salt 결합
    final bytes = utf8.encode(combined); // 문자열을 바이트로 변환
    final hash = sha256.convert(bytes); // SHA-256 해싱
    return hash.toString(); // 해시 결과를 문자열로 반환
  }

  Future<void> saveGuestbookEntry(String message, String password, String author) async {
    final salt = generateSalt(); // Salt 생성
    final hashedPassword = hashPasswordWithSalt(password, salt); // 비밀번호 해싱

    await FirebaseFirestore.instance.collection('guestbook').add({
      'message': message,
      'passwordHash': hashedPassword,
      'salt': salt,
      'author': author,
      'createdAt': FieldValue.serverTimestamp(),
    });

    print("방명록 저장 완료!");
  }

  Future<void> updateGuestbookEntry(
      String documentId, String newMessage, String inputPassword) async {
    final docRef = FirebaseFirestore.instance.collection('guestbook').doc(
        documentId);
    final doc = await docRef.get();

    if (doc.exists) {
      final data = doc.data();
      final storedHash = data?['passwordHash'];
      final storedSalt = data?['salt'];

      // 입력된 비밀번호 검증
      final inputHash = hashPasswordWithSalt(inputPassword, storedSalt);
      if (inputHash == storedHash) {
        // 비밀번호가 일치하면 메시지 업데이트
        await docRef.update({'message': newMessage});
        print("방명록 수정 완료!");
      } else {
        throw Exception("비밀번호가 일치하지 않습니다.");
      }
    } else {
      throw Exception("방명록 항목을 찾을 수 없습니다.");
    }
  }
}