import 'package:app_factory/core/helpers/extenstion.dart';
import 'package:app_factory/core/helpers/validate_inpus_class.dart';
import 'package:app_factory/core/utils/app_styles.dart';
import 'package:app_factory/core/widget/my_button.dart';
import 'package:app_factory/core/widget/my_text_form.dart';
import 'package:app_factory/features/feeds/data/models/posts_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/feeds_cubit.dart';
import '../widgets/add_post_screen_widgets/trending_list.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Create Post',
          style: AppStyles.bold28BlackTextColor.copyWith(fontSize: 18),
        ),
      ),
      body: BlocConsumer<FeedsCubit, FeedsState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Post Added Successfully')),
            );
            Navigator.of(context).pop();
          }
          if (state.isError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        MyTextForm(
                          hint: 'Title',
                          controller: _titleController,
                          validator: (String? value) {
                            return ValidationClass.validateText(
                              value,
                              'Please Enter A valid Title',
                            );
                          },
                        ),
                        30.h,
                        MyTextForm(
                          hint: 'Description',
                          maxLines: 4,
                          controller: _descriptionController,
                          validator: (String? value) {
                            return ValidationClass.validateText(
                              value,
                              'Please Enter A valid Description',
                            );
                          },
                        ),
                        20.h,
                        MyTextForm(
                          hint: 'Image',
                          controller: _imageController,
                          validator: (String? value) {
                            return ValidationClass.validateText(
                              value,
                              'Please Enter A valid Image',
                            );
                          },
                        ),
                        20.h,
                        const TrendingList(),

                        const Spacer(),
                        state.isLoading
                            ? const CircularProgressIndicator()
                            : MyButton(
                                text: 'Publish',
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    PostModel model = PostModel(
                                      userId: FirebaseAuth.instance.currentUser!.uid,
                                      title: _titleController.text,
                                      description: _descriptionController.text,
                                      imageUrl: _imageController.text,
                                      likes: [],
                                      comments: [],
                                      createdAt: DateTime.now(),
                                    );
                                    context.read<FeedsCubit>().addPost(model);
                                  }
                                },
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
