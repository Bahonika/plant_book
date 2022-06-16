import 'package:flutter/material.dart';
import 'package:polar_sun/data/entities/plant.dart';
import 'package:polar_sun/data/entities/user.dart';
import 'package:polar_sun/views/scaling_image.dart';

import '../utils/device_screen_type.dart';
import 'comments.dart';

class PlantView extends StatefulWidget {
  final Plant plant;
  final AuthorizedUser user;

  PlantView({Key? key, required this.plant, required this.user})
      : super(key: key);

  @override
  State<PlantView> createState() => _PlantViewState();
}

class _PlantViewState extends State<PlantView> {
  List<DataRow> rows = [];

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

  rowsFill() {
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
          style: TextStyle(fontSize: 15),
        )),
      ]));
    });
  }

  @override
  void initState() {
    rowsFill();
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
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ScalingImage(widget.plant.photo_url))),
                      child: Container(
                        decoration: const BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(14, 53, 23, 0.35),
                            blurRadius: 22.0,
                            offset: Offset(-8, -6),
                          )
                        ]),
                        child: Image.network(
                          widget.plant.photo_url,
                          height: MediaQuery.of(context).size.height * 0.7,
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromRGBO(245, 252, 243, 0.55),
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
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Комментарии",
                      style: TextStyle(color: Colors.white70),
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
              flexibleSpace: FlexibleSpaceBar(
                background: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ScalingImage(widget.plant.photo_url))),
                    child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.network(widget.plant.photo_url))),
              ),
            ),
            SliverToBoxAdapter(child: getTable()),
            SliverToBoxAdapter(child: ElevatedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Comments(
                          plant: widget.plant, user: widget.user))),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Комментарии",
                  style: TextStyle(color: Colors.white70),
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
