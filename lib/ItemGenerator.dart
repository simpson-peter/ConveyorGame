import 'data_models/item.dart';
import 'dart:math';

class ItemGenerator {
  //Tracks when to begin counting item production.
  int _startTime;

  //Random number generator to generate apple positions, seed with the time
  Random _rand;

  //Tracks the elapsed time since the last newItem request (secs)
  double _timeSinceLast = 0;
  //length of time between item generation (secs)
  double _productionInterval = 1;
  //List of Items from which to generate
  List<Item> items;

  ItemGenerator({this.items}) {
    _startTime = DateTime.now().millisecond;
    _rand = Random(_startTime);
  }

  void setItems(List<Item> items) {
    this.items = items;
  }

  //Generates a random element from items when appropriate.
  // Assumes that items is non-null and non-empty.
  Item getNewItem() {
    //Calculates the time since we last entered this method, add it to time since last item was produced
    _timeSinceLast += (DateTime.now().millisecond - _startTime);

    //If the elapsed time is over the threshold, we should produce an item
    if (_timeSinceLast >= _productionInterval) {
      _timeSinceLast = 0;
    }
  }
}
