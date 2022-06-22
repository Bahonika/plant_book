import 'package:flutter/material.dart';
import 'package:polar_sun/data/entities/plant.dart';
import 'package:polar_sun/data/entities/user.dart';
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
    imageList = widget.plant.photoUrls;
  }

  Widget imageView(String image) {
    return InkWell(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => ScalingImage(image))),
      child: Card(
        // color: Theme.of(context).backgroundColor,
        elevation: 20,

        child: Image.network(
          image,

          fit: BoxFit.cover,
          // height: MediaQuery.of(context).size.height * 0.7,
        ),
      ),
    );
  }

  Widget indicators(imagesLength, currentPage) {
    return Row(
      children: List<Widget>.generate(imagesLength, (index) {
        return Container(
          margin: const EdgeInsets.all(3),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
              color: currentPage == index
                  ? Theme.of(context).colorScheme.primary
                  : Colors.black26,
              shape: BoxShape.circle),
        );
      }),
    );
  }

  int currentPage = 0;
  PageController pageController = PageController(initialPage: 0);

  void setPage(int page) {
    setState(() {
      pageController.animateToPage(page,
          duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
    });

  }

  Widget imageCarousel(List<String> imagesList) {
    return SizedBox(
      height: getDeviceType(MediaQuery.of(context)) == DeviceScreenType.mobile
          ? MediaQuery.of(context).size.height * 0.7
          : MediaQuery.of(context).size.height * 0.7,
      width: getDeviceType(MediaQuery.of(context)) == DeviceScreenType.mobile
          ? MediaQuery.of(context).size.width
          : MediaQuery.of(context).size.width * 0.2447,
      child: Stack(
        children: [
          SizedBox(
            height:
                getDeviceType(MediaQuery.of(context)) == DeviceScreenType.mobile
                    ? MediaQuery.of(context).size.height * 0.7
                    : MediaQuery.of(context).size.height * 0.7,
            width:
                getDeviceType(MediaQuery.of(context)) == DeviceScreenType.mobile
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width * 0.2447,
            child: PageView.builder(
                itemCount: imageList.length,
                scrollDirection: Axis.horizontal,
                controller: pageController,
                onPageChanged: (page) {
                  setState(() {
                    currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return imageView(imagesList[index]);
                }),
          ),
          Visibility(
            visible: imageList.length != 1,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                onPressed: () => setPage(currentPage - 1),
                icon: const Icon(Icons.arrow_back_rounded),
                iconSize: 40,
              ),
            ),
          ),
          Visibility(
            visible: imageList.length != 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: () => setPage(currentPage + 1),
                icon: const Icon(Icons.arrow_forward_rounded),
                iconSize: 40,
              ),
            ),
          ),
          Visibility(
              visible: getDeviceType(MediaQuery.of(context)) ==
                      DeviceScreenType.mobile &&
                  imageList.length != 1,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.bottomCenter,
                  child: indicators(imagesList.length, currentPage)))
        ],
      ),
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
                    Column(
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2447,
                            child: imageCarousel(widget.plant.photoUrls)),
                        Visibility(
                            visible: imageList.length != 1,
                            child: indicators(imageList.length, currentPage)),
                      ],
                    ),
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
              backgroundColor: Theme.of(context).backgroundColor,
              expandedHeight: 3870 / (2701 / MediaQuery.of(context).size.width),
              // expandedHeight:  MediaQuery.of(context).size.width * 0.7,
              flexibleSpace: FlexibleSpaceBar(
                  background: imageCarousel(widget.plant.photoUrls)),
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
