import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  final String id;
  final String image;
  final String title;
  // final String description;
  final String starttime;
  final String endtime;
  final String categories;
  final DateTime createdAt;
  Item({
    required this.id,
    required this.image,
    required this.title,
    // required this.description,
    required this.starttime,
    required this.endtime,
    required this.categories,
    required this.createdAt,
  });

  Item copyWith({
    String? id,
    String? image,
    String? title,
    // String? description,
    String? starttime,
    String? endtime,
    String? categories,
    DateTime? createdAt,

  }) {
    return Item(
      id: id ?? this.id,
      image: image ?? this.image,
      title: title ?? this.title,
      // description: description ?? this.description,
      starttime: starttime ?? this.starttime,
      endtime: endtime ?? this.endtime,
      categories: categories ?? this.categories,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'title': title,
      // 'description': description,
      'starttime': starttime,
      'endtime': endtime,
      'categories': categories,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory Item.fromFirestore(DocumentSnapshot doc) {
    final Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
    return Item(
      id: doc.id,
      image: map['image'] ?? '',
      title: map['title'] ?? '',
      // description: map['description'] ?? '',
      starttime: map['starttime'] ?? '',
      endtime: map['endtime'] ?? '',
      categories: map['categories'] ?? '',
      createdAt: map['createdAt'].toDate(),
    );
  }

  factory Item.empty() => Item(
        id: '',
        image: '',
        title: '',
        // description: '',
        starttime: '',
        endtime: '',
        categories: '',
        createdAt: DateTime.now(),
      );
}
