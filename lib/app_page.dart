import 'package:dual_screen/browser.dart';
import 'package:dual_screen/browser_page.dart';
import 'package:dual_screen/constants.dart';
import 'package:dual_screen/controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  FavController favController = Get.put(FavController());
  var currentText;
  bool isIconVisible = true;
  bool autoPlay = false;

  void initState() {
    super.initState();
   setState(() {
     favController.getFav();
   });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () => setState(() {
            autoPlay = false;
          }),
          child: Scaffold(
            backgroundColor: Constants().blackMenuColor,
            appBar: AppBar(
                elevation: 0,
                backgroundColor: Constants().blackMenuColor,
                title: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        color: Constants().greyColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(bottom: 0),
                          prefixIconConstraints: BoxConstraints(maxHeight: 18),
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          prefixIcon: isIconVisible == true
                              ? Icon(
                                  Icons.search,
                                  size: 18,
                                  color: Constants().lightGreyColor,
                                )
                              : null,
                          hintText: 'Search...',
                          hintStyle: Constants().regularGreyText),
                      style: Constants().regularWhiteText,
                      onChanged: (value) {
                        currentText = value;
                        if (value.isNotEmpty) {
                          setState(() {
                            isIconVisible = false;
                          });
                        } else {
                          setState(() {
                            isIconVisible = true;
                          });
                        }
                      },
                      onSubmitted: (value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => myapp(url: value)));
                        print(value);
                      },
                    ))),
            body: Obx(() => GridView.count(
                crossAxisCount: 4,
                children: List.generate(
                  favController.list.length,
                  (index) => Padding(
                      padding: EdgeInsets.only(left: 12.0, top: 10),
                      child: Stack(
                        children: [
                          ShakeWidget(
                            shakeConstant: ShakeLittleConstant2(),
                            autoPlay: autoPlay,
                            child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor: (favController.list[index] ==
                                          'Show all favorites')
                                      ? MaterialStateProperty.all(
                                          Constants().greyColor)
                                      : MaterialStateProperty.all(
                                          Colors.transparent)),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => myapp(
                                        url:
                                            'https://www.${favController.list[index]}.com')));
                              },
                              onLongPress: () => setState(() {
                                autoPlay = true;
                              }),
                              child: (favController.list[index] ==
                                      'Show all favorites')
                                  ? Text(
                                      favController.list[index],
                                      style: Constants().regularWhiteTextTwelve,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    )
                                  : Column(
                                      children: [
                                        Expanded(
                                            child: ShakeWidget(
                                          autoPlay: autoPlay,
                                          shakeConstant: ShakeLittleConstant2(),
                                          child: getIcon(
                                              favController.list[index]
                                                  .toLowerCase(),
                                              Constants().onBoardColor),
                                        )),
                                        SizedBox(
                                          height: 13,
                                        ),
                                        Expanded(
                                          child: Text(
                                            capitalizeStringS(
                                                favController.list[index]),
                                            style: Constants()
                                                .regularWhiteTextTwelve,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                          (autoPlay == true)
                              ? Positioned(
                                  left: 28,
                                  top: -17,
                                  child: ShakeWidget(
                                    
                                    autoPlay: true,
                                    shakeConstant: ShakeLittleConstant1(),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        size: 15,
                                        color: Constants().lightGreyColor,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          favController.removeFav(
                                              favController.list[index]);
                                        });
                                      },
                                    ),
                                  ))
                              : Container()
                        ],
                      )),
                )),
          ),
        ));
      },
    );
  }
}
