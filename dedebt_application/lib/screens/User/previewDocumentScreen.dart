import 'dart:typed_data';

import 'package:dedebt_application/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:dedebt_application/models/assignmentModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class previewDocumentScreen extends StatefulWidget {
  final String assignmentId;
  const previewDocumentScreen({super.key, required this.assignmentId});

  @override
  State<previewDocumentScreen> createState() => _previewDocumentScreen();
}

class _previewDocumentScreen extends State<previewDocumentScreen> {
  static Color appBarColor = const Color(0xFF444371);
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
                    'test',
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

  Container createTextField(
      String TextBanner, bool isNumberOnly, TextEditingController controller) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(TextBanner),
          ),
          Container(
            width: 330,
            height: 52,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: controller,
              keyboardType:
                  isNumberOnly ? TextInputType.number : TextInputType.text,
              decoration: const InputDecoration(
                hintText: "Type your info Here",
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: appBarColor,
          surfaceTintColor: Colors.transparent,
          toolbarHeight: 55,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  context.go(AppRoutes.ASSIGNMENT_FILL_DOC_USER);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 35,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 65,
              ),
              const Text(
                "กรอกเอกสาร",
                style: TextStyle(fontSize: 24, color: Colors.white),
              )
            ],
          )),
      body: Align(
        alignment: Alignment.center,
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: const Color(0xFF000000),
                fontSize: 18.0,
              ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Icon(
                  Icons.account_balance,
                  size: 65,
                  color: Color(0xFF36338C),
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: const Text(
                    //เปลี่ชนชื่อธนาตาร
                    "ใบหักเงินจากธนาคารกสิกรไทย",
                    overflow: TextOverflow.visible,
                    style: TextStyle(fontSize: 24, color: Color(0xFF36338C)),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ตัวอย่างเอกสาร"),
                  Container(
                    width: 338,
                    height: 367,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(28.0)),
                      color: Color(0xFFDAEAFA),
                    ),
                    padding: const EdgeInsets.fromLTRB(19, 11, 18, 35),
                    child: Stack(
                      children: [
                        Container(
                          width: 320,
                          height: 400,
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            color: Colors.white,
                          ),
                          child: PdfPreview(
                            build: (format) => _generatePdf(PdfPageFormat.a4),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "บันทึก",
                        style:
                            TextStyle(color: Color(0xFF36338C), fontSize: 20),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.save_alt,
                          size: 35,
                          color: Color(0xFF36338C),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: Container(
        width: 390,
        height: 165,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        //ปุ่มยกเลิก
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF18F80),
                      ),
                      child: const Text(
                        'ยกเลิก',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.go(AppRoutes.ASSIGNMENT_SUCCESS_USER +
                            '/${widget.assignmentId}/1');
                        // ปุ่มเสร็จสิ้นงาน
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2DC09C),
                      ),
                      child: const Text(
                        'เสร็จสิ้นงานที่ได้รับ',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white), // Set text color
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
