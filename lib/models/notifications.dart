import 'dart:core';

class Notifications {
  final String title;
  final String description;

  Notifications(
      this.title,
    this.description,
  );

  static Notifications fromMap(Map<String, dynamic> resp) {
    return Notifications(
      resp['title'] as String,
      resp['description'] as String,
    );
  }
}
