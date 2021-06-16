import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  String clinicID;
  String clinicName;
  int queueNo;
  String userID;
  DateTime appointmentDate;

  Appointment({
    required this.clinicID,
    required this.clinicName,
    required this.queueNo,
    required this.userID,
    required this.appointmentDate,
  });

  Appointment copyWith({
    String? clinicID,
    String? clinicName,
    int? queueNo,
    String? userID,
    DateTime? appointmentDate,
  }) {
    return Appointment(
      clinicID: clinicID ?? this.clinicID,
      clinicName: clinicName ?? this.clinicName,
      queueNo: queueNo ?? this.queueNo,
      userID: userID ?? this.userID,
      appointmentDate: appointmentDate ?? this.appointmentDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'clinicID': clinicID,
      'clinicName': clinicName,
      'queueNo': queueNo,
      'userID': userID,
      'appointmentDate': Timestamp.fromDate(appointmentDate),
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      clinicID: map['clinicID'],
      clinicName: map['clinicName'],
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
    return 'Appointment(clinicID: $clinicID, clinicName: $clinicName, queueNo: $queueNo, userID: $userID, appointmentDate: $appointmentDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Appointment &&
        other.clinicID == clinicID &&
        other.clinicName == clinicName &&
        other.queueNo == queueNo &&
        other.userID == userID &&
        other.appointmentDate == appointmentDate;
  }

  @override
  int get hashCode {
    return clinicID.hashCode ^
        clinicName.hashCode ^
        queueNo.hashCode ^
        userID.hashCode ^
        appointmentDate.hashCode;
  }
}
