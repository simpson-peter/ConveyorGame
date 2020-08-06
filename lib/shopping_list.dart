import 'dart:ui';
import 'package:fallingthings/data_models/item_prototype.dart';
import 'package:flame/components/component.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_models/game_data.dart';
import 'item.dart';

class ShoppingList extends PositionComponent {
  //Stores the prototypes which the player is trying to match
  List<ItemPrototype> _itemList;
  //Stores the list of concrete Items() that mirror the _itemLists' prototypes.
  List<Item> _graphicItemList = List<Item>();

  //Used to graphically represent this shopping list.
  BuildContext context;

  //TODO Find an actual position for this
  double startPos = 200;

  //Tracks which Items this shopping list has already matched for
  //itemIDs from Items passed into verifyMembership()
  Map<String, ItemPrototype> _alreadyMatched = Map<String, ItemPrototype>();

  ShoppingList(
      {@required List<ItemPrototype> itemList,
      @required BuildContext context}) {
    _itemList = itemList;
    initializeGraphicItems();
  }

  @override
  void render(Canvas c) {
    for (Item item in _graphicItemList) {
      item.render(c);
    }
  }

  //Compares toVerify to potentially all items of _itemList, returns true if the two are the same color, false otherwise
  bool verifyMembership({Item toVerify}) {
    for (ItemPrototype prototype in _itemList) {
      //If the color is found in the _itemList, that means it's a wanted color
      if (toVerify.prototype.itemID == prototype.itemID) {
        //If we've seen it before (set membership), it's counted as a wrong guess
        if (_alreadyMatched.containsKey(prototype.itemID)) {
          return false;
          //If we haven't seen it, it's a correct guess. Add to previous matches set.
        } else {
          _alreadyMatched[toVerify.prototype.itemID] = toVerify.prototype;
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

  //Resets gameplay, makes it so the player has collected zero of the matching items
  void resetAlreadyMatched() {
    _alreadyMatched = Map<String, ItemPrototype>();
  }

  //Method to update the desired items shopping list which this class displays
  void setItemsToGet(List<ItemPrototype> newItemList) {
    _itemList = newItemList;
    initializeGraphicItems();
  }

  //Fills the _graphicItemList with concrete implementations of the prototypes represented in _itemList
  void initializeGraphicItems() {
    _graphicItemList = List<Item>();
    double drawPos = startPos;
    for (ItemPrototype prototype in _itemList) {
      _graphicItemList.add(
        Item(
          prototype: prototype,
          xPos: drawPos,
          //TODO Figure out how to get screen size here
          yPos: 0,
        ),
      );
      drawPos += Item.iconWidth;
    }
  }
}
