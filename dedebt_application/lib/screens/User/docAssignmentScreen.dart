import 'dart:async';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class DocAssignScreen extends StatefulWidget {
  final List<String> lstString;
  const DocAssignScreen({Key? key, required this.lstString}) : super(key: key);

  @override
  State<DocAssignScreen> createState() => _DocAssignScreenState();
}

class _DocAssignScreenState extends State<DocAssignScreen> {
  late final String _imageUrl =
      'https://media.discordapp.net/attachments/1027767973286510602/1222481727616978954/K_Xpress_Cash_AutoPayment_TH_page-0001.jpg?ex=66165fd4&is=6603ead4&hm=6b1c463aff267f3abfe3eaef47a82232075b1501fa49cb2ce97c7bb46479225e&=&format=webp&width=752&height=1064';
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
        appBar: AppBar(title: const Text('สร้างเอกสาร')),
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
                // ข้อความ
                pw.Center(
                  child: pw.Text(
                    '${widget.lstString.join('\n')}',
                    style: pw.TextStyle(fontSize: 14, color: PdfColors.black),
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
