import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String userId;
  final String comment;
  final DateTime ? createdAt;



  CommentModel({
    required this.userId,
    required this.comment,
     this.createdAt,
  });


  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      userId: json['userId'],
      comment: json['comment'],
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'comment': comment,
      'createdAt': DateTime.now(),
    };
  }
}