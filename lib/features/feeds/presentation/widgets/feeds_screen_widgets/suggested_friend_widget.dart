import 'package:app_factory/core/helpers/extenstion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../data/models/user_model.dart';

class SuggestedFriendWidget extends StatelessWidget {
  const SuggestedFriendWidget({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: SvgPicture.network(
              userModel.image,
              height: 120,
              width: 120,
              placeholderBuilder: (context) =>
                  const CircularProgressIndicator(),
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
            ),
          ),
          5.h,
          Text(
            userModel.name,
            maxLines: 1,
            style: AppStyles.medium16BlackTextColor,
          ),
          5.h,
          Text(
            userModel.email,
            maxLines: 1,
            style: AppStyles.regular14textgreyColor,
          ),
        ],
      ),
    );
  }
}
