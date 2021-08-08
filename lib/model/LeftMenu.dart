class LeftMenu {
  final String groupName;
  final List<Items> items;
  final dynamic upItems;

  LeftMenu(
      {required this.groupName, required this.items, required this.upItems});

  factory LeftMenu.fromJson(Map<String, dynamic> json) {
    return LeftMenu(
        groupName: json['groupName'],
        items: json['items'],
        upItems: json['upItems']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupName'] = this.groupName;
    data['items'] = this.items.map((v) => v.toJson()).toList();
    data['upItems'] = this.upItems;
    return data;
  }
}

class Items {
  final String name;
  final int id;
  final String type;

  Items({required this.name, required this.id, required this.type});

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      name: json['name'],
      id: json['id'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['type'] = this.type;
    return data;
  }
}
