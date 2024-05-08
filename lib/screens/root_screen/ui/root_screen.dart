import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:platform_for_learning/res.dart';
import 'package:platform_for_learning/screens/root_screen/ui/components/lesson_page.dart';

@RoutePage()
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = LessonPage(
          lessonOne: lessonOne,
        );
        break;
      case 1:
        page = const Placeholder();
        break;
      default:
        page = const Placeholder();
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: IntrinsicHeight(
                    child: NavigationRail(
                      extended: constraints.maxWidth >= 600,
                      destinations: [
                        ...List.generate(20, (index) {
                          return NavigationRailDestination(
                            icon: Container(
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Colors.blueGrey,
                                shape: BoxShape.circle,
                              ),
                              width: 40,
                              height: 40,
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            selectedIcon: Container(
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              width: 40,
                              height: 40,
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            indicatorColor: Colors.red,
                            label: Text('page $index'),
                          );
                        }),
                      ],
                      selectedIndex: selectedIndex,
                      onDestinationSelected: (value) {
                        selectedIndex = value;
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
