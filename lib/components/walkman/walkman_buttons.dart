import 'package:flutter/material.dart';
import 'package:walkman/states/walkman_state.dart';

class WalkmanButtons extends StatelessWidget{

  final WalkmanState state;

  const WalkmanButtons({required this.state,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            state.playPrev();
          }, 
          label: Text("PREV"),
          icon: Icon(Icons.skip_previous_rounded),
          style: getButtonStyle()
        ),
        
        SizedBox(width: 10,),

        ElevatedButton.icon(
          onPressed: () {
            state.playNext();
          }, 
          label: Text("NEXT"),
          icon: Icon(Icons.skip_next_rounded),
          style: getButtonStyle()
        ),
        
        SizedBox(width: 10,),

        ElevatedButton.icon(
          onPressed: () {
            state.resumeMusic();
          }, 
          label: Text("PLAY"),
          icon: Icon(Icons.play_arrow_rounded),
          style: getButtonStyle()
        ),

        SizedBox(width: 10,),

        ElevatedButton.icon(
          onPressed: () {
            state.pauseMusic();
          }, 
          label: Text("PAUSE"),
          icon: Icon(Icons.pause_rounded),
          style: getButtonStyle()
        ),

        SizedBox(width: 10,),

        ElevatedButton.icon(
          onPressed: () {
            state.stopMusic();
          }, 
          label: Text("STOP"),
          icon: Icon(Icons.stop_rounded),
          style: getButtonStyle()
        ),
      ],
    );
  }
  
}

ButtonStyle getButtonStyle(){
  return ButtonStyle(
    elevation: WidgetStateProperty.resolveWith((buttonState){
      if (buttonState.contains(WidgetState.pressed)){
        return 1;
      }
      else{
        return 4;
      }
    }),
    shape: WidgetStateProperty.all(
      const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero
      )
    ),
    padding: WidgetStateProperty.all(EdgeInsets.only(left: 3, right: 3)),
  );
}