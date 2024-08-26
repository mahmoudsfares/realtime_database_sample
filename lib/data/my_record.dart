class MyRecord {
  final String name;
  final int age;

  MyRecord({required this.name, required this.age});

  static MyRecord fromJson(Map<dynamic, dynamic> json) {
    return MyRecord(name: json['name'] as String, age: json['age'] as int);
  }
}