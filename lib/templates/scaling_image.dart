import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ScalingImage extends StatefulWidget {
  final String image;

  @override
  _ScalingImageState createState() => _ScalingImageState();

  const ScalingImage(this.image, {Key? key}) : super(key: key);
}

class _ScalingImageState extends State<ScalingImage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
