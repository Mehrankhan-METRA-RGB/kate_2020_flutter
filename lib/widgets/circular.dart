
import 'package:flutter/material.dart';
class Circular extends StatefulWidget {
  Circular({this.isloading=false});
  final bool isloading;
  @override
  _CircularState createState() => _CircularState();
}

class _CircularState extends State<Circular> {
  @override
  Widget build(BuildContext context) {
    return widget.isloading?const CircularProgressIndicator():Container();
  }
}
