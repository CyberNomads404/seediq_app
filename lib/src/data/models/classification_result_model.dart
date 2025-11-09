import 'dart:convert';

class ClassificationResultModel {
  final String externalId;
  final dynamic? result;
  final DateTime createdAt;
  final String createdAtHuman;
  final DateTime updatedAt;
  final String updatedAtHuman;  
  ClassificationResultModel({
    required this.externalId,
    this.result,
    required this.createdAt,
    required this.createdAtHuman,
    required this.updatedAt,
    required this.updatedAtHuman,
  });
  

  ClassificationResultModel copyWith({
    String? externalId,
    dynamic? result,
    DateTime? createdAt,
    String? createdAtHuman,
    DateTime? updatedAt,
    String? updatedAtHuman,
  }) {
    return ClassificationResultModel(
      externalId: externalId ?? this.externalId,
      result: result ?? this.result,
      createdAt: createdAt ?? this.createdAt,
      createdAtHuman: createdAtHuman ?? this.createdAtHuman,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedAtHuman: updatedAtHuman ?? this.updatedAtHuman,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'externalId': externalId,
      'result': result,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'createdAtHuman': createdAtHuman,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'updatedAtHuman': updatedAtHuman,
    };
  }

  factory ClassificationResultModel.fromMap(Map<String, dynamic> map) {
    return ClassificationResultModel(
      externalId: map['externalId'] as String,
      result: map['result'] != null ? map['result'] as dynamic : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      createdAtHuman: map['createdAtHuman'] as String,
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      updatedAtHuman: map['updatedAtHuman'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassificationResultModel.fromJson(String source) => ClassificationResultModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClassificationResultModel(externalId: $externalId, result: $result, createdAt: $createdAt, createdAtHuman: $createdAtHuman, updatedAt: $updatedAt, updatedAtHuman: $updatedAtHuman)';
  }

  @override
  bool operator ==(covariant ClassificationResultModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.externalId == externalId &&
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
