import 'package:fallingthings/constants.dart';
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
            'Score ' + 0.toString(),
            style: kLargeTextStyle,
          ),
          SizedBox(
            width: 30,
          ),
          Text(
            'Streak: ' + 0.toString(),
            style: kLargeTextStyle,
          ),
        ],
      ),
    );
  }
}
