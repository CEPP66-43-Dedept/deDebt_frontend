import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

class sendRequestScreen extends StatefulWidget {
  const sendRequestScreen({super.key});

  @override
  State<sendRequestScreen> createState() => _sendRequestScreen();
}

class _sendRequestScreen extends State<sendRequestScreen> {
  static Color navbarColor = const Color(0xFF444371);
  static List<DropDownValueModel> debtTypeList = [
    const DropDownValueModel(
        name: "บัตรเครดิต(Credit card)", value: "บัตรเครดิต(Credit card)"),
    const DropDownValueModel(
        name: "สินเชื่อส่วนบุคคล(Personal lone) หรือ บัตรกดเงินสด",
        value: "สินเชื่อส่วนบุคคล(Personal lone) หรือ บัตรกดเงินสด"),
    const DropDownValueModel(
        name: "หนี้บ้าน หนี้ที่อยู่อาศัย หนี้บ้านแลกเงิน (Home for cash)",
        value: "หนี้บ้าน หนี้ที่อยู่อาศัย หนี้บ้านแลกเงิน (Home for cash)"),
    const DropDownValueModel(
        name: "หนี้จำนำทะเบียนรถ(Car for cash)",
        value: "หนี้จำนำทะเบียนรถ(Car for cash)"),
    const DropDownValueModel(
        name: "หนี้เช่าซื้อรถ (Hire purchase)",
        value: "หนี้เช่าซื้อรถ (Hire purchase)"),
  ];
  static List<DropDownValueModel> ssnTypeList = [
    const DropDownValueModel(
        name: "เลขประจำตัวประชาชน", value: "เลขประจำตัวประชาชน"),
    const DropDownValueModel(
        name: "เลขที่หนังสือเดินทาง", value: "เลขที่หนังสือเดินทาง"),
  ];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: navbarColor,
            surfaceTintColor: Colors.transparent,
            toolbarHeight: 55,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
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
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: const Color(0xFF000000),
                        fontSize: 18.0,
                      ),
                  child: ListView(children: [
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
                        dropDownItemCount: 5,
                        dropDownList: debtTypeList,
                        enableSearch: true,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text("ชื่อ - นามสกุล / ชื่อนิติบุคคล"),
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
                        //controller for TextForm
                        //controller: ,
                        decoration: const InputDecoration(
                          hintText: "Type your name here",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Name";
                          }
                          return null;
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text("ประเภทรหัสอ้างอิงบุคคล/นิติบุคคล"),
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
                        dropDownItemCount: 2,
                        dropDownList: ssnTypeList,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text("เลขประจำตัวบุคคลและนิติบุคคล"),
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
                        //controller for TextForm
                        //controller: ,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "Type your SSN Here",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter SSN";
                          }
                          return null;
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text("โทรศัพท์มือถือ"),
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
                        //controller for TextForm
                        //controller: ,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "Type your Phone Number Here",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Phone Number";
                          }
                          return null;
                        },
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
                        //controller for TextForm
                        //controller: ,
                        maxLines: 6,
                        maxLength: 300,
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
          color: navbarColor,
          height: 55,
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button press
                    print('Next button pressed');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: navbarColor,
                  ),
                  child: Text(
                    'ถัดไป',
                    style: TextStyle(
                        fontSize: 18.0, color: Colors.white), // Set text color
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
