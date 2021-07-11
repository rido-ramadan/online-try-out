import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:online_try_out/models/question.dart';
import 'package:online_try_out/models/question_group.dart';

class TryOutScreen extends StatelessWidget {
  TryOutScreen({Key? key}) : super(key: key);

  final QuestionGroup group = QuestionGroup(
    id: "id",
    grade: "12",
    subject: "English",
    scoringSystem: ScoringSystem.binary,
    essay: "A perfect circle with diameter 5cm is drawn upon a paper.",
    questions: [
      Question(
        id: "someID",
        question: "With pi = 3.14, find the area of the circle",
        options: [
          "31.4",
          "314",
          "3140",
          "This is non-sense",
        ],
      )
    ],
  );

  Future<QuestionGroup> _deserializedJson() async {
    final jsonString = await rootBundle.loadString('assets/problem-set.json');
    print("JSON string: $jsonString");
    return QuestionGroup.fromJson(
        jsonDecode(jsonString)["subjects"][0]["problem_group"][0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Try Out"),
      ),
      body: ListView(
        children: [
          // QuestionGroupWidget(group: group),
          FutureBuilder<QuestionGroup>(
            future: _deserializedJson(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print('Snapshot has data, sucker!: ${snapshot.data!}');
                return QuestionGroupWidget(group: snapshot.data!);
              }
              print('Nothing');
              return Container();
            },
          ),
        ],
      ),
    );
  }
}

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
