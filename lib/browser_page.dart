// import 'dart:async';

// import 'package:dual_screen/constants.dart';
// import 'package:dual_screen/controller.dart';
// import 'package:dual_screen/search_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:anim_search_bar/anim_search_bar.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

// class WebViewApp extends StatefulWidget {
//   WebViewApp({super.key, required this.url});
//   String url;

//   @override
//   State<WebViewApp> createState() => _WebViewAppState();
// }

// class _WebViewAppState extends State<WebViewApp> {
//   final FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
//   late String selectedUrl = widget.url;
//   TextEditingController _urlCtrl = TextEditingController();

//   late StreamSubscription<String> _onUrlChanged;

//   final _history = [];

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     _urlCtrl = TextEditingController(text: selectedUrl);

//     _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
//       if (mounted) {
//         setState(() {
//           // _history.add('onUrlChanged: $url');
//           print(url);
//           selectedUrl = url;
//           _urlCtrl.text = url;
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     flutterWebviewPlugin.dispose();
//   }

//   var currentText;
//   var isIconVisible;
//   String? currentUrl;

//   @override
//   Widget build(BuildContext context) {
//     return  WebviewScaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           toolbarHeight: 40,
//           backgroundColor: Constants().blackMenuColor,
//           elevation: 0,
//           actions: [
//             Stack(
//               children: [
//                 SearchWidget(
//                   screenWidth: MediaQuery.of(context).size.width,
//                   url: selectedUrl,
//                   txtFieldController: _urlCtrl,
//                   flutterWebviewPlugin: flutterWebviewPlugin,
//                 ),
//               ],
//             ),
//           ],
//         ),
//         url: filterUrl(widget.url),
//       );
//   }
// }
