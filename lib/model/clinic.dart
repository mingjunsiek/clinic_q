import 'dart:convert';

class Clinic {
  late String clinicID;
  String blkHseNo;
  String buildingName;
  String clinicName;
  String clinicTelNo;
  String floorNo;
  double lat;
  double lng;
  String placeID;
  int postalCode;
  String programmeCode;
  String streetName;
  String unitNo;

  Clinic({
    required this.blkHseNo,
    required this.buildingName,
    required this.clinicName,
    required this.clinicTelNo,
    required this.floorNo,
    required this.lat,
    required this.lng,
    required this.placeID,
    required this.postalCode,
    required this.programmeCode,
    required this.streetName,
    required this.unitNo,
  });

  Clinic copyWith({
    String? clinicID,
    String? blkHseNo,
    String? buildingName,
    String? clinicName,
    String? clinicTelNo,
    String? floorNo,
    double? lat,
    double? lng,
    String? placeID,
    int? postalCode,
    String? programmeCode,
    String? streetName,
    String? unitNo,
  }) {
    return Clinic(
      blkHseNo: blkHseNo ?? this.blkHseNo,
      buildingName: buildingName ?? this.buildingName,
      clinicName: clinicName ?? this.clinicName,
      clinicTelNo: clinicTelNo ?? this.clinicTelNo,
      floorNo: floorNo ?? this.floorNo,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      placeID: placeID ?? this.placeID,
      postalCode: postalCode ?? this.postalCode,
      programmeCode: programmeCode ?? this.programmeCode,
      streetName: streetName ?? this.streetName,
      unitNo: unitNo ?? this.unitNo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'clinicID': clinicID,
      'blkHseNo': blkHseNo,
      'buildingName': buildingName,
      'clinicName': clinicName,
      'clinicTelNo': clinicTelNo,
      'floorNo': floorNo,
      'lat': lat,
      'lng': lng,
      'placeID': placeID,
      'postalCode': postalCode,
      'programmeCode': programmeCode,
      'streetName': streetName,
      'unitNo': unitNo,
    };
  }

  factory Clinic.fromMap(Map<String, dynamic> map) {
    return Clinic(
      blkHseNo: map['blkHseNo'],
      buildingName: map['buildingName'],
      clinicName: map['clinicName'],
      clinicTelNo: map['clinicTelNo'],
      floorNo: map['floorNo'],
      lat: map['lat'],
      lng: map['lng'],
      placeID: map['placeID'],
      postalCode: map['postalCode'],
      programmeCode: map['programmeCode'],
      streetName: map['streetName'],
      unitNo: map['unitNo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Clinic.fromJson(String source) => Clinic.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Clinic(clinicID: $clinicID, blkHseNo: $blkHseNo, buildingName: $buildingName, clinicName: $clinicName, clinicTelNo: $clinicTelNo, floorNo: $floorNo, lat: $lat, lng: $lng, placeID: $placeID, postalCode: $postalCode, programmeCode: $programmeCode, streetName: $streetName, unitNo: $unitNo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Clinic &&
        other.clinicID == clinicID &&
        other.blkHseNo == blkHseNo &&
        other.buildingName == buildingName &&
        other.clinicName == clinicName &&
        other.clinicTelNo == clinicTelNo &&
        other.floorNo == floorNo &&
        other.lat == lat &&
        other.lng == lng &&
        other.placeID == placeID &&
        other.postalCode == postalCode &&
        other.programmeCode == programmeCode &&
        other.streetName == streetName &&
        other.unitNo == unitNo;
  }

  @override
  int get hashCode {
    return clinicID.hashCode ^
        blkHseNo.hashCode ^
        buildingName.hashCode ^
        clinicName.hashCode ^
        clinicTelNo.hashCode ^
        floorNo.hashCode ^
        lat.hashCode ^
        lng.hashCode ^
        placeID.hashCode ^
        postalCode.hashCode ^
        programmeCode.hashCode ^
        streetName.hashCode ^
        unitNo.hashCode;
  }
}
