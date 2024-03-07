import 'package:dedebt_application/models/advisorModel.dart';
import 'package:dedebt_application/models/requestModel.dart';
import 'package:dedebt_application/variables/color.dart';
import 'package:dedebt_application/widgets/advisorDetailBottomsheet.dart';
import 'package:flutter/material.dart';

class AdvisorlistBottomSheet extends StatelessWidget {
  final List<Advisors> advisors;
  final Request currentRequest;

  const AdvisorlistBottomSheet({
    required this.currentRequest,
    required this.advisors,
    Key? key,
  }) : super(key: key);

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
                SizedBox(
                  width: 30,
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
            SizedBox(
              width: 350,
              child: ListView.builder(
                shrinkWrap:
                    true, // คำสั่งนี้จะช่วยให้ ListView มีขนาดตามเนื้อหาภายในเท่าที่จำเป็น
                itemCount: advisors.length,
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
                                  advisor: advisors[index],
                                  currentRequest: currentRequest));
                        } catch (e) {
                          print('Error fetching advisors data: $e');
                          // Handle error gracefully, e.g., show a snackbar or error message
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
                          "${advisors[index].firstname} ${advisors[index].lastname}",
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
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
