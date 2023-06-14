import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/models/item.dart';
import '../../../core/repositories/item_repository_provider.dart';
import '../../providers/loading_provider.dart';

final writeItemViewModelProvider =
    ChangeNotifierProvider((ref) => WriteItemViewModel(ref));

class WriteItemViewModel extends ChangeNotifier {
  final Ref _ref;

  WriteItemViewModel(this._ref);

  Item? _initial;
  Item get initial =>
      _initial ??
      Item.empty().copyWith(
        createdAt: DateTime.now(),
      );
  set initial(Item initial) {
    _initial = initial;
  }

  String? get image => initial.image.isNotEmpty ? initial.image : null;

  bool get edit => initial.id.isNotEmpty;

  String? _title;
  String get title => _title ?? initial.title;
  set title(String title) {
    _title = title;
    notifyListeners();
  }

  // String? _description;
  // String get description => _description ?? initial.description;
  // set description(String description) {
  //   _description = description;
  //   notifyListeners();
  // }

  String? _starttime;
  String get starttime => _starttime ?? initial.starttime;
  set starttime(String starttime) {
    _starttime = starttime;
    notifyListeners();
  }

  String? _endtime;
  String get endtime => _endtime ?? initial.endtime;
  set endtime(String endtime) {
    _endtime = endtime;
    notifyListeners();
  }

  String? _categories;
  String get categories => _categories ?? initial.categories;
  set categories(String categories) {
    _categories = categories;
    notifyListeners();
  }

  File? _file;
  File? get file => _file;
  set file(File? file) {
    _file = file;
    notifyListeners();
  }

  bool get enabled =>
      title.isNotEmpty &&
      starttime.isNotEmpty &&
      endtime.isNotEmpty &&
      categories.isNotEmpty &&
      (image != null || file != null);

  Loading get _loading => _ref.read(loadingProvider);

  ItemRepository get _repository => _ref.read(itemRepositoryProvider);

  Future<void> write() async {
    final updated = initial.copyWith(
      title: title,
      starttime: starttime,
      endtime: endtime,
      categories: categories,
      // description: description,
    );
    _loading.start();
    try {
      await _repository.writeItem(updated, file: file);
      _loading.stop();
    } catch (e) {
      _loading.end();
      return Future.error("Something error!");
    }
  }

  void clear() {
    _initial = null;
    _title = null;
    _starttime = null;
    _endtime = null;
    _categories = null;
    // _description = null;
    _file = null;
  }
}
