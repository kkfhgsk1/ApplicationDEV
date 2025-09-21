import 'package:flutter/material.dart';
import 'icon_label.dart';

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
    final Color priorityColor = priority.toLowerCase() == 'high' ? const Color(0xFFD84315) :
      priority.toLowerCase() == 'low' ? const Color(0xFF00695C) : const Color(0xFF4527A0);
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
                  const Icon(Icons.spa, color: Color(0xFFB39DDB), size: 22),
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

class _PriorityBadge extends StatelessWidget {
  final String priority;
  const _PriorityBadge({super.key, required this.priority});

  Color get _color => priority.toLowerCase() == 'high'
      ? const Color(0xFFD84315)
      : priority.toLowerCase() == 'low'
          ? const Color(0xFF00695C)
          : const Color(0xFF4527A0);

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
