import 'dart:convert';

class Dashboard {
  final int quantityClassifications;
  Dashboard({
    required this.quantityClassifications,
  });

  Dashboard copyWith({
    int? quantityClassifications,
  }) {
    return Dashboard(
      quantityClassifications: quantityClassifications ?? this.quantityClassifications,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quantity_classifications': quantityClassifications,
    };
  }

  factory Dashboard.fromMap(Map<String, dynamic> map) {
    return Dashboard(
      quantityClassifications: map['quantity_classifications'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Dashboard.fromJson(String source) => Dashboard.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Dashboard(quantityClassifications: $quantityClassifications)';

  @override
  bool operator ==(covariant Dashboard other) {
    if (identical(this, other)) return true;
  
    return 
      other.quantityClassifications == quantityClassifications;
  }

  @override
  int get hashCode => quantityClassifications.hashCode;
}
