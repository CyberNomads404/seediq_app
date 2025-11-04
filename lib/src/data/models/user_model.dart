import 'dart:convert';

import 'package:seediq_app/src/data/models/last_login_model.dart';

class UserModel {
  final String externalId;
  final String name;
  final String email;
  final String? avatarUrl;
  final int active;
  final String? phone;
  final String? roleUser;
  final List<String>? roles;
  final List<String>? permissions;
  final DateTime? emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final LastLogin lastLogin;

  UserModel({
    required this.externalId,
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.active,
    this.phone,
    this.roleUser,
    this.roles,
    this.permissions,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.lastLogin,
  });

  UserModel copyWith({
    String? externalId,
    String? name,
    String? email,
    String? avatarUrl,
    int? active,
    String? phone,
    String? roleUser,
    List<String>? roles,
    List<String>? permissions,
    DateTime? emailVerifiedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    LastLogin? lastLogin,
  }) {
    return UserModel(
      externalId: externalId ?? this.externalId,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      active: active ?? this.active,
      phone: phone ?? this.phone,
      roleUser: roleUser ?? this.roleUser,
      roles: roles ?? this.roles,
      permissions: permissions ?? this.permissions,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'external_id': externalId,
      'name': name,
      'email': email,
      'avatar_url': avatarUrl,
      'active': active,
      'phone': phone,
      'role_user': roleUser,
      'roles': roles,
      'permissions': permissions,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'last_login': lastLogin.toMap(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      externalId: map['external_id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      avatarUrl: map['avatar_url'] != null ? map['avatar_url'] as String : null,
      active: map['active'] is bool ? (map['active'] ? 1 : 0) : map['active'] as int,
      phone: map['phone'] != null ? map['phone'] as String : null,
      roleUser: map['role_user'] != null ? map['role_user'] as String : null,
      roles: map['roles'] != null ? List<String>.from(map['roles']) : null,
      permissions: map['permissions'] != null ? List<String>.from(map['permissions']) : null,
      emailVerifiedAt: map['email_verified_at'] != null ? DateTime.parse(map['email_verified_at']) : null,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      deletedAt: map['deleted_at'] != null ? DateTime.parse(map['deleted_at']) : null,
      lastLogin: LastLogin.fromMap(map['last_login'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(externalId: $externalId, name: $name, email: $email, active: $active, roleUser: $roleUser, phone: $phone)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
    return other.externalId == externalId &&
        other.email == email &&
        other.name == name;
  }

  @override
  int get hashCode => externalId.hashCode ^ email.hashCode ^ name.hashCode;
}