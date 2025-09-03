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

  late final _$_itemsAtom = Atom(name: '_HomeStore._items', context: context);

  ObservableList<int> get items {
    _$_itemsAtom.reportRead();
    return super._items;
  }

  @override
  ObservableList<int> get _items => items;

  @override
  set _items(ObservableList<int> value) {
    _$_itemsAtom.reportWrite(value, super._items, () {
      super._items = value;
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

  @override
  String toString() {
    return '''
hasItems: ${hasItems},
itemCount: ${itemCount}
    ''';
  }
}
