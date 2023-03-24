// ignore_for_file: non_constant_identifier_names

class UserModel {
  String? uid;
  List<Items>? items;

  UserModel({this.uid, this.items});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  double? sugar_g;
  double? fiber_g;
  double? serving_size_g;
  int? sodium_mg;
  String? name;
  int? potassium_mg;
  double? fat_saturated_g;
  double? fat_total_g;
  double? calories;
  int? cholesterol_mg;
  double? protein_g;
  double? carbohydrates_total_g;

  Items(
      {this.sugar_g,
      this.fiber_g,
      this.serving_size_g,
      this.sodium_mg,
      this.name,
      this.potassium_mg,
      this.fat_saturated_g,
      this.fat_total_g,
      this.calories,
      this.cholesterol_mg,
      this.protein_g,
      this.carbohydrates_total_g});

  Items.fromJson(Map<String, dynamic> json) {
    sugar_g = json['sugar_g'];
    fiber_g = json['fiber_g'];
    serving_size_g = json['serving_size_g'];
    sodium_mg = json['sodium_mg'];
    name = json['name'];
    potassium_mg = json['potassium_mg'];
    fat_saturated_g = json['fat_saturated_g'];
    fat_total_g = json['fat_total_g'];
    calories = json['calories'];
    cholesterol_mg = json['cholesterol_mg'];
    protein_g = json['protein_g'];
    carbohydrates_total_g = json['carbohydrates_total_g'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sugar_g'] = this.sugar_g;
    data['fiber_g'] = this.fiber_g;
    data['serving_size_g'] = this.serving_size_g;
    data['sodium_mg'] = this.sodium_mg;
    data['name'] = this.name;
    data['potassium_mg'] = this.potassium_mg;
    data['fat_saturated_g'] = this.fat_saturated_g;
    data['fat_total_g'] = this.fat_total_g;
    data['calories'] = this.calories;
    data['cholesterol_mg'] = this.cholesterol_mg;
    data['protein_g'] = this.protein_g;
    data['carbohydrates_total_g'] = this.carbohydrates_total_g;
    return data;
  }
}
