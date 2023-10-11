import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  final Widget child;
  LandingPage({Key? key, required this.child}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _LandingPageState();
  }
}

class _LandingPageState extends State<LandingPage> {
  ScrollController? _controller;

  @override
  void initState() {
    //Initialize the  scrollController
    _controller = ScrollController();
    super.initState();
  }

  final ScrollController _controllerOne = ScrollController();

  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        child: Scrollbar(
          thickness: 10,
          thumbVisibility: true,
          controller: _controllerOne,
          child: SingleChildScrollView(
              controller: _controllerOne,
              scrollDirection: Axis.vertical,
              child: widget.child),
        ));
  }
}
