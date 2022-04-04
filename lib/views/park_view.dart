import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../data/entities/park.dart';

class ParkView extends StatefulWidget {
  final Park park;

  ParkView({required this.park});

  @override
  _ParkViewState createState() => _ParkViewState();
}

class _ParkViewState extends State<ParkView> {
  List<Widget> imgItems = [];

  getImages(){
    widget.park.images.forEach((imgUrl) {
      imgItems.add(
        Image.asset(imgUrl)
      );
    });
  }

  @override
  void initState() {
    getImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.park.parkName,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          CarouselSlider(
              items: imgItems,
              options: CarouselOptions(
                height: 400,
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              )
          ),
          Text(
            widget.park.info
          )
        ],
      ),
    );
  }
}
