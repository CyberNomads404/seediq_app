import 'dart:convert';

class ClassificationResultModel {
  final String externalId;
  final dynamic? result;
  final num? good;
  final num? badDetection;
  final num? unknown;
  final num? burned;
  final num? greenish;
  final num? small;
  final DateTime createdAt;
  final String createdAtHuman;
  final DateTime updatedAt;
  final String updatedAtHuman;
  ClassificationResultModel({
    required this.externalId,
    this.result,
    this.good,
    this.badDetection,
    this.unknown,
    this.burned,
    this.greenish,
    this.small,
    required this.createdAt,
    required this.createdAtHuman,
    required this.updatedAt,
    required this.updatedAtHuman,
  });

  ClassificationResultModel copyWith({
    String? externalId,
    dynamic? result,
    num? good,
    num? badDetection,
    num? unknown,
    num? burned,
    num? greenish,
    num? small,
    DateTime? createdAt,
    String? createdAtHuman,
    DateTime? updatedAt,
    String? updatedAtHuman,
  }) {
    return ClassificationResultModel(
      externalId: externalId ?? this.externalId,
      result: result ?? this.result,
      good: good ?? this.good,
      badDetection: badDetection ?? this.badDetection,
      unknown: unknown ?? this.unknown,
      burned: burned ?? this.burned,
      greenish: greenish ?? this.greenish,
      small: small ?? this.small,
      createdAt: createdAt ?? this.createdAt,
      createdAtHuman: createdAtHuman ?? this.createdAtHuman,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedAtHuman: updatedAtHuman ?? this.updatedAtHuman,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'external_id': externalId,
      'result': result,
      'good': good,
      'bad_detection': badDetection,
      'unknown': unknown,
      'burned': burned,
      'greenish': greenish,
      'small': small,
      'created_at': createdAt.millisecondsSinceEpoch,
      'created_at_human': createdAtHuman,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'updated_at_human': updatedAtHuman,
    };
  }

  factory ClassificationResultModel.fromMap(Map<String, dynamic> map) {
    return ClassificationResultModel(
      externalId: map['external_id'] as String,
      result: map['result'] != null ? map['result'] as dynamic : null,
      good: map['good'] != null ? map['good'] as num : null,
      badDetection: map['bad_detection'] != null ? map['bad_detection'] as num : null,
      unknown: map['unknown'] != null ? map['unknown'] as num : null,
      burned: map['burned'] != null ? map['burned'] as num : null,
      greenish: map['greenish'] != null ? map['greenish'] as num : null,
      small: map['small'] != null ? map['small'] as num : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      createdAtHuman: map['created_at_human'] as String,
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
      updatedAtHuman: map['updated_at_human'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassificationResultModel.fromJson(String source) =>
      ClassificationResultModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'ClassificationResultModel(externalId: $externalId, result: $result, createdAt: $createdAt, createdAtHuman: $createdAtHuman, updatedAt: $updatedAt, updatedAtHuman: $updatedAtHuman)';
  }

  @override
  bool operator ==(covariant ClassificationResultModel other) {
    if (identical(this, other)) return true;

    return other.externalId == externalId &&
        other.result == result &&
        other.createdAt == createdAt &&
        other.createdAtHuman == createdAtHuman &&
        other.updatedAt == updatedAt &&
        other.updatedAtHuman == updatedAtHuman;
  }

  @override
  int get hashCode {
    return externalId.hashCode ^
        result.hashCode ^
        createdAt.hashCode ^
        createdAtHuman.hashCode ^
        updatedAt.hashCode ^
        updatedAtHuman.hashCode;
  }
}
