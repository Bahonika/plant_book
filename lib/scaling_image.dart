import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ScalingImage extends StatefulWidget {
  final String image;

  @override
  _ScalingImageState createState() => _ScalingImageState();

  ScalingImage(this.image);
}

class _ScalingImageState extends State<ScalingImage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: PhotoView(
        imageProvider: AssetImage(
          widget.image,
        ),
      ),
    );
  }
}
