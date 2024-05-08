import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_for_learning/data/lesson.dart';
import 'package:platform_for_learning/screens/root_screen/quiz_bloc/quiz_event.dart';
import 'package:platform_for_learning/screens/root_screen/quiz_bloc/quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  Quiz quiz;
  int? saveSelectedIndex;
  bool allowReplay = false;

  QuizBloc({required this.quiz}) : super(InitialQuizState(quiz)) {
    on<ChooseAnswerQuizEvent>(_chooseAnswer);
    on<CheckingAnswerQuizEvent>(_checkingAnswer);
  }

  void _chooseAnswer(
      ChooseAnswerQuizEvent event, Emitter<QuizState> emit) async {
    if (saveSelectedIndex != event.index) {
      allowReplay = true;
    } else {
      allowReplay = !allowReplay;
    }

    emit(
      SelectedQuizState(
        isSelectedAnswer: allowReplay,
        quiz: quiz,
        selectedIndex: event.index,
        allowReplay: allowReplay,
      ),
    );
    saveSelectedIndex = event.index;
  }

  void _checkingAnswer(
      CheckingAnswerQuizEvent event, Emitter<QuizState> emit) async {
    emit(
      ResultQuizState(
        quiz: quiz,
        selectedIndex: event.index,
      ),
    );
    saveSelectedIndex = event.index;
  }
}
