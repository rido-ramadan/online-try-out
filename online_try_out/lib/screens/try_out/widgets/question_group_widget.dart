import 'package:flutter/material.dart';
import 'package:online_try_out/models/question_group.dart';
import 'package:online_try_out/screens/try_out/widgets/question_widget.dart';

class QuestionGroupWidget extends StatelessWidget {
  final QuestionGroup group;

  const QuestionGroupWidget({required this.group, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildQuestionGroup(context),
    );
  }

  List<Widget> _buildQuestionGroup(BuildContext context) {
    List<Widget> widgets = [];
    if (group.imageURL != null && group.imageURL!.isNotEmpty) {
      widgets.add(
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Image.network(group.imageURL!),
        ),
      );
    }
    if (group.essay != null && group.essay!.isNotEmpty) {
      widgets.add(
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            group.essay!,
            style: TextStyle(fontSize: 14.0),
          ),
        ),
      );
    }
    final questionWidgets = group.questions
        .asMap()
        .map((i, q) => MapEntry(i, QuestionWidget(index: (i + 1), question: q)))
        .values
        .toList();
    widgets.addAll(questionWidgets);
    return widgets;
  }
}