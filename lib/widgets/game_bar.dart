import 'package:fallingthings/constants.dart';
import 'package:fallingthings/data_models/game_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameBar extends StatefulWidget {
  @override
  _GameBarState createState() => _GameBarState();
}

class _GameBarState extends State<GameBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      height: 60,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Score ' + Provider.of<GameData>(context).score.toString(),
            style: kLargeTextStyle,
          ),
          SizedBox(
            width: 30,
          ),
          Text(
            'Streak: ' + Provider.of<GameData>(context).streak.toString(),
            style: kLargeTextStyle,
          ),
        ],
      ),
    );
  }
}
