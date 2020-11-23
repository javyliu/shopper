import 'package:flutter/material.dart';
import 'package:shopper/models/catalog.dart';

class CartModel extends ChangeNotifier {
  CatalogModel _catalog;

  final List<int> _itemIds = [];

  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog) {
    assert(newCatalog != null);
    assert(_itemIds.every((element) => newCatalog.getById(element) != null), 'The catalog $newCatalog does not have one of $_itemIds in it.');
    _catalog = newCatalog;

    notifyListeners();
  }

  List<Item> get items => _itemIds.map((e) => _catalog.getById(e)).toList();

  int get totalPrice {
    return items.fold(0, (previousValue, element) => previousValue + element.price);
  }

  void add(Item item) {
    _itemIds.add(item.id);
    notifyListeners();
  }

  void remove(Item item) {
    _itemIds.remove(item.id);
    notifyListeners();
  }
}
