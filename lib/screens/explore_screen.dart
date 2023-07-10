import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tinder_clone/data/datas.dart';
import 'package:tinder_clone/flutter_tindercard/flutter_tindercard.dart';

import 'package:tinder_clone/theme/colors.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with TickerProviderStateMixin {
  late CardController controller;

  List itemsTemp = [];
  int itemLength = 0;
  @override
  void initState() {
    super.initState();
    setState(() {
      itemsTemp = explore_data;
      itemLength = explore_data.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: getBody(),
      bottomSheet: getBottomSheet(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(bottom: 120),
      child: SizedBox(
        height: size.height,
        child: TinderSwapCard(
          totalNum: itemLength,
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height * 0.75,
          minWidth: MediaQuery.of(context).size.width * 0.75,
          minHeight: MediaQuery.of(context).size.height * 0.6,
          cardBuilder: (context, index) => Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: grey.withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 2),
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  Container(
                    width: size.width,
                    height: size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(itemsTemp[index]['img']),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: size.height,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          black.withOpacity(0.25),
                          black.withOpacity(0),
                        ],
                            end: Alignment.topCenter,
                            begin: Alignment.bottomCenter)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.72 - 18,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          itemsTemp[index]['name'],
                                          style: const TextStyle(
                                              color: white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          itemsTemp[index]['age'],
                                          style: const TextStyle(
                                            color: white,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: const BoxDecoration(
                                              color: green,
                                              shape: BoxShape.circle),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          "Recently Active",
                                          style: TextStyle(
                                            color: white,
                                            fontSize: 16,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: List.generate(
                                          itemsTemp[index]['likes'].length,
                                          (indexLikes) {
                                        if (indexLikes == 0) {
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(right: 8),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: white, width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color:
                                                      white.withOpacity(0.4)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 3,
                                                    bottom: 3,
                                                    left: 10,
                                                    right: 10),
                                                child: Text(
                                                  itemsTemp[index]['likes']
                                                      [indexLikes],
                                                  style: const TextStyle(
                                                      color: white),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: white.withOpacity(0.2)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 3,
                                                  bottom: 3,
                                                  left: 10,
                                                  right: 10),
                                              child: Text(
                                                itemsTemp[index]['likes']
                                                    [indexLikes],
                                                style: const TextStyle(
                                                    color: white),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: size.width * 0.2,
                                  child: const Center(
                                    child: Icon(
                                      Icons.info,
                                      color: white,
                                      size: 28,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          cardController: controller = CardController(),
          swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
            if (align.x < 0) {
            } else if (align.x > 0) {}
          },
          swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
            if (index == (itemsTemp.length - 1)) {
              setState(() {
                itemLength = itemsTemp.length - 1;
              });
            }
          },
        ),
      ),
    );
  }

  Widget getBottomSheet() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 120,
      decoration: const BoxDecoration(color: white),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(item_icons.length, (index) {
            return Container(
              width: item_icons[index]['size'],
              height: item_icons[index]['size'],
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 10,
                    ),
                  ]),
              child: Center(
                child: SvgPicture.asset(
                  item_icons[index]['icon'],
                  width: item_icons[index]['icon_size'],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
