import 'package:app_factory/core/helpers/extenstion.dart';
import 'package:app_factory/features/feeds/data/models/posts_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../cubit/feeds_cubit.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key, required this.model});
  final PostModel model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedsCubit, FeedsState>(
      buildWhen: (previous, current) => previous.toggleLikeStatus != current.toggleLikeStatus,
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: CachedNetworkImage(
                height: 200,
                width: double.infinity,
                imageUrl: model.imageUrl,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.fill,
              ),
            ),
            5.h,
            Text(model.title, maxLines: 1, style: AppStyles.bold18BlackTextColor),
            5.h,
            Text(model.description, style: AppStyles.regular14textgreyColor),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    context.read<FeedsCubit>().toggleLike(model);
                  },
                  icon: Icon(
                    model.isLiked! ? Icons.favorite : Icons.favorite_border,
                    color: model.isLiked! ? Colors.red : AppColors.textGreyColor,
                  ),
                ),
                Text(
                  model.likes.length.toString(),
                  style: AppStyles.bold18BlackTextColor.copyWith(
                    fontSize: 14,
                    color: AppColors.textGreyColor,
                  ),
                ),


              ],
            ),
          ],
        ),
      ),
    );
  }
}
