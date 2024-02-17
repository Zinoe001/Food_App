import 'dart:convert';
import 'dart:io';

class FoodModel {
    final File image;
    final String name;
    final String description;
    final String price;

    FoodModel({
        required this.image,
        required this.name,
        required this.description,
        required this.price,
    });

    FoodModel copyWith({
        File? image,
        String? name,
        String? description,
        String? price,
    }) => 
        FoodModel(
            image: image ?? this.image,
            name: name ?? this.name,
            description: description ?? this.description,
            price: price ?? this.price,
        );

    factory FoodModel.fromRawJson(String str) => FoodModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
        image: json["image"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "description": description,
        "price": price,
    };
}
