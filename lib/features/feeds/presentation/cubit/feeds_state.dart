part of 'feeds_cubit.dart';

enum AddPostStatus { initial, loading, success, error }

enum GetPostsStatus { initial, loading, success, error }

enum GetSuggestionsStatus { initial, loading, success, error }
enum ToggleLikeStatus { initial, loading, success, error }
extension FeedStatusX on FeedsState {
  bool get isLoading => addPostStatus == AddPostStatus.loading;
  bool get isSuccess => addPostStatus == AddPostStatus.success;
  bool get isError => addPostStatus == AddPostStatus.error;
  bool get isGetLoading => getPostsStatus == GetPostsStatus.loading;
  bool get isGetSuccess => getPostsStatus == GetPostsStatus.success;
  bool get isGetError => getPostsStatus == GetPostsStatus.error;
  bool get isGetSuggestionLoading => getSuggestionsStatus == GetSuggestionsStatus.loading;
  bool get isGetSuggestionSuccess => getSuggestionsStatus == GetSuggestionsStatus.success;
  bool get isGetSuggestionError => getSuggestionsStatus == GetSuggestionsStatus.error;
  bool get isToggleLikeLoading => toggleLikeStatus == ToggleLikeStatus.loading;
  bool get isToggleLikeSuccess => toggleLikeStatus == ToggleLikeStatus.success;
  bool get isToggleLikeError => toggleLikeStatus == ToggleLikeStatus.error;

}

class FeedsState extends Equatable {
  AddPostStatus? addPostStatus;
  GetPostsStatus? getPostsStatus;
  String? errorMessage;
  List<PostModel>? posts;
  ToggleLikeStatus? toggleLikeStatus;
  GetSuggestionsStatus? getSuggestionsStatus;
  List<UserModel>? suggestions;
   BannerAd? bannerAd;
   bool ? bannerAdLoaded;

  FeedsState({
    this.addPostStatus,
    this.errorMessage,
    this.getPostsStatus,
    this.posts,
    this.toggleLikeStatus,
    this.getSuggestionsStatus,
    this.suggestions,
    this.bannerAd,
    this.bannerAdLoaded
  });

  FeedsState copyWith({
    AddPostStatus? addPostStatus,
    String? errorMessage,
    GetPostsStatus? getPostsStatus,
    List<PostModel>? posts,
    ToggleLikeStatus? toggleLikeStatus,
    GetSuggestionsStatus? getSuggestionsStatus,
    List<UserModel>? suggestions,
    BannerAd? bannerAd,
    bool ? bannerAdLoaded
  }) {
    return FeedsState(
      addPostStatus: addPostStatus ?? this.addPostStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      getPostsStatus: getPostsStatus ?? this.getPostsStatus,
      posts: posts ?? this.posts,
      toggleLikeStatus: toggleLikeStatus ?? this.toggleLikeStatus,
      getSuggestionsStatus: getSuggestionsStatus ?? this.getSuggestionsStatus,
      suggestions: suggestions ?? this.suggestions,
      bannerAd: bannerAd ?? this.bannerAd,
      bannerAdLoaded: bannerAdLoaded ?? this.bannerAdLoaded
    );
  }

  @override
  List<Object?> get props => [
    addPostStatus,
    errorMessage,
    getPostsStatus,
    posts,
    toggleLikeStatus,
    getSuggestionsStatus,
    suggestions,
    bannerAd,
    bannerAdLoaded
  ];
}
