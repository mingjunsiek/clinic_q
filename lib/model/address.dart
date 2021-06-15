import 'dart:convert';

class Address {
  String blockNum;
  String streetName;
  String unitNum;
  String postalCode;

  Address({
    required this.blockNum,
    required this.streetName,
    required this.unitNum,
    required this.postalCode,
  });

  Address copyWith({
    String? blockNum,
    String? streetName,
    String? unitNum,
    String? postalCode,
  }) {
    return Address(
      blockNum: blockNum ?? this.blockNum,
      streetName: streetName ?? this.streetName,
      unitNum: unitNum ?? this.unitNum,
      postalCode: postalCode ?? this.postalCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'blockNum': blockNum,
      'streetName': streetName,
      'unitNum': unitNum,
      'postalCode': postalCode,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      blockNum: map['blockNum'],
      streetName: map['streetName'],
      unitNum: map['unitNum'],
      postalCode: map['postalCode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Address(blockNum: $blockNum, streetName: $streetName, unitNum: $unitNum, postalCode: $postalCode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Address &&
        other.blockNum == blockNum &&
        other.streetName == streetName &&
        other.unitNum == unitNum &&
        other.postalCode == postalCode;
  }

  @override
  int get hashCode {
    return blockNum.hashCode ^
        streetName.hashCode ^
        unitNum.hashCode ^
        postalCode.hashCode;
  }
}
