import 'package:platform_for_learning/data/lesson.dart';

abstract class QuizState {}

class InitialQuizState extends QuizState {
  final Quiz quiz;

  InitialQuizState(this.quiz);
}

class SelectedQuizState extends QuizState {
  final Quiz quiz;
  final bool isSelectedAnswer;
  final int selectedIndex;
  final bool allowReplay;

  SelectedQuizState({
    required this.isSelectedAnswer,
    required this.quiz,
    required this.selectedIndex,
    required this.allowReplay,
  });
}

class ResultQuizState extends QuizState {
  final Quiz quiz;
  final int selectedIndex;
  final stopQuiz = true;

  ResultQuizState({
    required this.quiz,
    required this.selectedIndex,
  });
}
