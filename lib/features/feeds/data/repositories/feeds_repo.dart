import 'package:app_factory/core/api/api_helper.dart';
import 'package:app_factory/core/api/failure.dart';
import 'package:app_factory/features/feeds/data/models/posts_model.dart';
import 'package:app_factory/features/feeds/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/api/end_points.dart';
import '../../../../main.dart';

class FeedsRepository {
  final ApiHelper apiHelper;
  FeedsRepository({required this.apiHelper});

  final firestore = FirebaseFirestore.instance.collection('posts');

  Future<void> addPost(PostModel model) async {
    await firestore.add(model.toJson());
  }

  Future<List<PostModel>> getPosts() async {
    List<PostModel> posts = [];
    await firestore.get().then((value) {
      for (var element in value.docs) {
        posts.add(PostModel.fromJson(element.data(), element.id));
      }
    });
    return posts;
  }

  Future<void> toggleLike(PostModel post) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (post.likes.contains(userId)) {
      post.likes.remove(userId);
      post.isLiked = false;
      firestore.doc(post.id).update({
        'likes': FieldValue.arrayRemove([userId]),
      });
      post.likes.remove(userId);
      post.isLiked = false;
    } else {
      post.likes.add(userId!);
      post.isLiked = true;
      firestore.doc(post.id).update({
        'likes': FieldValue.arrayUnion([userId]),
      });
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }


  Future<List<UserModel>> getSuggestions() async {
    List<UserModel> users = [];
    try
        {
          final response = await apiHelper.getData(url: EndPoints.suggestions);
          for (var element in response.data) {
            users.add(UserModel.fromJson(element));
          }
          logger.d(response.data);
          return users;
        }catch(e)
        {
          logger.i(e.toString());
          if(e is DioException)
            {
              throw ApiException(failure: ServerFailure.serverError(e));
            }
          throw ApiException(failure: Failure(message: e.toString()));
        }
  }

  
}
