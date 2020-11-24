import 'package:flutter/material.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Todo List',
        home: TodoList(),
        debugShowCheckedModeBanner: false,
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  // This will be called each time the + button is pressed
  void _addTodoItem(String task) {
    // Only add the task if the user actually entered something
    if (task.length > 0) {
      setState(() => _todoItems.add(task));
    }
  }

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  // Show an alert dialog asking the user to confirm that the task is done
  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return  AlertDialog(
              title:  Text('Mark "${_todoItems[index]}" as done?'),
              actions: <Widget>[
                 FlatButton(
                    child:  Text('CANCEL'),
                    onPressed: () => Navigator.of(context).pop()
                ),
                 FlatButton(
                    child:  Text('MARK AS DONE'),
                    onPressed: () {
                      _removeTodoItem(index);
                      Navigator.of(context).pop();
                    }
                )
              ]
          );
        }
    );
  }


  Widget _buildTodoList() {
    return ListView.builder(itemBuilder: (context, index) {
      return index < _todoItems.length
          ? _buildTodoItem(_todoItems[index], index)
          : null;
    });
  }

  Widget _buildTodoItem(String todoText, int index) {
    return  ListTile(
        title:  Text(todoText),
        onTap: () => _promptRemoveTodoItem(index)
    );
  }

  void _pushAddTodoScreen() {
    // Push this page onto the stack
    Navigator.of(context).push(
        // MaterialPageRoute will automatically animate the screen entry, as well
        // as adding a back button to close it
         MaterialPageRoute(builder: (context) {
      return  Scaffold(
          appBar:  AppBar(title:  Text('Add a  task')),
          body:  TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addTodoItem(val);
              Navigator.pop(context); // Close the add todo screen
            },
            decoration:  InputDecoration(
                hintText: 'Enter something to do...',
                contentPadding: const EdgeInsets.all(16.0)),
          ));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(title:  Text('Todo List')),
      body: _buildTodoList(),
      floatingActionButton:  FloatingActionButton(
          onPressed: _pushAddTodoScreen,
          tooltip: 'Add task',
          child:  Icon(Icons.add)),
    );
  }
}
