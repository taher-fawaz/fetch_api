import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class Product with ChangeNotifier {
  final String? id;
  final String? title;
  final String? content;

  Product({
    @required this.id,
    @required this.title,
    @required this.content,
  });

  static Product fromJson(json) => Product(
        id: json['id'],
        title: json['title'],
        content: json['content'],
      );
}
