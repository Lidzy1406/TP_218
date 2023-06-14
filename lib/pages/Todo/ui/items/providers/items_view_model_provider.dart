import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/models/item.dart';
import '../../../core/repositories/item_repository_provider.dart';

final itemsViewModelProvider = ChangeNotifierProvider((ref) {
  final model = ItemsViewModel(ref);
  model.init();
  return model;
});

class ItemsViewModel extends ChangeNotifier {
  final Ref _ref;
  ItemsViewModel(this._ref);

  ItemRepository get _repository => _ref.read(itemRepositoryProvider);

  final List<DocumentSnapshot> _itemsDocs = [];

  List<Item> get items => _itemsDocs.map((e) => Item.fromFirestore(e)).toList();

  bool loading = true;
  bool busy = true;

  void init() async {
    try {
      _itemsDocs.addAll(await _repository.itemsPaginateFuture(limit: 8));
      busy = false;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void loadMore() async {
    busy = true;
    try {
      final moreItemsDocs = await _repository.itemsPaginateFuture(
        limit: 4,
        lastDocument: _itemsDocs.last,
      );
      _itemsDocs.addAll(moreItemsDocs);
      loading = moreItemsDocs.isNotEmpty;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    busy = false;
    notifyListeners();
  }
}
