import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class Question {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'question')
  final String question;

  @JsonKey(name: 'options')
  final List<String> options;

  @JsonKey(name: 'answer')
  int? answer;

  Question({
    required this.id,
    required this.question,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

@JsonSerializable()
class Solution extends Question {
  @JsonKey(name: 'solution')
  final int solution;

  Solution({
    required String id,
    required String question,
    required List<String> options,
    required this.solution,
  }) : super(
          id: id,
          question: question,
          options: options,
        );

  factory Solution.fromJson(Map<String, dynamic> json) => _$SolutionFromJson(json);
  Map<String, dynamic> toJson() => _$SolutionToJson(this);
}
