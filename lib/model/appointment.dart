import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  String clinicID;
  int queueNo;
  String userID;
  DateTime appointmentDate;

  Appointment({
    required this.clinicID,
    required this.queueNo,
    required this.userID,
    required this.appointmentDate,
  });

  Appointment copyWith({
    String? clinicID,
    int? queueNo,
    String? userID,
    DateTime? appointmentDate,
  }) {
    return Appointment(
      clinicID: clinicID ?? this.clinicID,
      queueNo: queueNo ?? this.queueNo,
      userID: userID ?? this.userID,
      appointmentDate: appointmentDate ?? this.appointmentDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'clinicID': clinicID,
      'queueNo': queueNo,
      'userID': userID,
      'appointmentDate': Timestamp.fromDate(appointmentDate),
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      clinicID: map['clinicID'],
      queueNo: map['queueNo'],
      userID: map['userID'],
      appointmentDate: (map['appointmentDate'] as Timestamp).toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Appointment.fromJson(String source) =>
      Appointment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Appointment(clinicID: $clinicID, queueNo: $queueNo, userID: $userID, appointmentDate: $appointmentDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Appointment &&
        other.clinicID == clinicID &&
        other.queueNo == queueNo &&
        other.userID == userID &&
        other.appointmentDate == appointmentDate;
  }

  @override
  int get hashCode {
    return clinicID.hashCode ^
        queueNo.hashCode ^
        userID.hashCode ^
        appointmentDate.hashCode;
  }
}
