import 'dart:core';


class Book {
  final int id;
  final String title;
  final String description;

  const Book({
    this.id,
    this.title,
    this.description,
});

  factory Book.fromJson(Map<String, dynamic> json){
    return Book(
      id: json['id'],
      title: json['title'],
      description: json['description']
    );
  }


}