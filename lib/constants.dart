import 'package:flutter/material.dart';
import 'data_models/item_prototype.dart';

//Lists the various supported languages.
enum Language {
  LADIN,
}

enum Object {
  ORANGE_ORANGE,
  RED_APPLE,
  RED_BERRY,
  CAKE,
  BLUE_APPLE,
  GREEN_PEAR,
  PIZZA,
}

//Maps languages to the folder names in assets/audio/ in which that language's assets are stored
const Map<Language, String> kLangPathMap = {
  Language.LADIN: 'ladin',
};

const Map<Language, Map<Object, String>> kLangItemAudioMap = {
  Language.LADIN: {
    Object.ORANGE_ORANGE: 'ladin/pomerange.wav',
    Object.RED_APPLE: 'ladin/pom_de_elber.wav',
    Object.RED_BERRY: 'ladin/ampomola.wav',
    Object.CAKE: 'ladin/peta.wav',
    Object.BLUE_APPLE: 'ladin/pom_brun.wav',
    Object.GREEN_PEAR: 'ladin/peir.wav',
    Object.PIZZA: 'ladin/pizza.wav',
  },
};

//Effective logical framerate.
const double kStepTime = 0.015;
//Rate (item/sec) of item generation
const double kItemGenertatorTime = 2.5;

//Tracks the filepaths to all sprites and their associated IDs
List<ItemPrototype> kAllItemPrototypes = [
  ItemPrototype(
      itemID: 'A1',
      imgFilepath: 'orange_orange.png',
      audioFilepath: kLangItemAudioMap[Language.LADIN][Object.ORANGE_ORANGE]),
  ItemPrototype(
      itemID: 'A2',
      imgFilepath: 'apple_red.png',
      audioFilepath: kLangItemAudioMap[Language.LADIN][Object.RED_APPLE]),
  ItemPrototype(
      itemID: 'A3',
      imgFilepath: 'berry_red.png',
      audioFilepath: kLangItemAudioMap[Language.LADIN][Object.RED_BERRY]),
  ItemPrototype(
      itemID: 'A4',
      imgFilepath: 'cake_normal.png',
      audioFilepath: kLangItemAudioMap[Language.LADIN][Object.CAKE]),
  ItemPrototype(
      itemID: 'A5',
      imgFilepath: 'apple_blue.png',
      audioFilepath: kLangItemAudioMap[Language.LADIN][Object.BLUE_APPLE]),
  ItemPrototype(
      itemID: 'A6',
      imgFilepath: 'pear_green.png',
      audioFilepath: kLangItemAudioMap[Language.LADIN][Object.GREEN_PEAR]),
  ItemPrototype(
      itemID: 'A7',
      imgFilepath: 'pizza_normal.png',
      audioFilepath: kLangItemAudioMap[Language.LADIN][Object.PIZZA]),
];

//Tracks how much sprites should be scaled up by default
const Map<String, double> kSpriteScaleFactor = {
  'A1': 3,
  'A2': 3.3,
  'A3': 3.5,
  'A4': 3,
  'A5': 3,
  'A6': 3.3,
  'A7': 3,
};

const TextStyle kLargeTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontFamily: 'Press Start 2P',
);

//Tracks the sprite to use to render the conveyor
const String kConveyorAssetPath = 'conveyor_tile_clean.png';
