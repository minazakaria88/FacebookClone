import 'package:app_factory/core/helpers/extenstion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/routes/routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../cubit/feeds_cubit.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColors.blueColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Connect',
                  style: AppStyles.bold28BlackTextColor.copyWith(
                    color: Colors.white,
                  ),
                ),
                10.h,
                Text(
                  FirebaseAuth.instance.currentUser!.displayName ?? '',
                  style: AppStyles.regular16textgreyColor.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              context.read<FeedsCubit>().logout();
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(Routes.register, (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
