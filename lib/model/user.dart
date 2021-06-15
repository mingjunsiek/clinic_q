import 'dart:convert';

class User {
  String nric;
  String email;
  String firstName;
  String lastName;
  String phone;
  DateTime dob;
  String allergies;

  User({
    required this.nric,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.dob,
    required this.allergies,
  });

  User copyWith({
    String? nric,
    String? email,
    String? firstName,
    String? lastName,
    String? phone,
    DateTime? dob,
    String? allergies,
  }) {
    return User(
      nric: nric ?? this.nric,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      dob: dob ?? this.dob,
      allergies: allergies ?? this.allergies,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nric': nric,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'dob': dob.millisecondsSinceEpoch,
      'allergies': allergies,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      nric: map['nric'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      phone: map['phone'],
      dob: DateTime.fromMillisecondsSinceEpoch(map['dob']),
      allergies: map['allergies'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(nric: $nric, email: $email, firstName: $firstName, lastName: $lastName, phone: $phone, dob: $dob, allergies: $allergies)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.nric == nric &&
        other.email == email &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.phone == phone &&
        other.dob == dob &&
        other.allergies == allergies;
  }

  @override
  int get hashCode {
    return nric.hashCode ^
        email.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        phone.hashCode ^
        dob.hashCode ^
        allergies.hashCode;
  }
}
