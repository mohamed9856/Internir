class JobModel {
  String id;
  String title;
  String description;
  String location;
  DateTime createdAt;
  int numberOfApplicants;
  bool enabled;
  String company;
  double? salary;
  String? category;
  String? jobType;
  DateTime? deadline;

  JobModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    this.salary,
    this.category,
    this.jobType,
    this.deadline,
    required this.company,
    required this.createdAt,
    required this.numberOfApplicants,
    required this.enabled,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      location: json['location'],
      salary: json['salary'],
      category: json['category'],
      jobType: json['jobType'],
      deadline: DateTime.parse(json['deadline']),
      company: json['company'],
      createdAt: DateTime.parse(json['createdAt']),
      numberOfApplicants: json['numberOfApplicants'],
      enabled: json['enabled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'location': location,
      'salary': salary,
      'category': category,
      'jobType': jobType,
      'deadline': deadline.toString(),
      'company': company,
      'createdAt': createdAt.toString(),
      'numberOfApplicants': numberOfApplicants,
      'enabled': enabled,
    };
  }

  @override
  String toString() {
    return 'JobModel{id: $id, title: $title, description: $description, location: $location, salary: $salary, category: $category, jobType: $jobType, deadline: $deadline, company: $company, createdAt: $createdAt, numberOfApplicants: $numberOfApplicants, enabled: $enabled}';
  }
}
