import 'package:flutter/material.dart';

class AddAnImage extends StatelessWidget {
  const AddAnImage({
    super.key, required this.text, required this.onPressed,
  });
final String text;
final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      color: Colors.blue,
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(text,
        style:const TextStyle(
          color: Colors.white,
          fontSize: 23
        ),),
        ),
        
      
    
    );
  }
}