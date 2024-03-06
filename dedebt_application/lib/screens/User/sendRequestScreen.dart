import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:go_router/go_router.dart';
import 'package:dedebt_application/routes/route.dart';

class sendRequestScreen extends StatefulWidget {
  const sendRequestScreen({super.key});

  @override
  State<sendRequestScreen> createState() => _sendRequestScreen();
}

class _sendRequestScreen extends State<sendRequestScreen> {
  static Color appBarColor = const Color(0xFF444371);
  static Color navBarColor = const Color(0xFF2DC09C);
  static List<DropDownValueModel> burdenTypeList = [
    "ผ่อนหนี้ 1/3 ของรายได้ต่อเดือน",
    "ผ่อนหนี้มากกว่า 1/3 แต่ยังน้อยกว่า 1/2 ของรายได้ต่อเดือน",
    "ผ่อนหนี้มากกว่า 1/2 รายได้ต่อเดือนแต่น้อยกว่า 2/3 ต่อเดือน",
    "ผ่อนหนี้ 2/3 ของรายได้ต่อเดือน"
  ].map((value) => DropDownValueModel(name: value, value: value)).toList();
  static const List<DropDownValueModel> appointmentDateList = [
    DropDownValueModel(name: "วันจันทร์", value: 0),
    DropDownValueModel(name: "วันอังคาร", value: 1),
    DropDownValueModel(name: "วันพุธ", value: 2),
    DropDownValueModel(name: "วันพฤหัสบดี", value: 3),
    DropDownValueModel(name: "วันศุกร์", value: 4),
  ];

  //Controller ในการเข้าถึงข้อมูล
// controll เก็บข้อมูลของรายรับ
// เก็บข้อมูลในตัวแปร revenue โดยเก็บเป็น list โดยเรียงลำดับดังนี้
// [MonthlyIncomeController,ExtraworkIncomeController,InvesmentIncomeComtroller,PrivateBussnessIncomeController]
  final MonthlyIncomeController = TextEditingController();
  final ExtraworkIncomeController = TextEditingController();
  final InvesmentIncomeComtroller = TextEditingController();
  final PrivateBussnessIncomeController = TextEditingController();

//เก็บในตัวแปร expense เป็น list โดยเรียงลำดับดังนี้
//[MonthlyExpenseController,DebtExpenseController]
  final MonthlyExpenseController = TextEditingController();
  final DebtExpenseController = TextEditingController();

//เก็บในตัวแปร propoty
  final PropotyContoller = TextEditingController();

//เก็บในตัวแปร detail
  final DetailController = TextEditingController();

//เก็บในตัวแปร burden
  final BurdenController = SingleValueDropDownController();

// เก็บในตัวแปร appointmentDate
  final appointmentDateController = MultiValueDropDownController();

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
  //function ดึงช้อมูลขาก appointmenDate
  List<int> getAppointmentDatefromUser() {
    List<int> returnList = [];
    List<DropDownValueModel>? rawDataList =
        appointmentDateController.dropDownValueList;
    if (rawDataList != null) {
      for (var i = 0; i <= rawDataList.length; i++) {
        returnList.add(appointmentDateList[i].value);
      }
    }
    return returnList;
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
                    context.go(AppRoutes.REQUEST_USER);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 45,
                ),
                const Text(
                  "ลงทะเบียนคำร้อง",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                )
              ],
            )),
        body: Scaffold(
            body: Align(
          alignment: Alignment.center,
          child: RawScrollbar(
            thumbColor: const Color(0xFFBBB9F4),
            thumbVisibility: true,
            radius: const Radius.circular(20),
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
            thickness: 5,
            child: Container(
                width: 360,
                height: 690,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: const Color(0xFF000000),
                        fontSize: 18.0,
                      ),
                  child: ListView(children: [
                    createTextField(
                        "รายได้หลักต่อเดือน", true, MonthlyIncomeController),
                    createTextField("รายได้เสริม เช่นโบนัส ค่าโอที งานเสริม",
                        true, ExtraworkIncomeController),
                    createTextField(
                        "ผลตอบแทนการลงทุน", true, InvesmentIncomeComtroller),
                    createTextField("รายได้จากธุรกิจส่วนตัว", true,
                        PrivateBussnessIncomeController),
                    createTextField("ค่าใช้จ่ายในชีวิตประจำวันต่อเดือน", true,
                        MonthlyExpenseController),
                    createTextField(
                        "ภาระหนี้ต่อเดือน", true, DebtExpenseController),
                    createTextField("เงินออมหรือทรัพย์สินส่วนตัวรวม", true,
                        PropotyContoller),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text("ภาระหนี้"),
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
                        controller: BurdenController,
                        dropDownItemCount: 4,
                        dropDownList: burdenTypeList,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text("วันที่ผู้ใช้สะดวก"),
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
                      child: DropDownTextField.multiSelection(
                        displayCompleteItem: true,
                        controller: appointmentDateController,
                        dropDownItemCount: 5,
                        dropDownList: appointmentDateList,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                          "เหตุผล หรือคำอธิบายประกอบคำขอ \n(ไม่เกิน 300 ตัวอักษร)"),
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
                        controller: DetailController,
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
                  ]),
                )),
          ),
        )),
        bottomNavigationBar: BottomAppBar(
          color: navBarColor,
          height: 55,
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.go(AppRoutes.SEND_REQUEST_PAGE2_USER);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: navBarColor,
                  ),
                  child: const Text(
                    'ถัดไป',
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
