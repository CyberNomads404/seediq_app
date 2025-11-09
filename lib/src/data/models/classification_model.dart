import 'dart:convert';

import 'package:seediq_app/src/data/models/category_model.dart';
import 'package:seediq_app/src/data/models/classification_result_model.dart';

class ClassificationModel {
  final String externalId;
  final String status;
  final String statusLabel;
  final String? message;
  final String fileUrl;
  final CategoryModel categoryForDisplay;
  final ClassificationResultModel? result;
  final DateTime createdAt;
  final String createdAtHuman;
  final DateTime updatedAt;
  final String updatedAtHuman;  
  ClassificationModel({
    required this.externalId,
    required this.status,
    required this.statusLabel,
    this.message,
    required this.fileUrl,
    required this.categoryForDisplay,
    this.result,
    required this.createdAt,
    required this.createdAtHuman,
    required this.updatedAt,
    required this.updatedAtHuman,
  });
  

  ClassificationModel copyWith({
    String? externalId,
    String? status,
    String? statusLabel,
    String? message,
    String? fileUrl,
    CategoryModel? categoryForDisplay,
    ClassificationResultModel? result,
    DateTime? createdAt,
    String? createdAtHuman,
    DateTime? updatedAt,
    String? updatedAtHuman,
  }) {
    return ClassificationModel(
      externalId: externalId ?? this.externalId,
      status: status ?? this.status,
      statusLabel: statusLabel ?? this.statusLabel,
      message: message ?? this.message,
      fileUrl: fileUrl ?? this.fileUrl,
      categoryForDisplay: categoryForDisplay ?? this.categoryForDisplay,
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
      'status': status,
      'statusLabel': statusLabel,
      'message': message,
      'fileUrl': fileUrl,
      'categoryForDisplay': categoryForDisplay.toMap(),
      'result': result?.toMap(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'createdAtHuman': createdAtHuman,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'updatedAtHuman': updatedAtHuman,
    };
  }

  factory ClassificationModel.fromMap(Map<String, dynamic> map) {
    return ClassificationModel(
      externalId: map['externalId'] as String,
      status: map['status'] as String,
      statusLabel: map['statusLabel'] as String,
      message: map['message'] != null ? map['message'] as String : null,
      fileUrl: map['fileUrl'] as String,
      categoryForDisplay: CategoryModel.fromMap(map['categoryForDisplay'] as Map<String,dynamic>),
      result: map['result'] != null ? ClassificationResultModel.fromMap(map['result'] as Map<String,dynamic>) : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      createdAtHuman: map['createdAtHuman'] as String,
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      updatedAtHuman: map['updatedAtHuman'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassificationModel.fromJson(String source) => ClassificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClassificationModel(externalId: $externalId, status: $status, statusLabel: $statusLabel, message: $message, fileUrl: $fileUrl, categoryForDisplay: $categoryForDisplay, result: $result, createdAt: $createdAt, createdAtHuman: $createdAtHuman, updatedAt: $updatedAt, updatedAtHuman: $updatedAtHuman)';
  }

  @override
  bool operator ==(covariant ClassificationModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.externalId == externalId &&
      other.status == status &&
      other.statusLabel == statusLabel &&
      other.message == message &&
      other.fileUrl == fileUrl &&
      other.categoryForDisplay == categoryForDisplay &&
      other.result == result &&
      other.createdAt == createdAt &&
      other.createdAtHuman == createdAtHuman &&
      other.updatedAt == updatedAt &&
      other.updatedAtHuman == updatedAtHuman;
  }

  @override
  int get hashCode {
    return externalId.hashCode ^
      status.hashCode ^
      statusLabel.hashCode ^
      message.hashCode ^
      fileUrl.hashCode ^
      categoryForDisplay.hashCode ^
      result.hashCode ^
      createdAt.hashCode ^
      createdAtHuman.hashCode ^
      updatedAt.hashCode ^
      updatedAtHuman.hashCode;
  }
}
