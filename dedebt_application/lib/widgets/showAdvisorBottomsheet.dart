import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/models/advisorModel.dart';
import 'package:dedebt_application/models/requestModel.dart';
import 'package:dedebt_application/repositories/matcherRepository.dart';
import 'package:dedebt_application/services/matcherService.dart';
import 'package:dedebt_application/variables/color.dart';
import 'package:dedebt_application/widgets/advisorDetailBottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdvisorlistBottomSheet extends StatefulWidget {
  final List<Advisors> advisors;
  final Request currentRequest;

  const AdvisorlistBottomSheet({
    required this.currentRequest,
    required this.advisors,
    Key? key,
  }) : super(key: key);

  @override
  _AdvisorlistBottomSheetState createState() => _AdvisorlistBottomSheetState();
}

class _AdvisorlistBottomSheetState extends State<AdvisorlistBottomSheet> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  late final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final MatcherRepository _matcherRepository =
      MatcherRepository(firestore: firestore);
  late MatcherService _matcherService =
      MatcherService(matcherRepository: _matcherRepository);

  Future<List<Advisors>> _processTimestampData(Timestamp timestamp) async {
    try {
      return await _matcherRepository.processTimestampData(timestamp);
    } catch (e) {
      print('Error fetching users data: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 800,
        width: 400,
        decoration: BoxDecoration(
          color: ColorGuide.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_back_ios, color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "เลือกดูที่ปรึกษา",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                _selectDateTime(context);
              },
              child: Text(
                selectedDate == null || selectedTime == null
                    ? 'เลือกวันและเวลา'
                    : '${DateFormat.yMd().add_jm().format(DateTime(selectedDate!.year, selectedDate!.month, selectedDate!.day, selectedTime!.hour, selectedTime!.minute))}',
                style: TextStyle(color: ColorGuide.blueLight),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorGuide.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            FutureBuilder<List<Advisors>>(
              future: _processTimestampData(
                Timestamp.fromDate(
                  DateTime(
                    selectedDate?.year ?? DateTime.now().year,
                    selectedDate?.month ?? DateTime.now().month,
                    selectedDate?.day ?? DateTime.now().day,
                    selectedTime?.hour ?? DateTime.now().hour,
                    selectedTime?.minute ?? DateTime.now().minute,
                  ),
                ),
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                }

                // Store the advisors data temporarily
                final advisorsData = snapshot.data ?? [];

                return SizedBox(
                  height: 500, // You can adjust the height as needed
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: advisorsData.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ElevatedButton(
                          onPressed: () {
                            try {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => AdvisorDetailBotomsheet(
                                  advisor: advisorsData[index],
                                  currentRequest: widget.currentRequest,
                                ),
                              );
                            } catch (e) {
                              print('Error fetching advisors data: $e');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(100, 60),
                            backgroundColor: ColorGuide.blueLight,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${advisorsData[index].firstname} ${advisorsData[index].lastname}",
                              style: const TextStyle(
                                fontSize: 18,
                                color: ColorGuide.blueAccent,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          selectedDate = pickedDate;
          selectedTime = pickedTime;
        });
      }
    }
  }
}
