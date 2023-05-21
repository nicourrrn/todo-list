// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext _context,
    WidgetRef _ref,
  ) =>
      homeScreen(
        _context,
        _ref,
      );
}

class TodoFormScreen extends HookConsumerWidget {
  const TodoFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext _context,
    WidgetRef _ref,
  ) =>
      todoFormScreen(
        _context,
        _ref,
      );
}

class TodoDetail extends HookConsumerWidget {
  const TodoDetail(
    this.todo, {
    Key? key,
  }) : super(key: key);

  final Todo todo;

  @override
  Widget build(
    BuildContext _context,
    WidgetRef _ref,
  ) =>
      todoDetail(
        _context,
        _ref,
        todo,
      );
}
