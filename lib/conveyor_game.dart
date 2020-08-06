import 'dart:math';
import 'dart:ui';
import 'package:fallingthings/ItemGenerator.dart';
import 'package:fallingthings/shopping_list.dart';
import 'conveyor.dart';
import 'data_models/game_data.dart';
import 'data_models/item_prototype.dart';
import 'package:provider/provider.dart';
import 'package:flame/game/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'item.dart';

class ConveyorGame extends Game with TapDetector {
  Size screenSize;

  //double which tracks how long to wait between game state updates
  double _stepTime = kStepTime;
  //Keeps track of the time since the update loop last executed
  double _timeSinceStep = 0;
  //Keeps track of the time since the last item was generated
  double _timeSinceItemGen = 0;

  //Handles rendering the animated conveyor in the game background
  Conveyor conveyorSprite;

  List<ItemPrototype> _itemsToGet;

  //Tracks whether the round is over
  bool _isDone = false;

  //Holds all items on-screen
  List<Item> _items = List<Item>();

  //Tracks the item prototype ID and corresponding item quantity which the user has picked during the current round.
  Map<String, int> _itemsPicked = Map<String, int>();

  ItemGenerator itemGenerator;

  ShoppingList _shoppingList;

  BuildContext context;

  Random rand = new Random(DateTime.now().millisecondsSinceEpoch);

  //Constructor
  ConveyorGame(BuildContext context) {
    this.context = context;
    conveyorSprite = Conveyor(
        screenWidth:
            Provider.of<GameData>(context, listen: false).screenSize.width);
    generateItemsToGet();
    _shoppingList =
        new ShoppingList(itemList: _itemsToGet, context: this.context);
  }

  @override
  void render(Canvas canvas) {
    //Render background
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xFF1c313a);
    canvas.drawRect(bgRect, bgPaint);

    //Render conveyor belt
    conveyorSprite.render(canvas);

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

      conveyorSprite.update(t);

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
            currItem.xPos += 2;
          }
        }
      }
    }
  }

  //Handles tap events. Checks each square to see if it was taps, and removes it if so.
  void onTapDown(TapDownDetails tapDownDetails) {
    if (_isDone) {
      _resetGame();
      return;
    }
    //Check all items to see if we've tapped it
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

        //Add the new item to the set which tracks the items the user has selected
        if (_itemsPicked.containsKey(item.prototype.itemID)) {
          _itemsPicked[item.prototype.itemID] =
              _itemsPicked[item.prototype.itemID] += 1;
        } else {
          _itemsPicked[item.prototype.itemID] = 1;
        }

        _items.removeAt(i);
        return;
      }
    }
  }

  //Method to re-start the game once it's done. Resets all data except state
  void _resetGame() {
    Provider.of<GameData>(context, listen: false).resetScore();
    _items = List<Item>();
    generateItemsToGet();
    _shoppingList.setItemsToGet(_itemsToGet);
    _shoppingList.resetAlreadyMatched();
    _itemsPicked.clear();
    _timeSinceItemGen = 0;
    _timeSinceStep = 0;
    _isDone = false;
  }

  void resize(Size size) {
    screenSize = size;
    conveyorSprite.updateScreenWidth(size.width);
    super.resize(size);
  }

  void generateItemsToGet() {
    _itemsToGet = new List<ItemPrototype>();
    //Tracks the indexes of kAllItemPrototypes which the toGet list will take items from
    Set<int> indexesToGet = Set<int>();

    //Pick n indices, where 1 <= n < kAllItemPrototypes.length
    int numberOfIndicesToGet = rand.nextInt(kAllItemPrototypes.length.toInt());

    if (numberOfIndicesToGet == 0) {
      numberOfIndicesToGet++;
    }

    //Pick items from the list of all items
    while (indexesToGet.length < numberOfIndicesToGet) {
      indexesToGet.add(rand.nextInt(kAllItemPrototypes.length));
    }

    //Fill the to get list
    for (int itemIdx in indexesToGet) {
      _itemsToGet.add(kAllItemPrototypes[itemIdx]);
    }
  }
}
