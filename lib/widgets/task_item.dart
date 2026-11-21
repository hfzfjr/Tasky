import 'package:flutter/material.dart';

import '../models/task.dart';
import '../utils/date_formatter.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TaskItem({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final dateLabel = formatTaskDate(task.date);
    final isToday = isTodayDate(task.date);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onToggle,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 8, 14),
            child: Row(
              children: [
                _buildCheckbox(primaryColor),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          decoration: task.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          decorationColor: const Color(0xFF94A3B8),
                          color: task.isDone
                              ? const Color(0xFF94A3B8)
                              : const Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 6),
                      _buildDateBadge(
                        label: dateLabel,
                        isToday: isToday,
                        primaryColor: primaryColor,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onDelete,
                  tooltip: 'Hapus tugas',
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: Color(0xFF94A3B8),
                    size: 22,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckbox(Color primaryColor) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: task.isDone ? primaryColor : Colors.transparent,
        border: Border.all(
          color: task.isDone ? primaryColor : const Color(0xFF94A3B8),
          width: 2,
        ),
      ),
      child: task.isDone
          ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
          : null,
    );
  }

  Widget _buildDateBadge({
    required String label,
    required bool isToday,
    required Color primaryColor,
  }) {
    final backgroundColor = isToday && !task.isDone
        ? primaryColor.withValues(alpha: 0.1)
        : const Color(0xFFF1F5F9);
    final textColor = isToday && !task.isDone
        ? primaryColor
        : const Color(0xFF64748B);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}
