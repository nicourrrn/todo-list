import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:todo_final/models/todo_list.dart';

import '../models/todo.dart';

part 'todo_list_view.g.dart';

@hcwidget
Widget todoListView(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoListProvider);

    return todoList.when(data: (todos) => Expanded(child: ListView(children: [
        for (final todo in todos)
        ListTile(
            title: Text(todo.title),
            subtitle: Text(todo.status.toString()),
        )
    ])),
    error: (err, stack) => Center(child: Text("$err")),
    loading: () => const Center(child: CircularProgressIndicator()));
}

@hcwidget
Widget todoForm(BuildContext context, WidgetRef ref) {
    final titleCtrl = useTextEditingController();
    final descCtrl = useTextEditingController();
    
    saveTodo() {
        final todoList = ref.read(todoListProvider.notifier);
        todoList.addTodo(Todo(
            title: titleCtrl.text,
            desctiprion: descCtrl.text 
        ));
        context.pop();
    }

    return Column(children: [
        TextField(controller: titleCtrl),
        TextField(controller: descCtrl,),
        TextButton(onPressed: saveTodo, child: const Text("Save")),
    ]);
}
