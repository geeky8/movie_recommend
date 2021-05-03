import 'package:flutter/material.dart';

class CardFront extends StatefulWidget {
  @override
  _CardFrontState createState() => _CardFrontState();
}

class _CardFrontState extends State<CardFront> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.grey[400],
      ),
      child: Center(child: Image.asset("assets/img/netflix_logo.png")),
    );
  }
}
