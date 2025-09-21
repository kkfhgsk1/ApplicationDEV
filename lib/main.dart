// main.dart 
import 'package:flutter/material.dart';
import 'widgets/task_card.dart';
import 'widgets/icon_label.dart';
 
void main() => runApp(const TaskApp()); 
 
class TaskApp extends StatelessWidget { 
  const TaskApp({super.key}); 
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      title: 'Widget Fundamentals Demo', 
      theme: ThemeData( 
        useMaterial3: true, 
        colorScheme: ColorScheme.light( 
          primary: Color.fromARGB(255, 57, 46, 61),      // Dark grey
          secondary: Color.fromARGB(255, 89, 80, 95),    // Medium grey
          background: Color.fromARGB(255, 241, 238, 243),   // Light grey
          surface: Color(0xFFE0E0E0),      // Lighter grey
          error: Color(0xFFBDBDBD),        // Grey for error
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onBackground: Colors.black87,
          onSurface: Colors.black87,
          onError: Colors.white,
        ), 
        scaffoldBackgroundColor: Color(0xFFF5F5F5), // Light grey
        cardColor: Color(0xFFE0E0E0), // Lighter grey for cards
        chipTheme: ChipThemeData( 
          backgroundColor: Color(0xFFBDBDBD), // Medium-light grey
          labelStyle: const TextStyle(color: Colors.black87),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF424242), // Dark grey
          foregroundColor: Color.fromARGB(255, 231, 224, 233),
        ),
      ), 
      home: const TaskListPage(), 
    ); 
  } 
} 
 
class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  static final _demoTasks = [
    {
      'title': 'Code review for PR #42',
      'description': 'Review the new authentication flow and leave comments.',
      'priority': 'High',
      'dueDate': 'Today',
      'assignee': 'Ivonne',
      'tags': 'Review,Auth',
      'isImportant': 'true',
    },
    {
      'title': 'Write project documentation',
      'description': 'Update README and add API usage examples.',
      'priority': 'Medium',
      'dueDate': 'Tomorrow',
      'assignee': 'Jurmader',
      'tags': 'Docs,API',
      'isImportant': 'false',
    },
    {
      'title': 'Team standup',
      'description': 'Daily sync with the team to discuss progress and blockers.',
      'priority': 'Low',
      'dueDate': 'Everyday',
      'assignee': 'Team PRX',
      'tags': 'Meeting,Daily',
      'isImportant': 'false',
    },
    {
      'title': 'Deploy to staging',
      'description': 'Push the latest build to the staging environment for QA.',
      'priority': 'High',
      'dueDate': 'Friday',
      'assignee': 'Hweilover9000',
      'tags': 'Deploy,QA',
      'isImportant': 'true',
    },
    {
      'title': 'Update dependencies',
      'description': 'Run pub upgrade and test for breaking changes.',
      'priority': 'Medium',
      'dueDate': 'Next week',
      'assignee': 'liadan',
      'tags': 'Maintenance',
      'isImportant': 'false',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: _demoTasks.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final t = _demoTasks[i];
          return TaskCard(
            title: t['title']!,
            description: t['description']!,
            priority: t['priority']!,
            dueDate: t['dueDate']!,
            assignee: t['assignee']!,
            tags: t['tags']!,
            isImportant: t['isImportant']!,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddModal(context),
        child: const Icon(Icons.add),
      ),
    );
  }
 
  void _openAddModal(BuildContext context) {
    final titleController = TextEditingController(text: 'Weekly sync notes');
    final descController = TextEditingController(text: 'Discuss project updates and blockers.');
    String selectedPriority = 'Medium';
    final priorities = ['High', 'Medium', 'Low'];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 28,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: StatefulBuilder(
            builder: (context, setState) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create New Task',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 22,
                      ),
                ),
                const SizedBox(height: 18),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: descController,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text('Priority:'),
                    const SizedBox(width: 12),
                    DropdownButton<String>(
                      value: selectedPriority,
                      items: priorities
                          .map((p) => DropdownMenuItem(
                                value: p,
                                child: Text(p),
                              ))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => selectedPriority = val);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('(UI-only) Task created')),
                          );
                        },
                        child: const Text('Create (UI only)'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  } 
} 
 
// ...existing code...