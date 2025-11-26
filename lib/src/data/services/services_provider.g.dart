// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localStorage)
const localStorageProvider = LocalStorageProvider._();

final class LocalStorageProvider
    extends
        $FunctionalProvider<
          LocalStorageService,
          LocalStorageService,
          LocalStorageService
        >
    with $Provider<LocalStorageService> {
  const LocalStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localStorageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localStorageHash();

  @$internal
  @override
  $ProviderElement<LocalStorageService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalStorageService create(Ref ref) {
    return localStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalStorageService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalStorageService>(value),
    );
  }
}

String _$localStorageHash() => r'1954e2a68747f69f85e77ac0726be7718a18fce6';

@ProviderFor(cameraService)
const cameraServiceProvider = CameraServiceProvider._();

final class CameraServiceProvider
    extends $FunctionalProvider<CameraService, CameraService, CameraService>
    with $Provider<CameraService> {
  const CameraServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cameraServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cameraServiceHash();

  @$internal
  @override
  $ProviderElement<CameraService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CameraService create(Ref ref) {
    return cameraService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CameraService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CameraService>(value),
    );
  }
}

String _$cameraServiceHash() => r'232bf2cb718221e8f2cb30cc97dd61432f1b8080';

@ProviderFor(authService)
const authServiceProvider = AuthServiceProvider._();

final class AuthServiceProvider
    extends $FunctionalProvider<AuthService, AuthService, AuthService>
    with $Provider<AuthService> {
  const AuthServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authServiceHash();

  @$internal
  @override
  $ProviderElement<AuthService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthService create(Ref ref) {
    return authService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthService>(value),
    );
  }
}

String _$authServiceHash() => r'27b514aa8d11a1de0d774cd4a27c2b0241c82f9f';

@ProviderFor(categoryService)
const categoryServiceProvider = CategoryServiceProvider._();

final class CategoryServiceProvider
    extends
        $FunctionalProvider<CategoryService, CategoryService, CategoryService>
    with $Provider<CategoryService> {
  const CategoryServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoryServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoryServiceHash();

  @$internal
  @override
  $ProviderElement<CategoryService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CategoryService create(Ref ref) {
    return categoryService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CategoryService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CategoryService>(value),
    );
  }
}

String _$categoryServiceHash() => r'ee0f352cb474c6a6be99445dc222de6e6dd55af2';

@ProviderFor(classificationService)
const classificationServiceProvider = ClassificationServiceProvider._();

final class ClassificationServiceProvider
    extends
        $FunctionalProvider<
          ClassificationService,
          ClassificationService,
          ClassificationService
        >
    with $Provider<ClassificationService> {
  const ClassificationServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'classificationServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$classificationServiceHash();

  @$internal
  @override
  $ProviderElement<ClassificationService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ClassificationService create(Ref ref) {
    return classificationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClassificationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClassificationService>(value),
    );
  }
}

String _$classificationServiceHash() =>
    r'83419f8dda29b6d555796613de43f8ce5d3034cf';

@ProviderFor(browserService)
const browserServiceProvider = BrowserServiceProvider._();

final class BrowserServiceProvider
    extends $FunctionalProvider<BrowserService, BrowserService, BrowserService>
    with $Provider<BrowserService> {
  const BrowserServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'browserServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$browserServiceHash();

  @$internal
  @override
  $ProviderElement<BrowserService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BrowserService create(Ref ref) {
    return browserService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BrowserService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BrowserService>(value),
    );
  }
}

String _$browserServiceHash() => r'abafecabccd08d622aa753e3b791ddc4dd57061d';
