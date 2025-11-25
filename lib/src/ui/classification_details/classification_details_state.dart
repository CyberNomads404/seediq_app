import 'package:equatable/equatable.dart';
import 'package:seediq_app/src/data/models/classification_model.dart';

class ClassificationDetailsState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final ClassificationModel? classification;

  const ClassificationDetailsState({
    this.isLoading = false,
    this.errorMessage,
    this.classification,
  });

  ClassificationDetailsState copyWith({
    bool? isLoading,
    String? errorMessage,
    ClassificationModel? classification,
  }) {
    return ClassificationDetailsState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      classification: classification ?? this.classification,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    classification,
  ];
}