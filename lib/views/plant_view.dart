import 'package:flutter/material.dart';
import 'package:polar_sun/data/entities/plant.dart';

import '../utils/device_screen_type.dart';

class PlantView extends StatefulWidget {
  final Plant plant;

  PlantView({Key? key, required this.plant}) : super(key: key);

  @override
  State<PlantView> createState() => _PlantViewState();
}

class _PlantViewState extends State<PlantView> {
  List<DataRow> rows = [];

  DataTable getTable() {
    return DataTable(columns: [
      DataColumn(
          label: ConstrainedBox(
              child: const Text(
                "Данные",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width / 6,
              ))),
      DataColumn(
          label: ConstrainedBox(
              child: const Text(
                "Значение",
                style: TextStyle(
                  fontSize: 24,
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
          style: TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.italic,
          ),
        )),
        DataCell(Text(
          value,
          style: TextStyle(fontSize: 18),
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
            style: TextStyle(color: Colors.white70),
          ),
        ),
        body: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
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
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(245, 252, 243, 0.55),
                  ),
                  child: getTable())
            ],
          ),
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
                    // onTap: () {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => ScalingImage(widget.plant.image)));
                    // },
                    child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.network(widget.plant.photo_url))),
              ),
            ),
            SliverToBoxAdapter(child: getTable()),
          ],
        ),
      );
    }

    return getDeviceType(MediaQuery.of(context)) == DeviceScreenType.mobile
        ? mobilePlant(widget.plant)
        : desktopPlant(widget.plant);
  }
}
