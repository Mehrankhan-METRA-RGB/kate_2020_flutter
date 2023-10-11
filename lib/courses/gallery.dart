import 'package:flutter/material.dart';
import 'package:kate/constants/colors.dart';

// ignore: use_key_in_widget_constructors
class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  var _height, _width;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      builder: (context, snapshot) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 10),
          itemBuilder: (context, index) {
            return Card(
                elevation: 10,
                color: AppColors.card,
                child: Container(
                  height: 150,
                  margin: EdgeInsets.all(5),
                  width: 80,
                  color: Colors.blue,
                ));
          },
          itemCount: 20,
        );
      },
      future: Future.value(),
    );
  }
}
