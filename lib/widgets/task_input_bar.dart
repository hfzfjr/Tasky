import 'package:flutter/material.dart';

import '../utils/date_formatter.dart';

class TaskInputBar extends StatelessWidget {
  final TextEditingController controller;
  final DateTime selectedDate;
  final VoidCallback onPickDate;
  final VoidCallback onSubmit;

  const TaskInputBar({
    super.key,
    required this.controller,
    required this.selectedDate,
    required this.onPickDate,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final isCustomDate = !isTodayDate(selectedDate);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isCustomDate)
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 6),
              child: Text(
                'Tanggal dipilih: ${formatTaskDate(selectedDate)}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                ),
              ),
            ),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => onSubmit(),
                          decoration: const InputDecoration(
                            hintText: 'Tulis tugas baru...',
                            hintStyle: TextStyle(color: Color(0xFF94A3B8)),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: onPickDate,
                        tooltip: 'Pilih tanggal',
                        icon: Icon(
                          Icons.calendar_today_rounded,
                          size: 20,
                          color: isCustomDate
                              ? primaryColor
                              : const Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(width: 4),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Tooltip(
                message: 'Tambah tugas',
                child: Material(
                  color: primaryColor,
                  shape: const CircleBorder(),
                  elevation: 3,
                  shadowColor: primaryColor.withValues(alpha: 0.4),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: onSubmit,
                    child: const SizedBox(
                      width: 52,
                      height: 52,
                      child: Icon(
                        Icons.add_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
