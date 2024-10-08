import 'package:hive/hive.dart';

part 'adzuna_model.g.dart';

@HiveType(typeId: 0)
class AdzunaModel extends HiveObject {
  @HiveField(0)
  double mean;

  @HiveField(1)
  List<Results> results;

  @HiveField(2)
  int count;

  AdzunaModel({
    required this.mean,
    required this.results,
    required this.count,
  });

  factory AdzunaModel.fromJson(Map<String, dynamic> json) {
    return AdzunaModel(
      mean: json['mean'],
      results:
          List<Results>.from(json['results'].map((x) => Results.fromJson(x))),
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'mean': mean,
      'results': List<dynamic>.from(results.map((x) => x.toJson())),
      'count': count,
    };
  }
}

@HiveType(typeId: 1)
class Results extends HiveObject {
  @HiveField(0)
  Category category;

  @HiveField(1)
  String id;

  @HiveField(2)
  Location location;

  @HiveField(3)
  double? longitude;

  @HiveField(4)
  Company company;

  @HiveField(5)
  String redirectUrl;

  @HiveField(6)
  double? latitude;

  @HiveField(7)
  double salaryMin;

  @HiveField(8)
  String description;

  @HiveField(9)
  String adref;

  @HiveField(10)
  double salaryMax;

  @HiveField(11)
  String title;

  @HiveField(12)
  String created;

  @HiveField(13)
  String salaryIsPredicted;

  @HiveField(14)
  String? contractTime;

  @HiveField(15)
  String? contractType;

  Results({
    required this.category,
    required this.id,
    required this.location,
    this.longitude,
    required this.company,
    required this.redirectUrl,
    this.latitude,
    required this.salaryMin,
    required this.description,
    required this.adref,
    required this.salaryMax,
    required this.title,
    required this.created,
    required this.salaryIsPredicted,
    this.contractTime,
    this.contractType,
  });

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      category: Category.fromJson(json['category']),
      id: json['id'],
      location: Location.fromJson(json['location']),
      longitude: json['longitude']?.toDouble(),
      company: Company.fromJson(json['company']),
      redirectUrl: json['redirect_url'],
      latitude: json['latitude']?.toDouble(),
      salaryMin: json['salary_min'].toDouble(),
      description: json['description'],
      adref: json['adref'],
      salaryMax: json['salary_max'].toDouble(),
      title: json['title'],
      created: json['created'],
      salaryIsPredicted: json['salary_is_predicted'],
      contractTime: json['contract_time'],
      contractType: json['contract_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'category': category.toJson(),
      'id': id,
      'location': location.toJson(),
      'longitude': longitude,
      'company': company.toJson(),
      'redirect_url': redirectUrl,
      'latitude': latitude,
      'salary_min': salaryMin,
      'description': description,
      'adref': adref,
      'salary_max': salaryMax,
      'title': title,
      'created': created,
      'salary_is_predicted': salaryIsPredicted,
      'contract_time': contractTime,
      'contract_type': contractType,
    };
  }
}

@HiveType(typeId: 2)
class Category extends HiveObject {
  @HiveField(0)
  String tag;

  @HiveField(1)
  String label;

  Category({
    required this.tag,
    required this.label,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      tag: json['tag'],
      label: json['label'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'tag': tag,
      'label': label,
    };
  }
}

@HiveType(typeId: 3)
class Location extends HiveObject {
  @HiveField(0)
  List<String> area;

  @HiveField(1)
  String displayName;

  Location({
    required this.area,
    required this.displayName,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      area: List<String>.from(json['area'].map((x) => x)),
      displayName: json['display_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'area': List<dynamic>.from(area.map((x) => x)),
      'display_name': displayName,
    };
  }
}

@HiveType(typeId: 4)
class Company extends HiveObject {
  @HiveField(0)
  String displayName;

  Company({required this.displayName});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      displayName: json['display_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'display_name': displayName,
    };
  }
}
