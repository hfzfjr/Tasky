import 'package:flutter/material.dart';

import '../models/task.dart';
import '../widgets/progress_card.dart';
import '../widgets/task_input_bar.dart';
import '../widgets/task_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Task> _tasks = [];
  final TextEditingController _taskController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  int get _completedCount => _tasks.where((task) => task.isDone).length;

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  void _addTask() {
    final title = _taskController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Judul tugas tidak boleh kosong.'),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
          ),
        );
      return;
    }

    final newTask = Task(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      date: _selectedDate,
    );

    setState(() {
      _tasks.insert(0, newTask);
      _selectedDate = DateTime.now();
    });

    _taskController.clear();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 2),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _toggleTask(String id) {
    setState(() {
      final index = _tasks.indexWhere((task) => task.id == id);
      if (index != -1) {
        _tasks[index].isDone = !_tasks[index].isDone;
      }
    });
  }

  void _deleteTask(String id) {
    setState(() {
      _tasks.removeWhere((task) => task.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            if (_tasks.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
                child: ProgressCard(
                  completedCount: _completedCount,
                  totalCount: _tasks.length,
                ),
              ),
            ],
            Expanded(
              child: _tasks.isEmpty ? _buildEmptyState() : _buildTaskList(),
            ),
            TaskInputBar(
              controller: _taskController,
              selectedDate: _selectedDate,
              onPickDate: _pickDate,
              onSubmit: _addTask,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tasky',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 2),
          Text(
            'Catatan Harian',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color: primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.assignment_turned_in_outlined,
                size: 38,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Belum ada tugas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Tambahkan catatan harianmu di bawah',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskList() {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
      itemCount: _tasks.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final task = _tasks[index];
        return TaskItem(
          key: ValueKey(task.id),
          task: task,
          onToggle: () => _toggleTask(task.id),
          onDelete: () => _deleteTask(task.id),
        );
      },
    );
  }
}
