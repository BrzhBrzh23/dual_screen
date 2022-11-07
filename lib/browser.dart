import 'dart:async';

import 'package:dual_screen/constants.dart';
import 'package:dual_screen/controller.dart';
import 'package:dual_screen/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io' show Platform;

class myapp extends StatefulWidget {
  myapp({required this.url});
  var url;
  @override
  _myappState createState() => _myappState();
}

class _myappState extends State<myapp> {
  final Completer<WebViewController> controller =
      Completer<WebViewController>();
  FavController favController = FavController();

  var currentUrl;
  TextEditingController _urlCtrl = TextEditingController();

  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      favController.getFav();
    });
    favController.getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 40,
          backgroundColor: Constants().blackMenuColor,
          elevation: 0,
          actions: [
            FutureBuilder<WebViewController>(
              future: controller.future,
              builder: (BuildContext context,
                  AsyncSnapshot<WebViewController> controller) {
                if (controller.hasData &&
                    controller.connectionState == ConnectionState.done &&
                    currentUrl != null) {
                  _urlCtrl.text = currentUrl.toString();
                  return Expanded(
                    child: OrientationBuilder(builder: (context, orientation) => SearchWidget(
                      screenWidth: constraints.maxWidth,
                      url: currentUrl,
                      txtFieldController: _urlCtrl,
                      controller: controller.data as WebViewController,
                    ))
                  );
                }

                return Center(child: Text('Loading...'));
              },
            ),
          ],
        ),
        body: WebView(
          initialUrl: filterUrl(widget.url),
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webcontroller) {
            controller.complete(webcontroller);
            currentUrl = webcontroller.currentUrl().toString();
          },
          onWebResourceError: (error) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              print(
                  'ADDED: https://www.google.com/search?q=${filterGoogleQuery(widget.url)}');
              return myapp(
                  url:
                      'https://www.google.com/search?q=${filterGoogleQuery(widget.url)}');
            }));
          },
          onPageStarted: (url) => setState(() {
            currentUrl = url.toString();
            Get.find<FavController>().addHistory(url, DateTime.now());
          }),
          onPageFinished: (url) => setState(() {
            currentUrl = url.toString();
          }),
        ),
      );
    });
  }
}
