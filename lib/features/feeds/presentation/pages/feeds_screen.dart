import 'package:app_factory/core/helpers/extenstion.dart';
import 'package:app_factory/core/routes/routes.dart';
import 'package:app_factory/core/utils/app_colors.dart';
import 'package:app_factory/core/utils/app_styles.dart';
import 'package:app_factory/core/widget/shimmer_listview.dart';
import 'package:app_factory/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../../main.dart';
import '../cubit/feeds_cubit.dart';
import '../widgets/feeds_screen_widgets/my_drawer.dart';
import '../widgets/feeds_screen_widgets/post_widget.dart';
import '../widgets/feeds_screen_widgets/suggested_friend_widget.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(Assets.assetsAppIcon),
          ),
        ],
        title: Text(
          'Connect',
          style: AppStyles.bold28BlackTextColor.copyWith(fontSize: 18),
        ),
      ),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.addPost);
        },
        backgroundColor: AppColors.blueColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
        child: RefreshIndicator(
          onRefresh: () {
            context.read<FeedsCubit>().getPosts();
            context.read<FeedsCubit>().getSuggestions();
            return Future.value();
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Text(
                  'Suggested',
                  style: AppStyles.bold28BlackTextColor.copyWith(fontSize: 18),
                ),
              ),
              SliverToBoxAdapter(
                child: BlocBuilder<FeedsCubit, FeedsState>(
                  buildWhen: (previous, current) =>
                      previous.getSuggestionsStatus !=
                      current.getSuggestionsStatus,
                  builder: (context, state) {
                    final list = state.suggestions ?? [];
                    if (state.isGetSuggestionLoading) {
                      return const ShimmerCircleListview();
                    }
                    if (state.isGetSuggestionError) {
                      return Center(child: Text(state.errorMessage!));
                    }
                    return SizedBox(
                      height: 205,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: list.length,
                        itemBuilder: (context, index) =>
                            SuggestedFriendWidget(userModel: list[index]),
                      ),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: BlocBuilder<FeedsCubit, FeedsState>(
                  buildWhen: (previous, current) =>
                      previous.bannerAdLoaded != current.bannerAdLoaded,
                  builder: (context, state) {
                    logger.i(state.bannerAdLoaded);
                    if (state.bannerAdLoaded != null &&
                        state.bannerAd != null) {
                      logger.i(state.bannerAd!.size.height.toDouble());
                      return SizedBox(
                        height: state.bannerAd!.size.height.toDouble(),
                        width: state.bannerAd!.size.width.toDouble(),
                        child: AdWidget(ad: state.bannerAd!),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
              BlocBuilder<FeedsCubit, FeedsState>(
                buildWhen: (previous, current) =>
                    previous.getPostsStatus != current.getPostsStatus,
                builder: (context, state) {
                  final list = state.posts ?? [];
                  if (state.isGetError) {
                    return SliverToBoxAdapter(
                      child: Center(child: Text(state.errorMessage!)),
                    );
                  }
                  if (state.isGetSuccess) {
                    return list.isEmpty
                        ? const SliverToBoxAdapter(
                            child: Center(
                              child: Text(
                                'No Posts',
                                style: AppStyles.bold28BlackTextColor,
                              ),
                            ),
                          )
                        : SliverList.separated(
                            itemCount: list.length,
                            separatorBuilder: (context, index) => 10.h,
                            itemBuilder: (context, index) =>
                                PostWidget(model: list[index]),
                          );
                  }
                  return const SliverFillRemaining(child: ShimmerListview());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
