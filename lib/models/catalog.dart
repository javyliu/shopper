import 'package:flutter/material.dart';

///用户可以购买的商品目录的代理。
///在实际应用中，这可能由后端支持并缓存在设备上。
///在此示例应用程序中，目录是按程序生成的并且是无限的。
///为简单起见，目录应是不变的（没有产品会在应用执行期间添加，删除或更改）。
class CatalogModel {
  static List<String> itemNames = [
    'Code Smell',
    'Control Flow',
    'Interpreter',
    'Recursion',
    'Sprint',
    'Heisenbug',
    'Spaghetti',
    'Hydra Code',
    'Off-By-One',
    'Scope',
    'Callback',
    'Closure',
    'Automata',
    'Bit Shift',
    'Currying',
  ];

  ///在此示例中，目录是无限的，遍历[itemNames]。
  Item getById(int id) {
    return Item(id, itemNames[id % itemNames.length]);
  }

  ///通过商品在目录中的位置获取商品。
  ///在这种简化的情况下，商品在目录中的位置也是其ID
  Item getByPosition(int position) {
    return getById(position);
  }
}

@immutable
class Item {
  final int id;
  final String name;
  final Color color;
  final int price = 42;

  Item(this.id, this.name) : color = Colors.primaries[id % Colors.primaries.length];

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}
