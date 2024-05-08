import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_for_learning/data/lesson.dart';
import 'package:platform_for_learning/screens/root_screen/quiz_bloc/quiz_bloc.dart';
import 'package:platform_for_learning/screens/root_screen/quiz_bloc/quiz_event.dart';
import 'package:platform_for_learning/screens/root_screen/quiz_bloc/quiz_state.dart';

/// Викторина виджет. Использует [QuizBloc]
class QuizWidget extends StatelessWidget {
  const QuizWidget({super.key, required this.quiz});

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuizBloc(quiz: quiz),
      child: const _QuizBodyWidget(),
    );
  }
}

class _QuizBodyWidget extends StatelessWidget {
  const _QuizBodyWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(builder: (context, state) {
      switch (state.runtimeType) {
        case InitialQuizState:
          state as InitialQuizState;
          return _QuizStateWidget(
            quiz: state.quiz,
          );
        case SelectedQuizState:
          state as SelectedQuizState;
          return _QuizStateWidget(
            quiz: state.quiz,
            isSelectedAnswer: state.isSelectedAnswer,
            selectedIndex: state.selectedIndex,
            allowReplay: state.allowReplay,
          );
        case ResultQuizState:
          state as ResultQuizState;
          return _QuizStateWidget(
            quiz: state.quiz,
            selectedIndex: state.selectedIndex,
            stopQuiz: state.stopQuiz,
          );
        default:
          return const Center(child: Text('Ошибка'));
      }
    });
  }
}

class _QuizStateWidget extends StatelessWidget {
  final Quiz quiz;
  final bool isSelectedAnswer;
  final int? selectedIndex;
  final bool allowReplay;
  final bool stopQuiz;

  const _QuizStateWidget({
    this.isSelectedAnswer = false,
    this.selectedIndex,
    this.stopQuiz = false,
    this.allowReplay = true,
    required this.quiz,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: stopQuiz,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Text(
            quiz.title,
            style: TextStyle(
              fontSize: 22,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
          ),
          ...quiz.variants.asMap().entries.map(
                (text) => QuizCheckBox(
                  text: text.value,
                  isChecked: text.key == selectedIndex && allowReplay,
                  onChanged: () {
                    context.read<QuizBloc>().add(
                          ChooseAnswerQuizEvent(index: text.key),
                        );
                  },
                  isRightAnswer: quiz.indexRightAnswer == text.key && stopQuiz,
                  stopQuiz: stopQuiz,
                ),
              ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: isSelectedAnswer
                ? () {
                    int index = 0;
                    if (selectedIndex != null) {
                      index = selectedIndex!;
                    } else {
                      return;
                    }
                    context.read<QuizBloc>().add(
                          CheckingAnswerQuizEvent(index: index),
                        );
                  }
                : null,
            child: const Text('Проверить'),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

class QuizCheckBox extends StatelessWidget {
  final bool isChecked;
  final String text;
  final VoidCallback onChanged;
  final bool isRightAnswer;
  final bool stopQuiz;

  const QuizCheckBox({
    super.key,
    this.isChecked = false,
    this.isRightAnswer = false,
    this.stopQuiz = false,
    required this.text,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: const CircleBorder(),
          activeColor: stopQuiz
              ? isRightAnswer
                  ? Colors.green
                  : Colors.red
              : null,
          value: isRightAnswer ? true : isChecked,
          onChanged: (_) {
            onChanged();
          },
        ),
        Text(text),
      ],
    );
  }
}
