import 'package:flutter/material.dart';

class ScalingImage extends StatefulWidget {
  final String imageUrl;

  @override
  _ScalingImageState createState() => _ScalingImageState();

  const ScalingImage(this.imageUrl, {Key? key}) : super(key: key);
}

TransformationController transformationController = TransformationController();

class _ScalingImageState extends State<ScalingImage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: InteractiveViewer(
            panEnabled: false, // Set it to false
            constrained: true,
            scaleEnabled: true,
            onInteractionEnd: (details) {
              print("here");
              setState(() {

                transformationController.toScene(Offset.zero);
              });
            },
            transformationController: transformationController,
            boundaryMargin: EdgeInsets.all(100),
            minScale: 1,
            maxScale: 4,
            child: Image.network(widget.imageUrl),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () => Navigator.pop(context),
          ),
        )
      ]),
    );
  }
}
