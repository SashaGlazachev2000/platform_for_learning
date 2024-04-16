import 'package:flutter/material.dart';
import 'package:platform_for_learning/features/lesson/domain/lesson.dart';

class QuizWidget extends StatelessWidget {
  const QuizWidget({super.key, required this.quiz});

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        ...quiz.variants.map(
          (text) => QuizCheckBox(text: text),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Проверить'),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

class QuizCheckBox extends StatefulWidget {
  const QuizCheckBox({super.key, required this.text});

  final String text;

  @override
  State<QuizCheckBox> createState() => _QuizCheckBoxState();
}

class _QuizCheckBoxState extends State<QuizCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: const CircleBorder(),
          value: isChecked,
          onChanged: (bool? value) {
            setState(
              () {
                isChecked = value!;
              },
            );
          },
        ),
        Text(widget.text),
      ],
    );
  }
}
