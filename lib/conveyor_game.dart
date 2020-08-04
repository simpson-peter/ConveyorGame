import 'dart:ui';
import 'package:fallingthings/ItemGenerator.dart';
import 'package:fallingthings/shopping_list.dart';
import 'data_models/game_data.dart';
import 'data_models/item_prototype.dart';
import 'package:provider/provider.dart';
import 'package:flame/game/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'data_models/item.dart';

//TODO Implement timer
//TODO Implement Streak Tracker

class ConveyorGame extends Game with TapDetector {
  Size screenSize;

  //double which tracks how long to wait between game state updates
  double _stepTime = kStepTime;
  //Keeps track of the time since the update loop last executed
  double _timeSinceStep = 0;
  //Keeps track of the time since the last item was generated
  double _timeSinceItemGen = 0;

  List<ItemPrototype> _itemsToGet = [
    ItemPrototype(itemID: 'A1', imgFilepath: 'orange_orange.png'),
    ItemPrototype(itemID: 'A2', imgFilepath: 'apple_red.png'),
    ItemPrototype(itemID: 'A4', imgFilepath: 'cake_normal.png'),
  ];

  //Tracks whether the round is over
  bool _isDone = false;

  //Holds all items on-screen
  List<Item> _items = List<Item>();

  ItemGenerator itemGenerator;

  ShoppingList _shoppingList;

  BuildContext context;

  //Constructor
  ConveyorGame(BuildContext context) {
    this.context = context;
    _shoppingList = new ShoppingList(itemList: _itemsToGet, context: context);
  }

  @override
  void render(Canvas canvas) {
    //Render background
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff000000);
    canvas.drawRect(bgRect, bgPaint);

    //Render items-to-make
    _shoppingList.render(canvas);

    //Render conveyor items
    for (Item item in _items) {
      item.render(canvas);
    }
  }

  @override
  void update(double t) {
    if (_isDone) {
      return;
    }
    if (_shoppingList.listCompleted()) {
      print('Game over');
      print('Score: ' +
          Provider.of<GameData>(context, listen: false).getScore().toString());
      _isDone = true;
    } else {
      //Create an item generator if it does not yet exist.
      if (itemGenerator == null) {
        itemGenerator = ItemGenerator(yPos: 50);
      }

      //Update time counter
      _timeSinceStep += t;
      _timeSinceItemGen += t;

      //Add any new items if necessary
      if (_timeSinceItemGen > kItemGenertatorTime) {
        itemGenerator.getNewItem(_items);
        _timeSinceItemGen = 0;
      }

      //If it's time to update the screen, do so.
      if (_timeSinceStep >= _stepTime) {
        _timeSinceStep = 0;
        //Iterate over all currently visible items
        for (int i = 0; i < _items.length; i++) {
          Item currItem = _items[i];

          //Make sure y position is properly adjusted
          currItem.yPos = screenSize.height / 2;

          //If the item has gone off the screen, remove it.
          if (currItem.width <= 0) {
            _items.removeAt(i);
          }
          //If the item has reached the end of the screen, shorten it.
          else if (currItem.xPos + currItem.width >= screenSize.width) {
            currItem.width -= 1;
          }
          //Otherwise just move the item along
          else {
            currItem.xPos += 1;
          }
        }
      }
    }
  }

  //Handles tap events. Checks each square to see if it was taps, and removes it if so.
  void onTapDown(TapDownDetails tapDownDetails) {
    if (_isDone) {
      return;
    }
    for (int i = 0; i < _items.length; i++) {
      Item item = _items[i];
      if (item.isTapped(tapDownDetails)) {
        if (_shoppingList.verifyMembership(toVerify: item)) {
          Provider.of<GameData>(context, listen: false).incrementCorrectTaps();
          Provider.of<GameData>(context, listen: false).incrementStreak();
        } else {
          Provider.of<GameData>(context, listen: false)
              .incrementIncorrectTaps();
          Provider.of<GameData>(context, listen: false).setStreak(0);
        }
        _items.removeAt(i);
        return;
      }
    }
  }

  void resize(Size size) {
    screenSize = size;
    //Provider.of<GameData>(context).setScreenSize(size);
    super.resize(size);
  }
}
