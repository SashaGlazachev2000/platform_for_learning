import 'package:flutter/material.dart';
import 'package:platform_for_learning/data/lesson.dart';
import 'package:platform_for_learning/screens/root_screen/ui/components/quiz_widget.dart';

class LessonPage extends StatelessWidget {
  const LessonPage({
    super.key,
    required this.lessonOne,
  });

  final Lesson lessonOne;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lessonOne.title,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            ...lessonOne.content.map(
              (content) {
                bool activeTitle = content.title != '';
                if (content is TextContent) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      activeTitle
                          ? Text(
                              content.title,
                              style: TextStyle(
                                fontSize: 22,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                color: Colors.red[900],
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        content.text,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  );
                } else if (content is Quiz) {
                  return QuizWidget(quiz: content);
                } else {
                  return ErrorWidget('exception');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
