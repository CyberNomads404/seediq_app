import 'dart:convert';

class CategoryModel {
  final String externalId;
  final String name;
  final String? iconUrl;
  CategoryModel({
    required this.externalId,
    required this.name,
    this.iconUrl,
  });

  

  CategoryModel copyWith({
    String? externalId,
    String? name,
    String? iconUrl,
  }) {
    return CategoryModel(
      externalId: externalId ?? this.externalId,
      name: name ?? this.name,
      iconUrl: iconUrl ?? this.iconUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'external_id': externalId,
      'name': name,
      'icon_url': iconUrl,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      externalId: map['external_id'] as String,
      name: map['name'] as String,
      iconUrl: map['icon_url'] != null ? map['icon_url'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) => CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CategoryModel(externalId: $externalId, name: $name, iconUrl: $iconUrl)';

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.externalId == externalId &&
      other.name == name &&
      other.iconUrl == iconUrl;
  }

  @override
  int get hashCode => externalId.hashCode ^ name.hashCode ^ iconUrl.hashCode;
}
