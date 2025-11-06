class ApiResponse<T> {
  final String status;
  final String message;
  final T? data;
  final Map<String, dynamic>? errors;

  ApiResponse({
    required this.status,
    required this.message,
    this.data,
    this.errors,
  });

  factory ApiResponse.fromMap(
    Map<String, dynamic> map, {
    T Function(dynamic json)? fromJson,
  }) {
    final rawData = map['data'];

    return ApiResponse<T>(
      status: map['status'] as String,
      message: map['message'] as String,
      data: fromJson != null && rawData != null
          ? fromJson(rawData)
          : rawData as T?,
      errors: map['errors'] != null
          ? Map<String, dynamic>.from(map['errors'])
          : null,
    );
  }
}
