import 'dart:convert';

class Site {
  final String url;
  final DateTime date;

  Site({
    required this.url,
    required this.date,
    
  });

  factory Site.fromJson(Map<String, dynamic> jsonData) {
    return Site(
      url: jsonData['url'],
      date: DateTime.parse(jsonData['date']),
    
    );
  }

  static Map<String, dynamic> toMap(Site site) => {
        'url': site.url,
        'date': site.date.toIso8601String(),
      };

  static String encode(List<Site> sites) => json.encode(
        sites
            .map<Map<String, dynamic>>((site) => Site.toMap(site))
            .toList(),
      );

  static List<Site> decode(String sites) =>
      (json.decode(sites) as List<dynamic>)
          .map<Site>((item) => Site.fromJson(item))
          .toList();
}