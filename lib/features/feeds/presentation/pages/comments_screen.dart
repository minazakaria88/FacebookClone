import 'package:app_factory/core/helpers/extenstion.dart';
import 'package:app_factory/core/helpers/validate_inpus_class.dart';
import 'package:app_factory/core/widget/my_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/posts_model.dart';
import '../cubit/feeds_cubit.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key, required this.model});
  final PostModel model;

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Comment')),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.model.comments.length,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade300,
                  ),
                  child: ListTile(
                    title: Text(widget.model.comments[index].comment),
                    subtitle: Text(widget.model.comments[index].userId),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: MyTextForm(
                    hint: 'Add Comment',
                    controller: controller,
                    validator: (String? value) {
                      return ValidationClass.validateText(
                        value,
                        'Please Enter Comment',
                      );
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.read<FeedsCubit>().addComment(
                      widget.model,
                      controller.text,
                    );
                    controller.clear();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
            20.h,
          ],
        ),
      ),
    );
  }
}
