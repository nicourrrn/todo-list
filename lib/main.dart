import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_final/models/todo.dart';
import 'package:go_router/go_router.dart';

import 'screens/home.dart';

main() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TodoAdapter());
    Hive.registerAdapter(TodoStatusAdapter());

    runApp(const ProviderScope(child: MyApp()));
   
    Hive.close();
}

final _router = GoRouter(routes: [
//    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/todo_create', builder: (context, state) => const TodoFormScreen()),
    GoRoute(path: '/todo_detail', builder: (context, state) => TodoDetail(state.extra as Todo))
]);

@immutable
class MyApp extends HookConsumerWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context, WidgetRef ref) {
        
        return MaterialApp.router(
            theme: ThemeData(useMaterial3: true),
            routerConfig: _router,
        );
    }

}
