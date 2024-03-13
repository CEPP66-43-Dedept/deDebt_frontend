import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:go_router/go_router.dart';
import 'package:dedebt_application/routes/route.dart';

class addAssignmentAdvisorScreen extends StatefulWidget {
  const addAssignmentAdvisorScreen({super.key});
  State<addAssignmentAdvisorScreen> createState() =>
      _addAssignmentAdvisorScreen();
}

class _addAssignmentAdvisorScreen extends State<addAssignmentAdvisorScreen> {
  static Color appBarColor = const Color(0xFF444371);
  static Color navBarColor = const Color(0xFF2DC09C);

  final assignmentTypeController = SingleValueDropDownController();
  final titleController = TextEditingController();
  final detailController = TextEditingController();
  final templateController = SingleValueDropDownController();

  static List<DropDownValueModel> assignmentTypeList = [
    "กรอกเอกสาร", //template
    "นัดหมาย"
  ].map((value) => DropDownValueModel(name: value, value: value)).toList();

  static List<DropDownValueModel> templateList = [
    "เอกสารหักงานธนาคารกสิกร",
    "เอกสารหักเงินธนาคารกรุงไทย"
  ].map((value) => DropDownValueModel(name: value, value: value)).toList();

  void _showBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200, // Adjust height as needed
          color: Colors.white,
          child: Center(
            child: Text('This is the bottom sheet content'),
          ),
        );
      },
    );
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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: appBarColor,
            surfaceTintColor: Colors.transparent,
            toolbarHeight: 55,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    context.go(AppRoutes.REQUEST_ADVISOR);
                    //Icon function
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                const Text(
                  "งานที่มอบหมาย",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                )
              ],
            )),
        body: Align(
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            width: 330,
            height: 690,
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: const Color(0xFF000000),
                    fontSize: 18.0,
                  ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text("ประเภท"),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DropDownTextField(
                        controller: assignmentTypeController,
                        dropDownItemCount: 2,
                        dropDownList: assignmentTypeList,
                      ),
                    ),
                    createTextField("หัวข้องาน", false, titleController),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text("รายการสิ่งที่ต้องทำ"),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        maxLines: 6,
                        maxLength: 300,
                        controller: detailController,
                        decoration: const InputDecoration(
                          hintText: "Type your Detail Here",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Detail";
                          }
                          return null;
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text("เลือกเทมเพลต"),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DropDownTextField(
                        controller: templateController,
                        dropDownItemCount: 2,
                        dropDownList: templateList,
                      ),
                    ),
                  ]),
            ),
          ),
        ),
        bottomNavigationBar: InkWell(
          onTap: () {
            _showBottomSheet();
          },
          child: BottomAppBar(
            color: navBarColor,
            height: 104,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    _showBottomSheet();
                  },
                  child: Center(
                    child: Text(
                      'เพิ่มสิ่งที่ต้องทำ',
                      style:
                          const TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
