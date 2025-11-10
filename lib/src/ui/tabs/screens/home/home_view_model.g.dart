// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeViewModel)
const homeViewModelProvider = HomeViewModelProvider._();

final class HomeViewModelProvider
    extends
        $NotifierProvider<HomeViewModel, AsyncValue<ApiResponse<dynamic>?>> {
  const HomeViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeViewModelHash();

  @$internal
  @override
  HomeViewModel create() => HomeViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<ApiResponse<dynamic>?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<ApiResponse<dynamic>?>>(
        value,
      ),
    );
  }
}

String _$homeViewModelHash() => r'9fc33637d17a1a2e59a80512fc10c30237cf149d';

abstract class _$HomeViewModel
    extends $Notifier<AsyncValue<ApiResponse<dynamic>?>> {
  AsyncValue<ApiResponse<dynamic>?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<ApiResponse<dynamic>?>,
              AsyncValue<ApiResponse<dynamic>?>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<ApiResponse<dynamic>?>,
                AsyncValue<ApiResponse<dynamic>?>
              >,
              AsyncValue<ApiResponse<dynamic>?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
