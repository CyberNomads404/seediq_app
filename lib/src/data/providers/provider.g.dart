// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userProvider)
const userProviderProvider = UserProviderProvider._();

final class UserProviderProvider
    extends $FunctionalProvider<UserProvider, UserProvider, UserProvider>
    with $Provider<UserProvider> {
  const UserProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userProviderHash();

  @$internal
  @override
  $ProviderElement<UserProvider> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserProvider create(Ref ref) {
    return userProvider(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserProvider value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserProvider>(value),
    );
  }
}

String _$userProviderHash() => r'bb52fdf46e5c4e2b5cb717c6981dbaa5b2fc1f44';
