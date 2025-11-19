// // lib/features/excell/pages/manager/excell_cubt.dart
// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:sindbad_management_app/features/excell/pages/manager/excell_states.dart';

// /// Excell cubit (manages Excel-like page state).
// ///
// /// States:
// /// - ExcellInitial: nothing loaded yet
// /// - ExcellLoading: async operation in progress
// /// - ExcellLoaded: contains the 2D rows data and optional selected cell
// /// - ExcellError: error message
// ///
// /// This cubit supports loading from a CSV string (simple, comma-separated),
// /// editing cells, adding/removing rows, selecting a cell, exporting to CSV,
// /// and clearing the sheet.
// ///
// /// Note: CSV parsing here is intentionally simple (naive split on commas).
// /// Replace with a robust CSV/Excel parser if required.

// class ExcellCubit extends Cubit<ExcellState> {
//   ExcellCubit() : super(const ExcellInitial());
//   List dropdownlstOptions=[];
//   List dropdownlstOptions2=[];

//   // Load from a CSV string (synchronous).
//   // CSV is parsed naively by lines and splitting on commas.
//   Future<void> loadFromCsv(String csv) async {
//     emit(const ExcellLoading());
//     try {
//       // simple parsing
//       final lines = csv.split(RegExp(r'\r?\n')).where((l) => l.isNotEmpty);
//       final rows = lines
//           .map((line) => line.split(',').map((cell) => cell.trim()).toList())
//           .toList();
//       emit(ExcellLoaded(rows: rows));
//     } catch (e) {
//       emit(ExcellError('Failed to parse CSV: $e'));
//     }
//   }

//   // Load from an already constructed 2D list.
//   Future<void> loadFromRows(List<List<String>> rows) async {
//     emit(const ExcellLoading());
//     try {
//       final deep = rows.map((r) => List<String>.from(r)).toList();
//       emit(ExcellLoaded(rows: deep));
//     } catch (e) {
//       emit(ExcellError('Failed to load rows: $e'));
//     }
//   }

//   // Update a single cell.
//   void updateCell({
//     required int row,
//     required int column,
//     required String value,
//   }) {
//     final s = state;
//     if (s is! ExcellLoaded) {
//       emit(const ExcellError('No sheet loaded'));
//       return;
//     }
//     if (row < 0 || column < 0 || row >= s.rows.length) {
//       emit(const ExcellError('Cell out of range'));
//       return;
//     }
//     final newRows = s.rows.map((r) => List<String>.from(r)).toList();
//     // ensure the row has enough columns
//     while (newRows[row].length <= column) {
//       newRows[row].add('');
//     }
//     newRows[row][column] = value;
//     emit(s.copyWith(rows: newRows, selectedRow: row, selectedColumn: column));
//   }

//   // Select a cell by coordinates.
//   void selectCell(int row, int column) {
//     final s = state;
//     if (s is! ExcellLoaded) return;
//     if (row < 0 || column < 0 || row >= s.rows.length) return;
//     emit(s.copyWith(selectedRow: row, selectedColumn: column));
//   }

//   // Add a row. If `values` is null creates a blank row matching existing column count.
//   void addRow({List<String>? values}) {
//     final s = state;
//     if (s is! ExcellLoaded) {
//       emit(const ExcellError('No sheet loaded'));
//       return;
//     }
//     final newRows = s.rows.map((r) => List<String>.from(r)).toList();
//     if (values != null) {
//       newRows.add(List<String>.from(values));
//     } else {
//       final cols = newRows.isNotEmpty ? newRows[0].length : 1;
//       newRows.add(List<String>.filled(cols, ''));
//     }
//     emit(s.copyWith(rows: newRows));
//   }

//   // Remove a row by index.
//   void removeRow(int index) {
//     final s = state;
//     if (s is! ExcellLoaded) {
//       emit(const ExcellError('No sheet loaded'));
//       return;
//     }
//     if (index < 0 || index >= s.rows.length) {
//       emit(const ExcellError('Row index out of range'));
//       return;
//     }
//     final newRows = s.rows.map((r) => List<String>.from(r)).toList();
//     newRows.removeAt(index);
//     emit(s.copyWith(rows: newRows));
//   }

//   // Export the current sheet to a CSV string.
//   // Cells containing commas or newlines are quoted.
//   String? exportToCsv() {
//     final s = state;
//     if (s is! ExcellLoaded) return null;
//     final buffer = StringBuffer();
//     for (var r = 0; r < s.rows.length; r++) {
//       final row = s.rows[r];
//       for (var c = 0; c < row.length; c++) {
//         var cell = row[c];
//         if (cell.contains(',') ||
//             cell.contains('\n') ||
//             cell.contains('\r') ||
//             cell.contains('"')) {
//           // escape quotes
//           final escaped = cell.replaceAll('"', '""');
//           buffer.write('"$escaped"');
//         } else {
//           buffer.write(cell);
//         }
//         if (c < row.length - 1) buffer.write(',');
//       }
//       if (r < s.rows.length - 1) buffer.writeln();
//     }
//     return buffer.toString();
//   }

//   // Clear the sheet back to initial state.
//   void clear() {
//     emit(const ExcellInitial());
//   }
// }
