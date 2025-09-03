// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_details_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LocationDetailsStore on _LocationDetailsStore, Store {
  Computed<bool>? _$hasLocationComputed;

  @override
  bool get hasLocation =>
      (_$hasLocationComputed ??= Computed<bool>(
            () => super.hasLocation,
            name: '_LocationDetailsStore.hasLocation',
          ))
          .value;
  Computed<String>? _$mapUrlComputed;

  @override
  String get mapUrl =>
      (_$mapUrlComputed ??= Computed<String>(
            () => super.mapUrl,
            name: '_LocationDetailsStore.mapUrl',
          ))
          .value;

  late final _$_isLoadingAtom = Atom(
    name: '_LocationDetailsStore._isLoading',
    context: context,
  );

  bool get isLoading {
    _$_isLoadingAtom.reportRead();
    return super._isLoading;
  }

  @override
  bool get _isLoading => isLoading;

  @override
  set _isLoading(bool value) {
    _$_isLoadingAtom.reportWrite(value, super._isLoading, () {
      super._isLoading = value;
    });
  }

  late final _$_isRefreshingAtom = Atom(
    name: '_LocationDetailsStore._isRefreshing',
    context: context,
  );

  bool get isRefreshing {
    _$_isRefreshingAtom.reportRead();
    return super._isRefreshing;
  }

  @override
  bool get _isRefreshing => isRefreshing;

  @override
  set _isRefreshing(bool value) {
    _$_isRefreshingAtom.reportWrite(value, super._isRefreshing, () {
      super._isRefreshing = value;
    });
  }

  late final _$_locationAtom = Atom(
    name: '_LocationDetailsStore._location',
    context: context,
  );

  LocationData? get location {
    _$_locationAtom.reportRead();
    return super._location;
  }

  @override
  LocationData? get _location => location;

  @override
  set _location(LocationData? value) {
    _$_locationAtom.reportWrite(value, super._location, () {
      super._location = value;
    });
  }

  late final _$loadAsyncAction = AsyncAction(
    '_LocationDetailsStore.load',
    context: context,
  );

  @override
  Future<void> load({required int id}) {
    return _$loadAsyncAction.run(() => super.load(id: id));
  }

  late final _$refreshAsyncAction = AsyncAction(
    '_LocationDetailsStore.refresh',
    context: context,
  );

  @override
  Future<void> refresh({required int id}) {
    return _$refreshAsyncAction.run(() => super.refresh(id: id));
  }

  @override
  String toString() {
    return '''
hasLocation: ${hasLocation},
mapUrl: ${mapUrl}
    ''';
  }
}
