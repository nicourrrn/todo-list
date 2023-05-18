import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'todo.dart';

part 'todo_list.g.dart';

const String boxName = "todo_list";

@riverpod
class TodoList extends _$TodoList {

    @override
    FutureOr<List<Todo>> build() async {
        var box = await Hive.openBox<Todo>(boxName);  
        return box.values.toList();
    }

   addTodo(Todo todo) async {
        state = const AsyncValue.loading();
        state = await AsyncValue.guard(() async {
            var box = await Hive.openBox<Todo>(boxName);
            box.add(todo);
            return box.values.toList();
        });
    }
}

