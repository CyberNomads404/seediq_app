import 'dart:convert';

class LastLogin {
  final dynamic web;
  final Api? api;

  LastLogin({
    this.web,
    this.api,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'web': web,
      'api': api?.toMap(),
    };
  }

  factory LastLogin.fromMap(Map<String, dynamic> map) {
    return LastLogin(
      web: map['web'],
      api: map['api'] != null ? Api.fromMap(map['api'] as Map<String, dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LastLogin.fromJson(String source) =>
      LastLogin.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Api {
  final DateTime lastUsedAt;
  final String tokenName;
  final DateTime createdAt;

  Api({
    required this.lastUsedAt,
    required this.tokenName,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'last_used_at': lastUsedAt.toIso8601String(),
      'token_name': tokenName,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory Api.fromMap(Map<String, dynamic> map) {
    return Api(
      lastUsedAt: DateTime.parse(map['last_used_at']),
      tokenName: map['token_name'] as String,
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Api.fromJson(String source) =>
      Api.fromMap(json.decode(source) as Map<String, dynamic>);
}