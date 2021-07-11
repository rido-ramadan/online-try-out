import 'package:json_annotation/json_annotation.dart';
import 'package:online_try_out/models/question.dart';

part 'question_group.g.dart';

@JsonSerializable(explicitToJson: true)
class QuestionGroup {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'grade')
  final String grade;

  @JsonKey(name: 'subject')
  final String subject;

  @JsonKey(name: 'scoring_system')
  final ScoringSystem scoringSystem;

  @JsonKey(name: 'essay')
  final String? essay;

  @JsonKey(name: 'image_url')
  final String? imageURL;

  @JsonKey(name: 'questions')
  final List<Question> questions;

  QuestionGroup({
    required this.id,
    required this.grade,
    required this.subject,
    required this.scoringSystem,
    this.essay,
    this.imageURL,
    required this.questions,
  });

  factory QuestionGroup.fromJson(Map<String, dynamic> json) =>
      _$QuestionGroupFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionGroupToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ScoringSystem {
  @JsonKey(name: 'correct')
  final int correct;

  @JsonKey(name: 'incorrect')
  final int incorrect;

  @JsonKey(name: 'empty')
  final int empty;

  const ScoringSystem({
    this.correct: 1,
    this.incorrect: 0,
    this.empty: 0,
  });

  factory ScoringSystem.fromJson(Map<String, dynamic> json) =>
      _$ScoringSystemFromJson(json);

  Map<String, dynamic> toJson() => _$ScoringSystemToJson(this);

  static const ScoringSystem binary = ScoringSystem(correct: 1);

  static const ScoringSystem penalty = ScoringSystem(
    correct: 4,
    incorrect: -1,
    empty: 0,
  );
}
