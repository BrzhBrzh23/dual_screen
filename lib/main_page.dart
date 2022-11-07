import 'package:dual_screen/app_page.dart';
import 'package:dual_screen/constants.dart';
import 'package:flutter/material.dart';
import 'package:split_view/split_view.dart';
import 'package:multi_split_view/multi_split_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orient) {
      return Scaffold(
          body: SplitView(
        indicator: Container(
          foregroundDecoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/Slicer.png'),
                fit: BoxFit.fill),
          ),
        ),
        viewMode: (orient == Orientation.portrait)
            ? SplitViewMode.Vertical
            : SplitViewMode.Horizontal,
        children: [
          Navigator(
            onGenerateRoute: (routeSettings) {
              return MaterialPageRoute(
                builder: (context) => AppPage(),
              );
            },
          ),
          Navigator(
            onGenerateRoute: (routeSettings) {
              return MaterialPageRoute(
                builder: (context) => AppPage(),
              );
            },
          ),
        ],
      ));
    });
  }
}
