import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.g.dart';
part 'todo.freezed.dart';

@HiveType(typeId: 2)
enum TodoStatus {
    @HiveField(0)
    todo,
    @HiveField(1)
    doint,
    @HiveField(2)
    done,
}


@freezed
class Todo extends HiveObject with _$Todo {
    Todo._();
    
    @HiveType(typeId: 1, adapterName: "TodoAdapter")
    factory Todo({
        @Default(0) int id,
        @HiveField(0) required String title,
        @Default(TodoStatus.todo) @HiveField(1) TodoStatus status,
        @Default("") @HiveField(2) String desctiprion,
    }) = _Todo;
}

class TodoAdapter extends TypeAdapter<Todo> {
    @override
    final typeId = 1;
    
    @override
    write(BinaryWriter writer, Todo todo) {
        writer.writeString(todo.title);
        writer.write(todo.status);
        writer.writeString(todo.desctiprion);
    }

    @override
    Todo read(BinaryReader reader) {
        return Todo(
            title: reader.readString(),
            status: reader.read(),
            desctiprion: reader.readString(),
        );        
    }
}

