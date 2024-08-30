import 'dart:io';

import 'package:flight_management_system/core/utils/color_constants.dart';
import 'package:flight_management_system/presentation/widgets/payment_card_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:html' as html;
import 'package:pdf/pdf.dart';
import '../../core/utils/custom_alert.dart';
import '../../core/utils/screen_size.dart';
import '../../core/utils/string_constants.dart';
import 'package:pdf/widgets.dart' as pw;

class FlightDetailsCard extends StatelessWidget {
  final Map<String, dynamic> flight;

  const FlightDetailsCard({super.key, required this.flight});

  @override
  Widget build(BuildContext context) {
    final screenSizeMediaQuery = ScreenSizeMediaQuery(context: context);
    final customAlert = CustomAlertBox();

    Future<void> generatePdf() async {
      final pdf = pw.Document();
      final svgLogo =
          await rootBundle.loadString('assets/svg_files/airplane.svg');
      final barcodeSvg =
          await rootBundle.loadString('assets/svg_files/barcode.svg');

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Stack(
              children: [
                pw.Positioned.fill(
                  child: pw.Center(
                    child: pw.Opacity(
                      opacity: 0.2,
                      child: pw.SvgImage(
                        svg: svgLogo,
                        height: 200,
                        width: 200,
                        fit: pw.BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                pw.Center(
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(20),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.blue, width: 2),
                      borderRadius: pw.BorderRadius.circular(15),
                    ),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Container(
                          color: PdfColors.blue,
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                'Dummy Airlines',
                                style: pw.TextStyle(
                                  fontSize: 22,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.white,
                                ),
                              ),
                              pw.Text(
                                'Boarding Pass',
                                style: pw.TextStyle(
                                  fontSize: 18,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        pw.SizedBox(height: 20),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(16.0),
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text('Boarding Pass',
                                  style: pw.TextStyle(
                                      fontSize: 40,
                                      fontWeight: pw.FontWeight.bold)),
                              pw.SizedBox(height: 20),
                              pw.Text('Passenger Name: John Davide',
                                  style: const pw.TextStyle(fontSize: 18)),
                              pw.Text('Flight: New York to London',
                                  style: const pw.TextStyle(fontSize: 18)),
                              pw.Text('Date: 25 July',
                                  style: const pw.TextStyle(fontSize: 18)),
                              pw.Text('Departure Time: 10:30 AM',
                                  style: const pw.TextStyle(fontSize: 18)),
                              pw.Text('Duration: 7h',
                                  style: const pw.TextStyle(fontSize: 18)),
                              pw.Text('Stops: 1',
                                  style: const pw.TextStyle(fontSize: 18)),
                              pw.SizedBox(height: 20),
                              pw.Text('Thank you for booking with us!',
                                  style: pw.TextStyle(
                                      fontSize: 20,
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColors.green)),
                              pw.SizedBox(height: 20),
                              pw.SvgImage(
                                  svg: barcodeSvg, height: 50, width: 200),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );

      // Convert the PDF document to bytes
      final Uint8List pdfBytes = await pdf.save();

      // Create a Blob from the bytes
      final blob = html.Blob([pdfBytes], 'application/pdf');

      // Create a URL for the Blob and open it in a new tab
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.window.open(url, '_blank');

      // Revoke the URL to free up resources
      html.Url.revokeObjectUrl(url);
    }

    return Card(
      color: ColorConstants.appBarColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Flight details (Left Side)
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Flight 1 details
                  buildFlightInfo(
                    context,
                    time: flight['time'] ?? 'N/A',
                    date: flight['date'] ?? 'N/A',
                    duration: flight['duration'] ?? 'N/A',
                    stops: flight['stops'] ?? 'N/A',
                    stopTime: flight['stopTime'] ?? 'N/A',
                    stopDate: flight['stopDate'] ?? 'N/A',
                    departCity: flight['departCity'] ?? 'N/A',
                    destCity: flight['destCity'] ?? 'N/A',
                  ),
                  const Divider(thickness: 2),

                  // Flight 2 details
                  buildFlightInfo(
                    context,
                    time: '06:00',
                    date: 'KHI - 5 Oct',
                    duration: '10h',
                    stops: '1 stop',
                    stopTime: '13:00',
                    stopDate: 'VCE - 5 Oct',
                    departCity: flight['departCity'] ?? 'N/A',
                    destCity: flight['destCity'] ?? 'N/A',
                  ),
                ],
              ),
            ),
            // Price and details (Right Side)
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Promotional fare: personal item, cabin bag, checked bag',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: ColorConstants.whiteColor, fontSize: 12),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${flight['price']}€  left at this price',
                    style: const TextStyle(
                        color: ColorConstants.whiteColor, fontSize: 12),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '€${flight['price']}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.whiteColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      fixedSize: Size(
                        screenSizeMediaQuery.width * 0.1,
                        screenSizeMediaQuery.height * 0.05,
                      ),
                      backgroundColor: ColorConstants.darkOrangeColor,
                      textStyle: TextStyle(
                        fontSize: screenSizeMediaQuery.height * 0.025,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return PaymentCardDialog(
                              onCancel: () {
                                Navigator.of(context).pop();
                              },
                              onConfirm: () async {
                                await generatePdf();
                              },
                            );
                          });
                    },
                    child: const Text(
                      StringConstants.bookFlight,
                      style: TextStyle(
                        fontSize: 15,
                        color: ColorConstants.blackColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFlightInfo(
    BuildContext context, {
    required var time,
    required var date,
    required var duration,
    required var stops,
    required var stopTime,
    required var stopDate,
    required var departCity,
    required var destCity,
  }) {
    return Row(
      children: [
        const Icon(Icons.flight, color: ColorConstants.darkOrangeColor),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: ColorConstants.whiteColor),
            ),
            Text(
              date,
              style: const TextStyle(
                  fontSize: 12, color: ColorConstants.whiteColor),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text("$stops stop",
                    style: TextStyle(
                        fontSize: 12, color: ColorConstants.whiteColor)),
                const SizedBox(width: 10),
                Container(
                  height: 1,
                  width: 50,
                  color: ColorConstants.whiteColor,
                ),
                const SizedBox(width: 10),
                Text("$duration",
                    style: TextStyle(
                        fontSize: 12, color: ColorConstants.whiteColor)),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              stopTime,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: ColorConstants.whiteColor),
            ),
            Text(
              stopDate,
              style: TextStyle(fontSize: 12, color: ColorConstants.whiteColor),
            ),
          ],
        ),
      ],
    );
  }
}

Future<dynamic> buildShowDialog(BuildContext context, String alertHeader,
    String alertTitle, String alertSubTitle, String btnText, Function() onTap) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(alertHeader),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(alertTitle),
              Text(alertSubTitle),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(btnText),
            onPressed: onTap,
          ),
        ],
      );
    },
  );
}
