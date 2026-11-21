import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tasky/main.dart';
import 'package:tasky/utils/date_formatter.dart';

void main() {
  group('formatTaskDate', () {
    final now = DateTime(2026, 11, 22);

    test('mengembalikan Hari ini, Kemarin, Besok, dan DD-MM-YYYY', () {
      expect(formatTaskDate(DateTime(2026, 11, 22), now: now), 'Hari ini');
      expect(formatTaskDate(DateTime(2026, 11, 21), now: now), 'Kemarin');
      expect(formatTaskDate(DateTime(2026, 11, 23), now: now), 'Besok');
      expect(formatTaskDate(DateTime(2026, 11, 18), now: now), '18-11-2026');
    });
  });

  testWidgets('Menampilkan empty state saat belum ada tugas', (tester) async {
    await tester.pumpWidget(const TaskyApp());

    expect(find.text('Tasky'), findsOneWidget);
    expect(find.text('Catatan Harian'), findsOneWidget);
    expect(find.text('Belum ada tugas'), findsOneWidget);
  });

  testWidgets('Menolak input kosong dan menampilkan SnackBar', (tester) async {
    await tester.pumpWidget(const TaskyApp());

    await tester.tap(find.byTooltip('Tambah tugas'));
    await tester.pump();

    expect(find.text('Judul tugas tidak boleh kosong.'), findsOneWidget);
    expect(find.text('Belum ada tugas'), findsOneWidget);
  });

  testWidgets('Menambah, mencentang selesai, dan menghapus tugas', (
    tester,
  ) async {
    await tester.pumpWidget(const TaskyApp());

    // Tambah tugas baru
    await tester.enterText(find.byType(TextField), 'Belajar Flutter');
    await tester.tap(find.byTooltip('Tambah tugas'));
    await tester.pump();

    expect(find.text('Belajar Flutter'), findsOneWidget);
    expect(find.text('Hari ini'), findsOneWidget);
    expect(find.text('0 dari 1 selesai'), findsOneWidget);
    expect(find.text('0%'), findsOneWidget);

    // Tandai selesai dengan mengetuk kartu tugas
    await tester.tap(find.text('Belajar Flutter'));
    await tester.pump();

    expect(find.text('1 dari 1 selesai'), findsOneWidget);
    expect(find.text('100%'), findsOneWidget);

    // Hapus tugas
    await tester.tap(find.byTooltip('Hapus tugas'));
    await tester.pump();

    expect(find.text('Belajar Flutter'), findsNothing);
    expect(find.text('Belum ada tugas'), findsOneWidget);
  });
}
