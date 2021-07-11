import 'package:flutter/material.dart';
import 'package:online_try_out/models/subject.dart';
import 'package:online_try_out/screens/try_out/widgets/question_group_widget.dart';

class SubjectProblemSetWidget extends StatelessWidget {
  final Subject subject;

  const SubjectProblemSetWidget({
    required this.subject,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildProblemSet(context),
    );
  }

  List<Widget> _buildProblemSet(BuildContext context) {
    List<Widget> output = [];
    if (subject.problemSet != null) {
      output = subject.problemSet!
          .map((group) => QuestionGroupWidget(group: group))
          .toList();
    }
    return output;
  }
}
