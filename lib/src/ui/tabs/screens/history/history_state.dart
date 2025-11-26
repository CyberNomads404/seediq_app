import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:seediq_app/src/data/models/classification_model.dart';

class HistoryState extends Equatable {
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorMessage;
  final List<ClassificationModel> classifications;

  const HistoryState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.errorMessage,
    this.classifications = const [],
  });

  HistoryState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? errorMessage,
    List<ClassificationModel>? classifications,
  }) {
    return HistoryState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: errorMessage ?? this.errorMessage,
      classifications: classifications ?? this.classifications,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isLoadingMore,
        hasMore,
        errorMessage,
        classifications,
      ];
}
