import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

import '../components/todo_list_view.dart';

part 'home.g.dart';

@hcwidget
Widget homeScreen(BuildContext context, WidgetRef ref) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () => context.push("/todo_create"),
        ),
        body: const Column(children: [
            TodoListView() 
        ],),
    );
}

@hcwidget
Widget todoFormScreen(BuildContext context, WidgetRef ref) {
    
    return const Scaffold(
        body: Column(children: [
            TodoForm() 
        ]),
    );
}
