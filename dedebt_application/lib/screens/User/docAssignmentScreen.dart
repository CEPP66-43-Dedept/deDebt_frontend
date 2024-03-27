import 'dart:async';
import 'dart:typed_data';
import 'package:dedebt_application/models/fillAssignModel.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class DocAssignScreen extends StatefulWidget {
  final FillAssignment lstString;
  const DocAssignScreen({Key? key, required this.lstString}) : super(key: key);

  @override
  State<DocAssignScreen> createState() => _DocAssignScreenState();
}

class _DocAssignScreenState extends State<DocAssignScreen> {
  late final String _imageUrl =
      'https://media.discordapp.net/attachments/1027767973286510602/1222528540793114644/K_Xpress_Cash_AutoPayment_TH_page-0001_1.jpg?ex=66168b6d&is=6604166d&hm=4697848aa76bbfad2591702b31a9c3176550b16e26c0314954fc2965c8298854&=&format=webp&width=752&height=1064';
  late Uint8List _backgroundImageBytes = Uint8List(0);

  @override
  void initState() {
    super.initState();
    _downloadBackgroundImage();
  }

  Future<void> _downloadBackgroundImage() async {
    final response = await http.get(Uri.parse(_imageUrl));
    if (response.statusCode == 200) {
      setState(() {
        _backgroundImageBytes = response.bodyBytes;
      });
    } else {
      throw Exception('Failed to load background image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PdfPreview(
          build: (format) => _generatePdf(PdfPageFormat.a4),
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();
    final imageProvider = MemoryImage(_backgroundImageBytes);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat(format.width, format.height),
        build: (context) {
          return pw.Container(
            width: format.width,
            height: format.height,
            child: pw.Stack(
              children: [
                // พื้นหลัง
                pw.Image(
                  pw.MemoryImage(_backgroundImageBytes),
                  fit: pw.BoxFit.cover,
                  width: format.width,
                  height: format.height,
                ),

                pw.Positioned(
                  left: 137,
                  top: 113,
                  child: pw.Text(
                    widget.lstString.data.isNotEmpty
                        ? widget.lstString.data[4]
                        : '',
                    style: pw.TextStyle(fontSize: 12, color: PdfColors.black),
                  ),
                ),
                pw.Positioned(
                  left: 400,
                  top: 113,
                  child: pw.Text(
                    widget.lstString.data.isNotEmpty
                        ? widget.lstString.data[5]
                        : '',
                    style: pw.TextStyle(fontSize: 12, color: PdfColors.black),
                  ),
                ),
                // ข้อความ
                pw.Positioned(
                  left: 125,
                  top: 227,
                  child: pw.Text(
                    widget.lstString.data.isNotEmpty
                        ? widget.lstString.data[0]
                        : '',
                    style: pw.TextStyle(fontSize: 12, color: PdfColors.black),
                  ),
                ),
                pw.Positioned(
                  left: 330,
                  top: 227,
                  child: pw.Text(
                    widget.lstString.data.isNotEmpty
                        ? widget.lstString.data[1]
                        : '',
                    style: pw.TextStyle(fontSize: 12, color: PdfColors.black),
                  ),
                ),
                pw.Positioned(
                  left: 120,
                  top: 270,
                  child: pw.Text(
                    widget.lstString.data.isNotEmpty
                        ? widget.lstString.data[4]
                        : '',
                    style: pw.TextStyle(fontSize: 12, color: PdfColors.black),
                  ),
                ),
                pw.Positioned(
                  left: 120,
                  top: 293,
                  child: pw.Text(
                    widget.lstString.data.isNotEmpty
                        ? widget.lstString.data[2]
                        : '',
                    style: pw.TextStyle(fontSize: 12, color: PdfColors.black),
                  ),
                ),
                pw.Positioned(
                  left: 430,
                  top: 295,
                  child: pw.Text(
                    widget.lstString.data.isNotEmpty
                        ? widget.lstString.data[3]
                        : '',
                    style: pw.TextStyle(fontSize: 12, color: PdfColors.black),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }
}
