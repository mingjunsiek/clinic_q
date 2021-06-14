import 'dart:convert';

import 'package:clinic_q/model/address.dart';

class User {
  String nric;
  String firstName;
  String lastName;
  String phone;
  DateTime dob;
  Address address;
  String allergies;

  User({
    required this.nric,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.dob,
    required this.address,
    required this.allergies,
  });

  User copyWith({
    String? nric,
    String? firstName,
    String? lastName,
    String? phone,
    DateTime? dob,
    Address? address,
    String? allergies,
  }) {
    return User(
      nric: nric ?? this.nric,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      dob: dob ?? this.dob,
      address: address ?? this.address,
      allergies: allergies ?? this.allergies,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nric': nric,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'dob': dob.millisecondsSinceEpoch,
      'address': address.toMap(),
      'allergies': allergies,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      nric: map['nric'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      phone: map['phone'],
      dob: DateTime.fromMillisecondsSinceEpoch(map['dob']),
      address: Address.fromMap(map['address']),
      allergies: map['allergies'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(nric: $nric, firstName: $firstName, lastName: $lastName, phone: $phone, dob: $dob, address: $address, allergies: $allergies)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.nric == nric &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.phone == phone &&
        other.dob == dob &&
        other.address == address &&
        other.allergies == allergies;
  }

  @override
  int get hashCode {
    return nric.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        phone.hashCode ^
        dob.hashCode ^
        address.hashCode ^
        allergies.hashCode;
  }
}
