import 'dart:async';
import 'dart:ui';

import 'package:dual_screen/app_page.dart';
import 'package:dual_screen/browser.dart';
import 'package:dual_screen/constants.dart';
import 'package:dual_screen/controller.dart';
import 'package:dual_screen/history_page.dart';
import 'package:dual_screen/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SearchWidget extends StatefulWidget {
  SearchWidget({
    super.key,
    required this.screenWidth,
    required this.url,
    required this.txtFieldController,
    required this.controller,
  });
  var screenWidth;
  var url;
  TextEditingController txtFieldController;
  WebViewController controller;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animController;
  bool isForward = false;
  late Tween<double> tween;

  FavController favController = FavController();

  @override
  void initState() {
    var width = widget.screenWidth;
    // TODO: implement initState
    super.initState();
    animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    final curvedAnimation =
        CurvedAnimation(parent: animController, curve: Curves.easeOutExpo);
    tween = Tween<double>(begin: 0, end: width - 70);
    animation = tween.animate(curvedAnimation)
      ..addListener(() {
        setState(() {
          tween.end = widget.screenWidth;
        });
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      width: widget.screenWidth,
      height: 60,
      child: Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 30,
                width: (animation.value > 1)
                    ? widget.screenWidth - 70
                    : animation.value,
                decoration: BoxDecoration(
                    color: Constants().greyColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomLeft: Radius.circular(50))),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: widget.txtFieldController,
                  cursorColor: Constants().greyColor,
                  style: Constants().regularWhiteTextTen,
                  decoration: InputDecoration(
                      suffixIcon: (animation.value > 1)
                          ? IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.close,
                                color: Constants().greyColor,
                              ),
                              onPressed: () {
                                widget.txtFieldController.clear();
                              },
                            )
                          : null,
                      isDense: true,
                      prefixIconConstraints:
                          const BoxConstraints(minWidth: 0, minHeight: 0),
                      border: InputBorder.none,
                      prefixIcon: animation.value > 1
                          ? IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Constants().lightGreyColor,
                                size: 15,
                              ),
                              onPressed: () {
                                animController.reverse();
                                isForward = false;
                              },
                            )
                          : null),
                  onFieldSubmitted: ((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                myapp(url: filterUrl(value))));
                    animController.reverse();
                  }),
                ),
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    color: animation.value > 1
                        ? Constants().greyColor
                        : Constants().greyColor,
                    borderRadius: animation.value > 1
                        ? const BorderRadius.only(
                            topRight: Radius.circular(50),
                            bottomRight: Radius.circular(50))
                        : BorderRadius.circular(50)),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: animation.value < 1
                      ? Icon(
                          Icons.search,
                          size: 15,
                          color: Constants().lightGreyColor,
                        )
                      : FaIcon(
                          FontAwesomeIcons.turnDown,
                          color: Constants().lightGreyColor,
                          size: 15,
                        ),
                  onPressed: (() {
                    if (!isForward) {
                      animController.forward();
                      isForward = true;
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => myapp(
                                  url: filterUrl(
                                      widget.txtFieldController.text))));
                      isForward = false;
                      animController.reverse();
                    }
                  }),
                ),
              ),
              (animation.value < 1)
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: IconButton(
                          onPressed: () async {
                            if (await widget.controller.canGoBack()) {
                              await widget.controller.goBack();
                            } else {
                              Navigator.pop(context);
                              return;
                            }
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            size: 15,
                          )),
                    )
                  : const SizedBox(
                      width: 1,
                    ),
              (animation.value < 1)
                  ? IconButton(
                      onPressed: () async {
                        if (await widget.controller.canGoForward()) {
                          await widget.controller.goForward();
                        }
                      },
                      icon: FutureBuilder(
                          future: widget.controller.canGoForward(),
                          builder: (context, snapshot) {
                            if (snapshot.data == false) {
                              return Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                                color: Constants().greyColor,
                              );
                            } else {
                              return const Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                                color: Colors.white,
                              );
                            }
                          }))
                  : const SizedBox(
                      width: 1,
                    )
            ],
          ),
          const Spacer(),
          (animation.value < 1)
              ? Row(children: [
                  IconButton(
                      onPressed: () {
                      },
                      icon: const Icon(
                        Icons.settings,
                        size: 15,
                      )),
                  IconButton(
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 15,
                    ),
                    onPressed: () {
                      showCupertinoModalPopup(
                          context: context, builder: buildActionSheet);
                    },
                  ),
                ])
              : const SizedBox(
                  width: 1,
                ),
        ],
      ),
    );
  }

  Widget buildActionSheet(BuildContext context) => CupertinoActionSheet(
        actions: [
          Container(
            color: Colors.white,
            child: CupertinoActionSheetAction(
                onPressed: () {
                  Get.find<FavController>().addFav(capitalizeStringS(
                      (getDomaintFromUrl(widget.txtFieldController.text))
                          .toLowerCase()));
                  Navigator.pop(context);
                },
                child: Text('Add to favorites', style: Constants().regularBlackText,)),
          ),
          Container(
            color: Colors.white,

            child: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.of(this.context)
                      .push(MaterialPageRoute(builder: ((context) => AppPage())));
                  Navigator.pop(context);
                },
                child: Text('Open favorites', style: Constants().regularBlackText)),
          ),
          Container(
            color: Colors.white,
            child: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.of(this.context).push(
                      MaterialPageRoute(builder: ((context) => HistoryPage())));
                  Navigator.pop(context);
                },
                child: Text('Open history', style: Constants().regularBlackText)),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          child: Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );
}
