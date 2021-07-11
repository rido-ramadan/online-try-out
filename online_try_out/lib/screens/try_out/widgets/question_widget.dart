import 'package:flutter/material.dart';
import 'package:online_try_out/models/question.dart';

class QuestionWidget extends StatefulWidget {
  final Question question;
  final int index;

  const QuestionWidget({
    required this.index,
    required this.question,
    Key? key,
  }) : super(key: key);

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildQuestion(context),
      ),
    );
  }

  List<Widget> _buildQuestion(BuildContext context) {
    List<Widget> widgets = [
      ListTile(
        leading: Text("${widget.index}."),
        title: Text(
          widget.question.question,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    ];
    final multipleChoice = widget.question.options.asMap().entries.map((entry) {
      return Padding(
        padding: EdgeInsets.only(left: 48.0),
        child: RadioListTile<int?>(
          value: entry.key,
          groupValue: widget.question.answer,
          title: Text(
            entry.value,
            style: TextStyle(fontSize: 14.0),
          ),
          onChanged: (value) {
            setState(() {
              widget.question.answer = value;
            });
          },
        ),
      );
    }).toList();
    widgets.addAll(multipleChoice);
    return widgets;
  }
}