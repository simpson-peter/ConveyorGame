//Represents the abstract information for a class of item. The blueprint from which to make classes of this kind
import 'package:flutter/material.dart';

class ItemPrototype {
  //Alphanumeric ID starting from A0, A1, A2.... Z9.
  String itemID;
  //Path the to item asset image path relative to assets/images/
  String imgFilepath;

  ItemPrototype({@required this.itemID, @required this.imgFilepath});
}
