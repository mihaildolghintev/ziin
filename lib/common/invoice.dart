import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:ziin/common/date_string.dart';
import 'package:ziin/models/write_off.model.dart';
import 'package:flutter/services.dart' show rootBundle;

void createPdf(WriteOff writeoff) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      theme: pw.ThemeData.withFont(
        base: pw.Font.ttf(await rootBundle.load('fonts/Montserrat-Medium.ttf')),
        bold: pw.Font.ttf(await rootBundle.load('fonts/Montserrat-Bold.ttf')),
      ),
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return [
          pw.Column(
            children: [
              pw.Container(
                decoration: pw.BoxDecoration(
                  color: PdfColor.fromHex('#FFBD12'),
                  borderRadius: 10.0,
                ),
                padding: const pw.EdgeInsets.all(16.0),
                child: pw.Column(children: [
                  pw.Row(children: [
                    pw.Text(
                      'Дата:',
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 14.0,
                      ),
                    ),
                    pw.SizedBox(width: 12.0),
                    pw.Text(
                      createDateString(writeoff.createdAt),
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 14.0,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ]),
                  pw.Row(children: [
                    pw.Text(
                      'Создатель:',
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontSize: 14.0,
                      ),
                    ),
                    pw.SizedBox(width: 12.0),
                    pw.Text(
                      writeoff.creator,
                      style: pw.TextStyle(
                        color: PdfColors.black,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ]),
                ]),
              ),
              pw.SizedBox(height: 24.0),
              pw.Container(
                padding: const pw.EdgeInsets.all(8.0),
                width: double.infinity,
                decoration: pw.BoxDecoration(
                  color: PdfColor.fromHex('#FFBD12'),
                  borderRadius: 10.0,
                ),
                child: pw.Text(
                  'Общее колличество:  ' + writeoff.items.length.toString(),
                  style: pw.TextStyle(
                    fontSize: 24.0,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              ...writeoff.items
                  .map(
                    (item) => pw.Container(
                      margin: const pw.EdgeInsets.all(4.0),
                      padding: const pw.EdgeInsets.all(4.0),
                      decoration: pw.BoxDecoration(
                        border: pw.BoxBorder(
                          top: true,
                          bottom: true,
                          left: true,
                          right: true,
                          color: PdfColors.black,
                        ),
                        borderRadius: 10.0,
                      ),
                      child: pw.Row(
                        children: [
                          pw.Container(
                              width: 140.0,
                              padding: const pw.EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 4.0,
                              ),
                              child: pw.Column(
                                children: [
                                  ...item.product.barcodes
                                      .map((barcode) => pw.Text(
                                            barcode,
                                            style: pw.TextStyle(
                                              fontSize: 12.0,
                                            ),
                                          ))
                                      .toList()
                                ],
                              )),
                          pw.Expanded(
                              child: pw.Text(
                            '${item.product.title} PLU: ${item.product.plu} CASH: ${item.product.cash}',
                            style: pw.TextStyle(
                              fontSize: 12.0,
                            ),
                          )),
                          pw.Container(
                            padding: const pw.EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            child: pw.Text(
                              item.quanity.toString(),
                              style: pw.TextStyle(
                                fontSize: 14.0,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList()
            ],
          )
        ];
      },
    ),
  );

  final output = await getApplicationDocumentsDirectory();
  final file = File('${output.path}/invoice_${writeoff.id}.pdf');
  if (await Permission.storage.request().isGranted) {
    await file.writeAsBytes(pdf.save());
  }
  Share.shareFiles(['${output.path}/invoice_${writeoff.id}.pdf']);
}
