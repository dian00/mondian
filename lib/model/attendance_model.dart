/* RSVP Model - attendance collection
* {
    'side': _attendeeSide,
    'name': _attendeeNameController.text,
    'attendees_count': int.tryParse(_attendeeCountController.text) ?? 0,
    'meal_required': _mealRequired,
    'timestamp': FieldValue.serverTimestamp(),
  }
*
* */
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceModel {
  String side;
  String name;
  int attendeesCount;
  bool mealRequired;
  FieldValue timestamp;

  AttendanceModel({
    required this.side,
    required this.name,
    required this.attendeesCount,
    required this.mealRequired,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'side': side,
      'name': name,
      'attendees_count': attendeesCount,
      'meal_required': mealRequired,
      'timestamp': timestamp,
    };
  }

  static AttendanceModel fromSnapshot(Map<String, dynamic> doc) {
    return AttendanceModel(
      side: doc['side'],
      name: doc['name'],
      attendeesCount: doc['attendees_count'],
      mealRequired: doc['meal_required'],
      timestamp: doc['timestamp'],
    );
  }
}