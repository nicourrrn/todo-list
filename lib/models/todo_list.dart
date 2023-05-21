import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'todo.dart';

part 'todo_list.g.dart';

const String boxName = "todo_list";

@riverpod
class TodoList extends _$TodoList {
    
    int _lastId = 0;

    @override
    FutureOr<List<Todo>> build() async {
        var box = await Hive.openBox<Todo>(boxName);  
        for (final todo in box.values) {
            _lastId = todo.id > _lastId ? todo.id : _lastId; 
        }
        return box.values.toList();
    }

   addTodo(Todo todo) async {
        state = const AsyncValue.loading();
        state = await AsyncValue.guard(() async {
            var box = await Hive.openBox<Todo>(boxName);
            box.put(++_lastId, todo.copyWith(id: _lastId));
            return box.values.toList();
        });
    }

    changeStatus(int todoId, TodoStatus newStatus) async {
        state = const AsyncValue.loading();
        state = await AsyncValue.guard(() async {
            var box = await Hive.openBox<Todo>(boxName);
            List<Todo> result = []; 
            for (final todo in box.values){ 
                if (todo.id == todoId){ 
                    result.add(todo.copyWith(status: newStatus));
                    box.put(result.last.id, result.last);
                }
                else {
                    result.add(todo);
                }
            }
            return result;
        });
    }
}

