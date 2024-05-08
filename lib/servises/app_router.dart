import 'package:auto_route/auto_route.dart';
import 'package:platform_for_learning/screens/root_screen/ui/root_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(
          page: RootRoute.page,
          initial: true,
          children: const [],
        )
      ];
}
