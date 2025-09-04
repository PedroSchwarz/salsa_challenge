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

  late final _$_isAppBarCollapsedAtom = Atom(
    name: '_LocationDetailsStore._isAppBarCollapsed',
    context: context,
  );

  bool get isAppBarCollapsed {
    _$_isAppBarCollapsedAtom.reportRead();
    return super._isAppBarCollapsed;
  }

  @override
  bool get _isAppBarCollapsed => isAppBarCollapsed;

  @override
  set _isAppBarCollapsed(bool value) {
    _$_isAppBarCollapsedAtom.reportWrite(value, super._isAppBarCollapsed, () {
      super._isAppBarCollapsed = value;
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

  late final _$_LocationDetailsStoreActionController = ActionController(
    name: '_LocationDetailsStore',
    context: context,
  );

  @override
  void setAppBarCollapsed(bool collapsed) {
    final _$actionInfo = _$_LocationDetailsStoreActionController.startAction(
      name: '_LocationDetailsStore.setAppBarCollapsed',
    );
    try {
      return super.setAppBarCollapsed(collapsed);
    } finally {
      _$_LocationDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
hasLocation: ${hasLocation}
    ''';
  }
}
