import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'cart_model.g.dart';

@HiveType(typeId: 0)
class Cart extends HiveObject {
  @HiveField(0)
  late final int? id;
  @HiveField(1)
  final String? productId;
  @HiveField(2)
  final String? productName;
  @HiveField(3)
  final int? initialPrice;
  @HiveField(4)
  final int? productPrice;
  @HiveField(5)
  final int? quantity;
  @HiveField(6)
  final String? uintTag;
  @HiveField(7)
  final String? image;

  Cart(
      {required this.id,
      required this.productId,
      required this.productName,
      required this.initialPrice,
      required this.productPrice,
      required this.quantity,
      required this.uintTag,
      required this.image});

  factory Cart.fromMap(Map<dynamic, dynamic> map) {
    return Cart(
        id: map['id'],
        productId: map['productId'],
        productName: map['productName'],
        initialPrice: map['initialPrice'],
        productPrice: map['productPrice'],
        quantity: map['quantity'],
        uintTag: map['uintTag'],
        image: map['image']);
  }

  Map<dynamic, dynamic> tomap() {
    return {
      'id': this.id,
      'productId': this.productId,
      'productName': this.productName,
      'initialPrice': this.initialPrice,
      'productPrice': this.productPrice,
      'quantity': this.quantity,
      'uintTag': this.uintTag,
      'image': this.image,
    };
  }
}
