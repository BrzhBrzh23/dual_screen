import 'package:dual_screen/app_page.dart';
import 'package:dual_screen/constants.dart';
import 'package:flutter/material.dart';
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
      return Container(
        color: Constants().blackMenuColor,
        child: SafeArea(
          bottom: false,
          child: Scaffold(
              body: MultiSplitView(
            controller: (orient == Orientation.landscape)
                ? MultiSplitViewController(areas: [
                    Area(minimalWeight: 0.37),
                    Area(minimalWeight: 0.37)
                  ])
                : MultiSplitViewController(areas: [
                    Area(minimalWeight: 0.15),
                    Area(minimalWeight: 0.15)
                  ]),
            axis: (orient == Orientation.portrait)
                ? Axis.vertical
                : Axis.horizontal,
            dividerBuilder:
                (axis, index, resizable, dragging, highlighted, themeData) =>
                    Container(
              foregroundDecoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/Slicer.png'),
                    fit: BoxFit.fill),
              ),
            ),
          
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
          )),
        ),
      );
    });
  }
}
