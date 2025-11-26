import 'dart:convert';

GetJobRes getJobResFromJson(String str) => GetJobRes.fromJson(json.decode(str));

String getJobResToJson(GetJobRes data) => json.encode(data.toJson());

class GetJobRes {
  GetJobRes({
    required this.id,
    required this.title,
    required this.location,
    required this.company,
    required this.hiring,
    required this.description,
    required this.salary,
    required this.period,
    required this.contract,
    required this.requirements,
    required this.imageUrl,
    required this.agentId,
    // required this.updatedAt,
  });

  final String id;
  final String title;
  final String location;
  final String company;
  final bool hiring;
  final String description;
  final String salary;
  final String period;
  final String contract;
  final List<String> requirements;
  final String imageUrl;
  final String agentId;
  // final DateTime updatedAt;

  factory GetJobRes.fromJson(Map<String, dynamic> json) {
    // 👇 Nếu response dạng { status, message, job: { ... } }
    // thì bóc ra json["job"], còn nếu trả thẳng object job thì dùng json luôn
    final Map<String, dynamic> data =
        json.containsKey('job') && json['job'] is Map<String, dynamic>
        ? json['job'] as Map<String, dynamic>
        : json;

    return GetJobRes(
      id: data["_id"]?.toString() ?? "",
      title: data["title"]?.toString() ?? "",
      location: data["location"]?.toString() ?? "",
      company: data["company"]?.toString() ?? "",
      hiring: data["hiring"] is bool ? data["hiring"] as bool : false,
      description: data["description"]?.toString() ?? "",
      salary: data["salary"]?.toString() ?? "",
      period: data["period"]?.toString() ?? "",
      contract: data["contract"]?.toString() ?? "",
      requirements: data["requirements"] != null
          ? List<String>.from(
              (data["requirements"] as List).map((x) => x.toString()),
            )
          : <String>[],
      imageUrl: data["imageUrl"]?.toString() ?? "",
      agentId: data["agentId"]?.toString() ?? "",
      // updatedAt: DateTime.parse(data["updatedAt"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "location": location,
    "company": company,
    "hiring": hiring,
    "description": description,
    "salary": salary,
    "period": period,
    "contract": contract,
    "requirements": List<dynamic>.from(requirements.map((x) => x)),
    "imageUrl": imageUrl,
    "agentId": agentId,
    // "updatedAt": updatedAt.toIso8601String(),
  };
}
