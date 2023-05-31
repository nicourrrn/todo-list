import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:todo_final/components/nav_bar.dart';
import 'package:todo_final/models/todo_list.dart';

import '../models/todo.dart';

part 'todo_list_view.g.dart';



@hcwidget
Widget todoTile(BuildContext context, WidgetRef ref, Todo todo) {
    changeStatus(Todo todo, int changeTo) {
        int newNum = todo.status.index + changeTo;
        if (0 < newNum && newNum < TodoStatus.values.length) {
            ref.read(todoListProvider.notifier)
            .changeStatus(todo.id, TodoStatus.values[todo.status.index + changeTo]);
        }
    }

    return ListTile(
        title: Text("#${todo.id}) ${todo.title}"),
        subtitle: Hero(tag: "anim-${todo.status.name}", child: Text(todo.status.name)),
        trailing: IconButton(onPressed: () => changeStatus(todo, 1),
                icon: const Icon(Icons.chevron_right)),
        onLongPress: () => changeStatus(todo, -1),
        onTap: () => context.push('/todo_detail', extra: todo),        
    ); 
}

@hcwidget
Widget todoListView(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoListProvider);
    final filterBy = ref.watch(todoFilterProvider);

    return todoList.when(data: (todos) => Expanded(child: ListView(children: [
        for (final todo in todos)
        if (todo.status == TodoStatus.values[filterBy])
            TodoTile(todo)
    ])),
    error: (err, stack) => Center(child: Text("$err")),
    loading: () => const Center(child: CircularProgressIndicator()));
}

@hcwidget
Widget todoForm(BuildContext context, WidgetRef ref) {
    final titleCtrl = useTextEditingController();
    final descCtrl = useTextEditingController(); 
    var descFocus = FocusNode(); 
    var saveFocus = FocusNode(); 

    saveTodo() {
        final todoList = ref.read(todoListProvider.notifier);
        todoList.addTodo(Todo(
            title: titleCtrl.text,
            desctiprion: descCtrl.text 
        ));
        context.pop();
    }

    return Wrap(runSpacing: 20, alignment: WrapAlignment.center, children: [
        TextField(controller: titleCtrl, autofocus: true,
            onSubmitted: (_) => descFocus.requestFocus(),
            decoration: const InputDecoration(labelText: "Title"),),
        TextField(controller: descCtrl, focusNode: descFocus,
         onSubmitted: (_) => saveFocus.requestFocus(),
         decoration: const InputDecoration(labelText: "Desctiprion")),
        TextButton(onPressed: saveTodo, child: const Text("Save"),
            focusNode: saveFocus,),
    ]);
}
