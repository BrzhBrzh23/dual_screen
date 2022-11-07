import 'package:dual_screen/browser.dart';
import 'package:dual_screen/constants.dart';
import 'package:dual_screen/controller.dart';
import 'package:dual_screen/site_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  FavController favController = Get.put(FavController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      favController.getHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavController>(
      builder: (controller) => Scaffold(
        backgroundColor: Constants().blackMenuColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 15,
            ),
          ),
          backgroundColor: Constants().blackMenuColor,
          elevation: 0,
          title: Text(
            'History',
            style: Constants().boldWhiteText,
          ),
          centerTitle: true,
        ),
        body: StickyGroupedListView<Site, DateTime>(
          elements: favController.history,
          order: StickyGroupedListOrder.ASC,
          groupBy: (Site element) => DateTime(
            element.date.year,
            element.date.month,
            element.date.day,
          ),
          groupComparator: (DateTime value1, DateTime value2) =>
              value2.compareTo(value1),
          itemComparator: (Site element1, Site element2) =>
              element2.date.compareTo(element1.date),
          floatingHeader: true,
          groupSeparatorBuilder: _getGroupSeparator,
          itemBuilder: _getItem,
        ),
      ),
    );
  }

  Widget _getGroupSeparator(Site element) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: 50,
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: 120,
            decoration: BoxDecoration(
              color: Constants().greyColorTwo,
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${getMonth(element.date.month)} ${element.date.day}, ${element.date.year}',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getItem(BuildContext ctx, Site element) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => myapp(url: element.url)));
      },
      child: Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        margin: ((getDomaintFromUrl(element.url)).contains('no url'))
            ? const EdgeInsets.symmetric(horizontal: 10.0)
            : const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: SizedBox(
          child: ((getDomaintFromUrl(element.url)).contains('no url'))
              ? Container()
              : ListTile(
                  leading: getIcon(getDomaintFromUrl(element.url).toLowerCase(),
                      Constants().onBoardColor),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  title: Text(
                    getDomaintFromUrl(element.url),
                    style: Constants().regularWhiteText,
                  ),
                  subtitle: Text(
                    element.url,
                    overflow: TextOverflow.ellipsis,
                    style: Constants().regularGreyTextTen,
                  ),
                  trailing: Text(
                    '${element.date.hour}:${getMinutes(element.date.minute)}',
                    style: Constants().regularGreyText,
                  ),
                ),
        ),
      ),
    );
  }
}
