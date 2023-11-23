import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

// Asumiendo que el componente AdminPageTemplate está definido en otra parte de tu base de código
import '../components/admin_page_template.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  Future<void> _generateExcel(BuildContext context) async {
    // Create a new Excel document
    var excel = Excel.createExcel();

    // Create a new sheet in the Excel document
    var sheet = excel['Voting Points'];

    // Add data to the Excel sheet

    sheet.appendRow(['Name', 'Votes']);
    sheet.appendRow(['Candidate 1', '100']);
    sheet.appendRow(['Candidate 2', '200']);
    sheet.appendRow(['Candidate 3', '150']);

    // Get the system's document directory
    String excelFilePath = '';
    try {
      // final appDocDir = await getApplicationDocumentsDirectory();
      //     final excelFile = File('${appDocDir.path}/report.xlsx');

      // Save the Excel file
      List<int>? fileBytes = excel.encode();
      // excelFile.writeAsBytesSync(fileBytes!);
      // excelFilePath = excelFile.path;

      // Show a success message
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content:
      //     Text('Excel file successfully generated at ${excelFile.path}.'),
      //   ),
      // );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save the Excel file: $e'),
        ),
      );
      return;
    }

    // Share the Excel file
    // Share.shareFiles([excelFilePath], text: 'Your report is ready!');
  }

  @override
  Widget build(BuildContext context) {
    return AdminPageTemplate(
      pageTitle: "Reports",
      pageSubtitle:
          "Access the results and statistics from the last voting session.",
      content: _buildReportView(context),
    );
  }

  Widget _buildReportView(BuildContext context) {
    return Row(
      children: [
        // Left half of the screen
        Expanded(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 16.0,
                    ),
                    textStyle: const TextStyle(fontSize: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () => _generateExcel(context),
                  child: const Text('Generate Report'),
                ),
                const SizedBox(height: 20),
                const Text(
                  'When generating the report, an Excel will be downloaded to your device.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Right half of the screen
        Expanded(
          child: Container(
            color: Colors.grey[300],
            child: const Center(
              child: Text(
                'Additional content here',
                style: TextStyle(fontSize: 24, color: Colors.black54),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
