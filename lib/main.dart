import 'package:flutter/material.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager App',
      home: TaskListScreen(),
    );
  }
}
class Task {
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}
class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  // List to store tasks
  List<Task> _tasks = [];
  // Controller for the text input
  TextEditingController _textController = TextEditingController();

  // Dispose the controller when not needed
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  // Method to add a task
  void _addTask() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        _tasks.add(Task(name: _textController.text));
        _textController.clear();
      });
    }
  }

  // Method to toggle task completion
  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
  }

  // Method to delete a task
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  // Build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager App'),
      ),
      body: Column(
        children: [
          // Input field and Add button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Expanded to make the text field take available space
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      labelText: 'Enter task name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                // Add button
                ElevatedButton(
                  onPressed: _addTask,
                  child: Text('Add'),
                ),
              ],
            ),
          ),
          // Task list
          Expanded(
            child: _tasks.isEmpty
                ? Center(child: Text('No tasks added yet.'))
                : ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      return _buildTaskItem(index);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // Widget for each task item
  Widget _buildTaskItem(int index) {
    final task = _tasks[index];
    return ListTile(
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (value) {
          _toggleTaskCompletion(index);
        },
      ),
      title: Text(
        task.name,
        style: TextStyle(
          decoration:
              task.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          _deleteTask(index);
        },
      ),
    );
  }
}
