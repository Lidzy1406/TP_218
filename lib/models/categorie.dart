import 'package:flutter/foundation.dart';

class Category {
   String name;
  String description;

  Category({required this.name, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
    };
  }
}



  