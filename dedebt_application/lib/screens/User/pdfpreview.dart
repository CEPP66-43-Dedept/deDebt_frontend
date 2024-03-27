import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PDFPreviewFromFirestoreScreen extends StatelessWidget {
  final String assignmentId;

  const PDFPreviewFromFirestoreScreen({Key? key, required this.assignmentId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview From Firestore'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('pdfs')
            .where('assignmentId', isEqualTo: assignmentId)
            .snapshots()
            .map((snapshot) => snapshot.docs.first),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text('No PDF found for this assignment ID'),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final pdfUrl = snapshot.data!['pdfUrl'];
            return PDF().cachedFromUrl(pdfUrl);
          }
        },
      ),
    );
  }
}
