import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:online_try_out/models/subject.dart';
import 'package:online_try_out/screens/try_out/widgets/subject_problem_set.dart';

class TryOutScreen extends StatelessWidget {

  TryOutScreen({Key? key}) : super(key: key);

  Future<Subject> _loadSubjectProblemSet() async {
    final jsonString = await rootBundle.loadString('assets/problem-set.json');
    return Subject.fromJson(jsonDecode(jsonString)["subjects"][0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Try Out"),
      ),
      body: ListView(
        children: [
          FutureBuilder<Subject>(
            future: _loadSubjectProblemSet(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final subject = snapshot.data!;
                return SubjectProblemSetWidget(subject: subject);
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
