abstract class QuizEvent {}

class ChooseAnswerQuizEvent extends QuizEvent {
  final int index;

  ChooseAnswerQuizEvent({required this.index});
}

class CheckingAnswerQuizEvent extends QuizEvent {
  final int index;

  CheckingAnswerQuizEvent({required this.index});
}
