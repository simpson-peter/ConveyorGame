import 'dart:ui';
import 'package:provider/provider.dart';

import 'package:flame/components/component.dart';
import 'package:flutter/cupertino.dart';

import 'data_models/game_data.dart';
import 'data_models/item.dart';

class ShoppingList extends PositionComponent {
  //Stores the
  List<Item> _itemList;
  BuildContext context;

  //Tracks which Items this shopping list has already matched for
  //color from Items passed into verifyColorMembership()
  Map<Color, Item> _alreadyMatched = Map<Color, Item>();
  //Tracks which items that have failed to match from those passed into verifyColorMembership()
  //Note this includes colors present in _itemList which are also present in _alreadyMatched()
  int _failedToMatch = 0;

  ShoppingList(
      {@required List<Item> itemList, @required BuildContext context}) {
    _itemList = itemList;
    //TODO Find an actual position for this
    double startPos = 375;
    for (Item item in _itemList) {
      item.xPos = startPos;
      startPos += item.width;
      item.yPos = 0;
    }
  }

  @override
  void render(Canvas c) {
    for (Item item in _itemList) {
      item.render(c);
    }
  }

  //Compares toVerify to potentially all items of _itemList, returns true if the two are the same color, false otherwise
  bool verifyColorMembership({Item toVerify}) {
    for (Item item in _itemList) {
      //If the color is found in the _itemList, that means it's a wanted color
      if (toVerify.itemColor == item.itemColor) {
        //If we've seen it before (set membership), it's counted as a wrong guess
        if (_alreadyMatched.containsKey(item.itemColor)) {
          _failedToMatch++;
          return false;
          //If we haven't seen it, it's a correct guess. Add to previous matches set.
        } else {
          _alreadyMatched[toVerify.itemColor] = toVerify;
          return true;
        }
      }
    }
    //If none of the colors match, it's an incorrect guess
    return false;
  }

  //Returns true if all _itemList members have been verified by verify
  bool listCompleted() {
    return _itemList.length <= _alreadyMatched.length;
  }
}
