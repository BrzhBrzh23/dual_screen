import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RIKeys {
  static final riKey1 = const Key('__RIKEY1__');
  static final riKey2 = const Key('__RIKEY2__');
  static final riKey3 = const Key('__RIKEY3__');
}

class Constants {
  final Color buttonColor = const Color.fromRGBO(0, 255, 102, 1);
  final Color onBoardColor = const Color.fromRGBO(105, 33, 198, 1);
  final Color blackMenuColor = const Color.fromRGBO(37, 37, 37, 1);
  final Color blackMenuColorTransp = const Color.fromRGBO(37, 37, 37, 0.4);

  final TextStyle regularWhiteText =
      const TextStyle(color: Colors.white, fontSize: 18);
  final TextStyle regularWhiteTextFourteen =
      const TextStyle(color: Colors.white, fontSize: 14);
  final TextStyle regularWhiteTextTwelve =
      const TextStyle(color: Colors.white, fontSize: 12);

  final TextStyle regularWhiteTextTen =
      const TextStyle(color: Colors.white, fontSize: 10);

  final TextStyle regularGreyText =
      const TextStyle(color: Color.fromRGBO(235, 235, 245, 0.6), fontSize: 18);

  final TextStyle regularGreyTextTen =
      const TextStyle(color: Color.fromRGBO(235, 235, 245, 0.6), fontSize: 10);

  final TextStyle regularBlackTextTen =
      const TextStyle(color: Color.fromARGB(177, 20, 18, 18), fontSize: 10);

  final TextStyle regularBlackText =
      const TextStyle(color: Color.fromARGB(177, 20, 18, 18));

  final TextStyle boldWhiteText = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 28,
  );

  final TextStyle boldBlackText =
      const TextStyle(color: Colors.black, fontWeight: FontWeight.bold);

  final TextStyle boldBlackTextTwentySix = const TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 26);

  final Color greyColor = const Color.fromRGBO(163, 163, 167, 0.24);
  final Color greyColorTwo = const Color.fromRGBO(163, 163, 167, 1);

  final Color lightGreyColor = const Color.fromRGBO(235, 235, 245, 0.6);
}

getIcon(String name, Color color) {
  switch (name) {
    case 'google':
      {
        return FaIcon(
          FontAwesomeIcons.google,
          color: color,
        );
      }
    case 'amazon':
      {
        return FaIcon(FontAwesomeIcons.amazon, color: color);
      }
    case 'instagram':
      {
        return FaIcon(FontAwesomeIcons.instagram, color: color);
      }
    case 'youtube':
      {
        return FaIcon(FontAwesomeIcons.youtube, color: color);
      }
    case 'facebook':
      {
        return FaIcon(FontAwesomeIcons.facebook, color: color);
      }
    default:
      {
        return FaIcon(FontAwesomeIcons.globe, color: color);
      }
  }
}

capitalizeStringS(String s) => s[0].toUpperCase() + s.substring(1);

filterUrl(String url) {
  if (url.contains('https://www.')) {
    return url;
  } else if (url.contains('https://m.')) {
    return url;
  } else if (url.startsWith('www.')) {
    return 'https://$url';
  } else {
    return 'https://www.$url';
  }
}

filterGoogleQuery(String query) {
  if (query.contains('https://www.')) {
    return query.substring(12);
  } else if (query.contains('https://m.')) {
    return query.substring(10);
  } else if (query.startsWith('www.')) {
    return query.substring(4);
  } else {
    return query;
  }
}

getDomaintFromUrl(String url) {
  if (url.contains('https://m.')) {
    return (url.substring(10, url.lastIndexOf('.'))).toUpperCase();
  }
  if (url.contains('google.com/search?q=')) {
    return 'GOOGLE';
  }
  if (url.contains('https://www.')) {
    if (url.contains('.com') ||
        url.contains('.us') ||
        url.contains('.ru') ||
        url.contains('.kz') ||
        url.contains('.net')) {
      return (url.substring(12, url.lastIndexOf('.'))).toUpperCase();
    } else {
      return "no url: '${url.substring(12, url.lastIndexOf('/'))}'";
    }
  } else {
    return (url.substring(8, url.lastIndexOf('.')));
  }
}

getMinutes(int i) {
  if (i < 10) {
    return '0$i';
  } else {
    return '$i';
  }
}

getMonth(int month) {
  switch (month) {
    case 1:
      return 'Jan';
    case 2:
      return 'Feb';
    case 3:
      return 'Mar';
    case 4:
      return 'Apr';
    case 5:
      return 'May';
    case 6:
      return 'Jun';
    case 7:
      return 'Jul';
    case 8:
      return 'Aug';
    case 9:
      return 'Sep';
    case 10:
      return 'Oct';
    case 11:
      return 'Nov';
    case 12:
      return 'Dec';
  }
}
