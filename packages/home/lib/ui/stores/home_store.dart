import 'package:logging/logging.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  final _log = Logger('HomeStore');

  @readonly
  bool _isLoading = false;

  @readonly
  ObservableList<int> _items = ObservableList.of([]);

  @computed
  bool get hasItems => _items.isNotEmpty;

  @computed
  int get itemCount => _items.length;

  @action
  Future<void> load() async {
    _isLoading = true;
    try {
      await Future.delayed(const Duration(seconds: 2));
      _items.clear();
      _items.addAll([1, 2, 3]);
    } catch (e) {
      _log.severe('Error loading items', e);
    } finally {
      _isLoading = false;
    }
  }
}
