import 'package:flutter/material.dart';
import 'package:polar_sun/data/entities/plant.dart';
import 'package:polar_sun/data/entities/user.dart';
import 'package:polar_sun/data/repositories/abstract/api.dart';
import 'package:polar_sun/views/scaling_image.dart';

import '../utils/device_screen_type.dart';
import 'comments.dart';

class PlantView extends StatefulWidget {
  final Plant plant;
  final AuthorizedUser user;

  const PlantView({Key? key, required this.plant, required this.user})
      : super(key: key);

  @override
  State<PlantView> createState() => _PlantViewState();
}

class _PlantViewState extends State<PlantView> {
  String commentsAlias = "Комментарии";

  List<DataRow> rows = [];
  List<String> imageList = [];

  DataTable getTable() {
    return DataTable(columns: [
      DataColumn(
          label: ConstrainedBox(
              child: Text(
                "Данные",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.shortestSide * 0.03,
                  fontWeight: FontWeight.bold,
                ),
              ),
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width / 6,
              ))),
      DataColumn(
          label: ConstrainedBox(
              child: Text(
                "Значение",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.shortestSide * 0.03,
                  fontWeight: FontWeight.bold,
                ),
              ),
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width / 6,
              ))),
    ], rows: rows);
  }

  void rowsFill() {
    widget.plant.getFields().forEach((key, value) {
      rows.add(DataRow(cells: [
        DataCell(Text(
          key,
          style: const TextStyle(
            fontSize: 15,
            fontStyle: FontStyle.italic,
          ),
        )),
        DataCell(Text(
          value,
          style: const TextStyle(fontSize: 15),
        )),
      ]));
    });
  }

  void imageListFill() {
    for (String photo in widget.plant.photoUrls) {
      imageList.add("https://" + Api.siteRoot + Api.apiRoot + photo);
    }
  }

  Widget imageView(String image) {
    return InkWell(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => ScalingImage(image))),
      child: Container(
        //TODO Тень починить
        // decoration: const BoxDecoration(boxShadow: [
        //   BoxShadow(
        //     color: Color.fromRGBO(14, 53, 23, 0.35),
        //     blurRadius: 22.0,
        //     offset: Offset(-8, -6),
        //   ),
        // ]),
        child: Image.network(
          image,
          // height: MediaQuery.of(context).size.height * 0.7,
        ),
      ),
    );
  }

  Widget imageCarousel(List<String> imagesList) {
    return Container(
      //TODO сделать кнопки вправо и влево
      height: MediaQuery.of(context).size.height * 0.7,
      child: PageView.builder(
          itemCount: imageList.length,
          scrollDirection: Axis.horizontal,
          controller: PageController(initialPage: 0),
          itemBuilder: (context, index) {
            return imageView(imagesList[index]);
          }),
    );
  }

  @override
  void initState() {
    rowsFill();
    imageListFill();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget desktopPlant(Plant plant) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.plant.name,
            style: const TextStyle(color: Colors.white70),
          ),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: imageCarousel(widget.plant.photoUrls)),
                    Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromRGBO(245, 252, 243, 0.55),
                        ),
                        child: getTable()),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Comments(
                              plant: widget.plant, user: widget.user))),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      commentsAlias,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                )
              ]),
        ),
      );
    }

    Widget mobilePlant(Plant plant) {
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 3870 / (2701 / MediaQuery.of(context).size.width),
              // flexibleSpace: FlexibleSpaceBar(
              //   background: InkWell(
              //       onTap: () => Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) =>
              //                   ScalingImage(widget.plant.photoUrls))),
              //       child: FittedBox(
              //           fit: BoxFit.fill,
              //           child: Image.network(widget.plant.photoUrls))),
              // ),
            ),
            SliverToBoxAdapter(child: getTable()),
            SliverToBoxAdapter(
                child: ElevatedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Comments(plant: widget.plant, user: widget.user))),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  commentsAlias,
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
            )),
          ],
        ),
      );
    }

    // return Scaffold(body: commentsView());
    return getDeviceType(MediaQuery.of(context)) == DeviceScreenType.mobile
        ? mobilePlant(widget.plant)
        : desktopPlant(widget.plant);
  }
}
