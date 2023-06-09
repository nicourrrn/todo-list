import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:todo_final/components/nav_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import '../models/todo_list.dart';
import '../models/todo.dart';
import '../components/todo_list_view.dart';

part 'home.g.dart';

@hcwidget
Widget homeScreen(BuildContext context, WidgetRef ref) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () => context.push("/todo_create"),
            child: const Icon(Icons.add),
        ),
        bottomNavigationBar: const TodoNavBar(),
        body: const Padding( padding: EdgeInsets.all(12.0),
            child: Column(children: [TodoListView()])),
    );
}

@hcwidget
Widget todoFormScreen(BuildContext context, WidgetRef ref) {
    
    return Scaffold(
        appBar: AppBar(leading: IconButton(onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back))),
        body: const Padding(padding: EdgeInsets.all(16.0),
            child: Column(children: [TodoForm()])),
    );
}
    

@hcwidget
Widget todoDetail(BuildContext context, WidgetRef ref, Todo todo) {
    return Scaffold(
        appBar: AppBar(title: Text(todo.title)),
        body: Padding(padding: const EdgeInsets.all(16),
            child: Column(children: [
                Hero(tag: "anim-${todo.status.name}", child: Text(todo.desctiprion, style: Theme.of(context).textTheme.bodyLarge))
            ])),
    );
}




@hcwidget 
Widget loginScreen() {
    final result = await FlutterWebAuth2.authenticate(url: "https://my-custom-app.com/connect", callbackUrlScheme: "my-custom-app");

// Extract token from resulting url
    final token = Uri.parse(result).queryParameters['token'];
}


