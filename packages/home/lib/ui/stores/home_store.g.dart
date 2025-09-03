// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStore, Store {
  Computed<bool>? _$hasItemsComputed;

  @override
  bool get hasItems =>
      (_$hasItemsComputed ??= Computed<bool>(
            () => super.hasItems,
            name: '_HomeStore.hasItems',
          ))
          .value;
  Computed<int>? _$itemCountComputed;

  @override
  int get itemCount =>
      (_$itemCountComputed ??= Computed<int>(
            () => super.itemCount,
            name: '_HomeStore.itemCount',
          ))
          .value;
  Computed<ObservableList<LocationData>>? _$favoriteItemsComputed;

  @override
  ObservableList<LocationData> get favoriteItems =>
      (_$favoriteItemsComputed ??= Computed<ObservableList<LocationData>>(
            () => super.favoriteItems,
            name: '_HomeStore.favoriteItems',
          ))
          .value;
  Computed<bool>? _$hasFavoriteItemsComputed;

  @override
  bool get hasFavoriteItems =>
      (_$hasFavoriteItemsComputed ??= Computed<bool>(
            () => super.hasFavoriteItems,
            name: '_HomeStore.hasFavoriteItems',
          ))
          .value;
  Computed<ObservableList<LocationData>>? _$filteredItemsComputed;

  @override
  ObservableList<LocationData> get filteredItems =>
      (_$filteredItemsComputed ??= Computed<ObservableList<LocationData>>(
            () => super.filteredItems,
            name: '_HomeStore.filteredItems',
          ))
          .value;
  Computed<int>? _$filteredItemCountComputed;

  @override
  int get filteredItemCount =>
      (_$filteredItemCountComputed ??= Computed<int>(
            () => super.filteredItemCount,
            name: '_HomeStore.filteredItemCount',
          ))
          .value;

  late final _$_isLoadingAtom = Atom(
    name: '_HomeStore._isLoading',
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
    name: '_HomeStore._isRefreshing',
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

  late final _$_itemsAtom = Atom(name: '_HomeStore._items', context: context);

  ObservableList<LocationData> get items {
    _$_itemsAtom.reportRead();
    return super._items;
  }

  @override
  ObservableList<LocationData> get _items => items;

  @override
  set _items(ObservableList<LocationData> value) {
    _$_itemsAtom.reportWrite(value, super._items, () {
      super._items = value;
    });
  }

  late final _$_showFavoritesOnlyAtom = Atom(
    name: '_HomeStore._showFavoritesOnly',
    context: context,
  );

  bool get showFavoritesOnly {
    _$_showFavoritesOnlyAtom.reportRead();
    return super._showFavoritesOnly;
  }

  @override
  bool get _showFavoritesOnly => showFavoritesOnly;

  @override
  set _showFavoritesOnly(bool value) {
    _$_showFavoritesOnlyAtom.reportWrite(value, super._showFavoritesOnly, () {
      super._showFavoritesOnly = value;
    });
  }

  late final _$loadAsyncAction = AsyncAction(
    '_HomeStore.load',
    context: context,
  );

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  late final _$toggleFavoriteAsyncAction = AsyncAction(
    '_HomeStore.toggleFavorite',
    context: context,
  );

  @override
  Future<void> toggleFavorite({required int id, required bool isFavorite}) {
    return _$toggleFavoriteAsyncAction.run(
      () => super.toggleFavorite(id: id, isFavorite: isFavorite),
    );
  }

  late final _$refreshAsyncAction = AsyncAction(
    '_HomeStore.refresh',
    context: context,
  );

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  late final _$_HomeStoreActionController = ActionController(
    name: '_HomeStore',
    context: context,
  );

  @override
  void toggleShowFavoritesOnly() {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
      name: '_HomeStore.toggleShowFavoritesOnly',
    );
    try {
      return super.toggleShowFavoritesOnly();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
hasItems: ${hasItems},
itemCount: ${itemCount},
favoriteItems: ${favoriteItems},
hasFavoriteItems: ${hasFavoriteItems},
filteredItems: ${filteredItems},
filteredItemCount: ${filteredItemCount}
    ''';
  }
}
