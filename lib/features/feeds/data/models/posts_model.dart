import 'package:app_factory/features/feeds/data/models/comment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostModel {
  final String? id;
  final String userId;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> likes;
  final List<CommentModel> comments;
  final DateTime createdAt;
   bool? isLiked;

  PostModel({
    this.id,
    this.isLiked,
    required this.comments,
    required this.userId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.likes,
    required this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json, String id) {
    return PostModel(
      id: id,
      comments: List<CommentModel>.from(
        json['comments']?.map((x) => CommentModel.fromJson(x)) ?? [],
      ),
      userId: json['userId'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      likes: List<String>.from(json['likes'] ?? []),
      isLiked: List<String>.from(
        json['likes'] ?? [],
      ).contains(FirebaseAuth.instance.currentUser!.uid),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'likes': likes,
      'comments': comments,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
