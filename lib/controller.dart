import 'package:dual_screen/site_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavController extends GetxController {
  var list = ['google', 'facebook', 'youtube', 'instagram', 'amazon'].obs;
  var history = <Site>[].obs;

  getFav() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    list.value = prefs.getStringList("list") as List<String>;

    update();
  }

  addFav(String fav) async {
    list.add(fav);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('list', list);
    update();
  }

  removeFav(String fav) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    list.value = prefs.getStringList('list') as List<String>;
    list.remove(fav);
    await prefs.setStringList('list', list);
    update();
  }

  getHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String siteString = await prefs.getString("history") as String;
    history.value = Site.decode(siteString);

    update();
  }

  addHistory(String url, DateTime date) async {
    history.add(Site(url: url, date: date));
    String encodedData = Site.encode(history);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("history", encodedData);
    update();

    print('Browser history: ${prefs.getString('history')}');
  }
}
