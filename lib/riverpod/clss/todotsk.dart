import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final todoProvider =
StateNotifierProvider<TodoNotifier, List<TodoModel>>((ref) {
  return TodoNotifier();
});

class TodoModel {
  final String title;
  final bool isDone;

  TodoModel({ required this.title, this.isDone = false});

  TodoModel copyWith({String? id, String? title, bool? isDone}) {
    return TodoModel(
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}

class TodoNotifier extends StateNotifier<List<TodoModel>> {
  TodoNotifier() : super([]);

  void add(String title) {
    final todo = TodoModel(title: title);
    state = [...state, todo];
  }

  void toggle(String title) {
    state = state.map((todo) {
      if (todo.title == title) {
        return todo.copyWith(isDone: !todo.isDone);
      }
      return todo;
    }).toList();
  }
  void removeItem(int index) {
    final toRemove = [...state];
    toRemove.removeAt(index);
    state = toRemove;
  }

}
class TodoPanel extends ConsumerStatefulWidget {
  const TodoPanel({super.key});

  @override
  ConsumerState<TodoPanel> createState() => _TodoPanelState();
}

class _TodoPanelState extends ConsumerState<TodoPanel> {
  final TextEditingController todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoProvider);

    return Scaffold(
      appBar: AppBar(
        title:Text("TO DO "),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: todoController,
                    decoration:InputDecoration(
                      labelText: 'Enter a todo',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    final text = todoController.text.trim();
                    if (text.isNotEmpty) {
                      ref.read(todoProvider.notifier).add(text);
                      todoController.clear();
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            ),
            SizedBox(height: 20),

            Expanded(
              child: todos.isEmpty
                  ? Center(child: Text("No todos yet!"))
                  : ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return Card(
                    child: ListTile(
                      leading: Checkbox(
                        value: todo.isDone,
                        onChanged: (value) =>
                            ref.read(todoProvider.notifier).toggle(todo.title),
                      ),
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          fontSize: 16,
                          decoration: todo.isDone
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => ref
                                .read(todoProvider.notifier)
                                .removeItem(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.red),
                            onPressed: () => ref
                                .read(todoProvider.notifier)
                                .removeItem(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
