ListView.builder(
        itemCount: todoList.length,
        itemBuilder: ((context, index) {
          final todo = todoList[index];
          return Dismissible(
            key: Key(todo.id.toString()),
            onDismissed: (direction) {
              // Delete item when swiped
              context.read<TodoListProvider>().deleteTodo(todo.title);

              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${todo.title} dismissed')));
            },
            background: Container(
              color: Colors.red,
              child: const Icon(Icons.delete),
            ),
            child: ListTile(
              title: Text(todo.title),
              leading: Checkbox(
                value: todo.completed,
                onChanged: (bool? value) {
                  context.read<TodoListProvider>().toggleStatus(index, value!);
                },
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => TodoModal(
                          type: 'Edit',
                          todoIndex: index,
                        ),
                      );
                    },
                    icon: const Icon(Icons.create_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => TodoModal(
                          type: 'Delete',
                          todoIndex: index,
                        ),
                      );
                    },
                    icon: const Icon(Icons.delete_outlined),
                  )
                ],
              ),
            ),
          );
        }),
      ),