import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:todo_final/models/todo_list.dart';

part 'nav_bar.g.dart';

final todoFilterProvider = StateProvider<int>((ref) => 0);

@hcwidget
Widget todoNavBar(BuildContext context, WidgetRef ref) {
    return NavigationBar(
        destinations: const [
            NavigationDestination(icon: Icon(Icons.notes), label: "Todo"),
            NavigationDestination(icon: Icon(Icons.format_list_bulleted),
                label: "Doint"),
            NavigationDestination(icon: Icon(Icons.checklist), label: "Done"),
        ], 
        onDestinationSelected: (index) =>
            ref.read(todoFilterProvider.notifier).state = index,
        selectedIndex: ref.watch(todoFilterProvider),
    );
}

