// main.dart 
import 'package:flutter/material.dart'; 
 
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
      'title': 'Write unit tests', 
      'description': 'Cover TaskCard widget and interactive behavior.', 
      'priority': 'High', 
      'dueDate': 'Today',
      'assignee': 'Alice',
      'tags': 'Testing,Backend',
      'isImportant': 'true',
    }, 
    { 
      'title': 'Refactor auth', 
      'description': 'Move logic into a reusable AuthService and clean up UI.', 
      'priority': 'Low', 
      'dueDate': 'Tomorrow',
      'assignee': 'Bob',
      'tags': 'Refactor',
      'isImportant': 'false',
    }, 
    { 
      'title': 'Design review', 
      'description': 'Prepare slides for Friday review with product.', 
      'priority': 'High', 
      'dueDate': 'Friday',
      'assignee': 'Unassigned',
      'tags': 'Design,Slides',
      'isImportant': 'true',
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
    showModalBottomSheet( 
      context: context, 
      isScrollControlled: true, 
      builder: (_) { 
        return Padding( 
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom), 
          child: Padding( 
            padding: const EdgeInsets.all(16), 
            child: Column( 
              mainAxisSize: MainAxisSize.min, 
              children: [ 
                Text('Add Task', style: Theme.of(context).textTheme.titleLarge), 
                const SizedBox(height: 12), 
                const TextField(decoration: InputDecoration(labelText: 'Title')), 
                const SizedBox(height: 8), 
                const TextField(maxLines: 2, decoration: InputDecoration(labelText: 
'Description')), 
                const SizedBox(height: 12), 
                Row( 
                  children: [ 
                    Expanded(child: ElevatedButton(onPressed: () => 
Navigator.pop(context), child: const Text('Create (UI only)'))), 
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
 
/// --------------------------- 
/// Widget: TaskCard (Stateless) 
/// --------------------------- 
/// You can extract this to its own file: widgets/task_card.dart 
class TaskCard extends StatelessWidget { 
  final String title; 
  final String description; 
  final String priority; 
  final String dueDate;
  final String assignee;
  final String tags;
  final String isImportant;

  const TaskCard({ 
    super.key, 
    required this.title, 
    required this.description, 
    required this.priority, 
    required this.dueDate,
    required this.assignee,
    required this.tags,
    required this.isImportant,
  }); 
 
  @override 
  Widget build(BuildContext context) { 
    final Color priorityColor = priority.toLowerCase() == 'high' ? const Color.fromARGB(255, 180, 80, 122) : const Color.fromARGB(255, 53, 148, 81);
    final List<String> tagList = tags.isNotEmpty ? tags.split(',') : [];
    final bool important = isImportant.toLowerCase() == 'true';
    return Card( 
      elevation: important ? 6 : 2, 
      child: Padding( 
        padding: const EdgeInsets.all(16), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (important)
                  const Icon(Icons.spa, color: Color.fromARGB(255, 109, 88, 110), size: 22), // Lotus icon, pastel purple
                const Spacer(),
                _PriorityBadge(priority: priority),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                IconLabel(
                  icon: Icons.access_time,
                  label: dueDate,
                  color: priorityColor,
                ),
                const SizedBox(width: 16),
                IconLabel(
                  icon: Icons.person,
                  label: assignee,
                  color: priorityColor,
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (tagList.isNotEmpty)
              Wrap(
                spacing: 6,
                children: tagList.map((tag) => Chip(
                  label: Text(tag, style: const TextStyle(fontSize: 12)),
                  backgroundColor: priorityColor.withOpacity(0.08),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                )).toList(),
              ),
            if (tagList.isNotEmpty) const SizedBox(height: 8),
            Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 15),
            ),
          ],
        ),
      ),
    ); 
  } 
} 
 
/// Small private sub-widget (extractable) 
class _PriorityBadge extends StatelessWidget { 
  final String priority; 
  const _PriorityBadge({super.key, required this.priority}); 
 
  Color get _color => priority.toLowerCase() == 'high'
      ? const Color.fromARGB(255, 112, 55, 88) // Darker orange
      : priority.toLowerCase() == 'low'
          ? const Color(0xFF00695C) // Darker teal
          : const Color(0xFF4527A0); // Darker purple

  @override 
  Widget build(BuildContext context) { 
    return Chip(
      label: Text(
        priority,
        style: TextStyle(
          color: _color,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
      backgroundColor: _color.withOpacity(0.18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      side: BorderSide.none,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
    );
  } 
} 
 
/// --------------------------- 
/// Reusable IconLabel widget 
/// --------------------------- 
class IconLabel extends StatelessWidget { 
  final IconData icon; 
  final String label; 
  final Color? color; // Optional color parameter
  const IconLabel({super.key, required this.icon, required this.label, this.color}); 
 
  @override 
  Widget build(BuildContext context) { 
    return Row( 
      children: [ 
        Icon(icon, size: 18, color: color), 
        const SizedBox(width: 6), 
        Text(
          label, 
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: color,
            fontSize: 14,
          ),
        ), 
      ], 
    ); 
  } 
}