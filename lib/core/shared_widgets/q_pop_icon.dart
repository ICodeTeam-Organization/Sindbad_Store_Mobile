import 'package:flutter/material.dart';

class PopIcon extends StatefulWidget {
  const PopIcon({super.key});

  @override
  State<PopIcon> createState() => _PopIconState();
}

class _PopIconState extends State<PopIcon> {
  @override
  Widget build(BuildContext context) {
    return IconButton( onPressed: () {
            Navigator.of(context).pop();
          }, icon: const Icon(Icons.arrow_back,size: 30,color: Colors.black,),);
  }
}