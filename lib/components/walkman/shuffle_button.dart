import 'package:flutter/material.dart';
import 'package:walkman/states/walkman_state.dart';

class ShuffleButton extends StatelessWidget {
  final WalkmanState state;

  const ShuffleButton({required this.state, super.key });

  @override
  Widget build(BuildContext context){

    bool isShuffled = state.isShuffled;

    Color foreColor = isShuffled ? Colors.black : Colors.tealAccent;
    Color backColor = isShuffled ? Colors.tealAccent : Colors.black;

    return ElevatedButton.icon(
          onPressed: () {
            isShuffled ? state.shuffleOff() : state.shuffleOn();
          }, 
          label: Text("SHUFFLE"),
          icon: Icon(Icons.shuffle_sharp),
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(foreColor),
            backgroundColor: WidgetStateProperty.all(backColor),
            padding: WidgetStateProperty.all(EdgeInsets.only(left: 4, right: 6)),
          ),
        );
  }
}