import 'package:app_factory/core/api/failure.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../../main.dart';
import '../../data/models/posts_model.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/feeds_repo.dart';

part 'feeds_state.dart';

class FeedsCubit extends Cubit<FeedsState> {
  FeedsCubit({required this.feedsRepository}) : super(FeedsState());
  final FeedsRepository feedsRepository;

  void addPost(PostModel model) async {
    try {
      emit(state.copyWith(addPostStatus: AddPostStatus.loading));
      await feedsRepository.addPost(model);
      emit(state.copyWith(addPostStatus: AddPostStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          addPostStatus: AddPostStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void getPosts() async {
    try {
      emit(state.copyWith(getPostsStatus: GetPostsStatus.loading));
      final posts = await feedsRepository.getPosts();
      emit(
        state.copyWith(getPostsStatus: GetPostsStatus.success, posts: posts),
      );
    } catch (e) {
      emit(
        state.copyWith(
          getPostsStatus: GetPostsStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void toggleLike(PostModel post) async {
    try {
      emit(state.copyWith(toggleLikeStatus: ToggleLikeStatus.loading));
      await feedsRepository.toggleLike(post);
      emit(state.copyWith(toggleLikeStatus: ToggleLikeStatus.success));
    } catch (e) {
      logger.i(e.toString());
      emit(
        state.copyWith(
          toggleLikeStatus: ToggleLikeStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void getSuggestions() async {
    try {
      emit(state.copyWith(getSuggestionsStatus: GetSuggestionsStatus.loading));
      final posts = await feedsRepository.getSuggestions();
      emit(
        state.copyWith(
          getSuggestionsStatus: GetSuggestionsStatus.success,
          suggestions: posts,
        ),
      );
    } catch (e) {
      if (e is ApiException) {
        emit(
          state.copyWith(
            getSuggestionsStatus: GetSuggestionsStatus.error,
            errorMessage: e.failure.message,
          ),
        );
      }
      emit(
        state.copyWith(
          getSuggestionsStatus: GetSuggestionsStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void loadBannerAd() {
    final banner = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          logger.i(ad);
          emit(state.copyWith(bannerAd: ad as BannerAd, bannerAdLoaded: true));
          logger.i('Ad loaded');
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          logger.i('Ad load failed ${error.message}');
        },
      ),
    );
    banner.load();
  }

  void logout() async {
    await feedsRepository.logout();
  }
}
