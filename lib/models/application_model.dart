class ApplicationModel {
  /*

          'email': email,
          'phone': phone,
          'jobId': widget.job.id,
          'jobTitle': widget.job.title,
          'appliedAt': FieldValue.serverTimestamp(),
          'status': 'pending',
          'userId': FirebaseAuth.instance.currentUser!.uid,
          'username': _username,
          'category': _category,
            */

  String username;
  String email;
  String phone;
  DateTime appliedAt;
  String status;
  String jobId;
  String jobTitle;
  String userId;
  String category;

  ApplicationModel({
    required this.email,
    required this.phone,
    required this.jobId,
    required this.jobTitle,
    required this.appliedAt,
    required this.status,
    required this.userId,
    required this.username,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'phone': phone,
        'jobId': jobId,
        'jobTitle': jobTitle,
        'appliedAt': appliedAt,
        'status': status,
        'userId': userId,
        'username': username,
        'category': category,
      };

  factory ApplicationModel.fromJson(Map<String, dynamic> json) =>
      ApplicationModel(
        email: json['email'],
        phone: json['phone'],
        jobId: json['jobId'],
        jobTitle: json['jobTitle'],
        appliedAt: json['appliedAt'].toDate().toLocal(),
        status: json['status'],
        userId: json['userId'],
        username: json['username'],
        category: json['category'],
      );

  @override
  String toString() {
    return 'ApplicationModel(email: $email, phone: $phone, jobId: $jobId, jobTitle: $jobTitle, appliedAt: $appliedAt, status: $status, userId: $userId, username: $username, category: $category)';
  }
}
