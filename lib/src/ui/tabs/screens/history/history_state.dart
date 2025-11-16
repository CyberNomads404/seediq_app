import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:seediq_app/src/data/models/classification_model.dart';

class HistoryState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final List<ClassificationModel>? classifications;

  const HistoryState({
    this.isLoading = false,
    this.errorMessage,
    this.classifications,
  });

  HistoryState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<ClassificationModel>? classifications,
  }) {
    return HistoryState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      classifications: classifications ?? this.classifications,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    classifications,
  ];
}
