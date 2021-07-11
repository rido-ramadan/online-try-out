import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:online_try_out/models/subject.dart';
import 'package:online_try_out/screens/try_out/widgets/subject_problem_set.dart';

class TryOutScreen extends StatelessWidget {
  TryOutScreen({Key? key}) : super(key: key);

  Future<List<Subject>> _loadSubjects() async {
    final jsonString = await rootBundle.loadString('assets/problem-set.json');
    final output = (jsonDecode(jsonString)["subjects"] as List)
        .map((e) => Subject.fromJson(e))
        .toList();

    output.forEach((subject) {
      subject.problemSet?.forEach((questionGroup) {
        questionGroup.questions.shuffle();
      });
      subject.problemSet?.shuffle();
    });

    return output;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Subject>>(
      future: _loadSubjects(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final subjects = snapshot.data!;

          return DefaultTabController(
            length: subjects.length,
            child: Scaffold(
              appBar: AppBar(
                title: Text("Try Out"),
                bottom: TabBar(
                  tabs: List.generate(subjects.length,
                      (index) => Tab(text: subjects[index].name)),
                ),
              ),
              body: TabBarView(
                children: List.generate(
                    subjects.length,
                    (index) => ListView(
                          children: [
                            SubjectProblemSetWidget(subject: subjects[index]),
                          ],
                        )),
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.check),
                onPressed: () {
                  print(jsonEncode(subjects));
                },
              ),
            ),
          );
        }

        return Container();
      },
    );
  }
}
