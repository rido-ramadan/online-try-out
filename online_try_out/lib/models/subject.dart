import 'package:json_annotation/json_annotation.dart';
import 'package:online_try_out/models/question_group.dart';

part 'subject.g.dart';

@JsonSerializable(explicitToJson: true)
class Subject {

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'grade')
  final String grade;

  @JsonKey(name: 'problem_set')
  List<QuestionGroup>? problemSet;

  Subject({
    required this.id,
    required this.name,
    required this.grade,
    this.problemSet,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => _$SubjectFromJson(json);
  Map<String, dynamic> toJson() => _$SubjectToJson(this);
}
