import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flutter/cupertino.dart';

import 'data_models/item.dart';

class ShoppingList extends PositionComponent {
  //Stores the
  List<Item> _itemList;
  BuildContext context;

  ShoppingList(
      {@required List<Item> itemList, @required BuildContext context}) {
    _itemList = itemList;
  }

  @override
  void render(Canvas c) {
    for (Item item in _itemList) {
      item.render(c);
    }
  }
}
