class BudgetEntity {
  int id;
  DateTime createTime;
  String name;
  String price;

  BudgetEntity({
    required this.id,
    required this.createTime,
    required this.name,
    required this.price,
  });

  factory BudgetEntity.fromJson(Map<String, dynamic> json) {
    return BudgetEntity(
      id: json['id'],
      createTime: DateTime.parse(json['createTime']),
      name: json['name'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createTime': createTime.toIso8601String(),
      'name': name,
      'price': price,
    };
  }
}
