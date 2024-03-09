import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/models/requestModel.dart';
import 'package:dedebt_application/repositories/userRepository.dart';
import 'package:dedebt_application/services/userService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:go_router/go_router.dart';
import 'package:dedebt_application/routes/route.dart';

class sendRequestPage2Screen extends StatefulWidget {
  final Request request;
  const sendRequestPage2Screen({required this.request, Key? key})
      : super(key: key);
  @override
  State<sendRequestPage2Screen> createState() => _sendRequestPage2Screen();
}

class _sendRequestPage2Screen extends State<sendRequestPage2Screen> {
  static Color appBarColor = const Color(0xFF444371);
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final UserRepository userRepository =
      UserRepository(firestore: firestore);
  late final UserService userService =
      UserService(userRepository: userRepository);
  static Color navBarColor = const Color(0xFF2DC09C);
  late Request _request;
  User? user = FirebaseAuth.instance.currentUser;

  final ScrollController _scrollController = ScrollController();
  static List<DropDownValueModel> debtTypeList = [
    "บัตรเครดิต(Credit card)",
    "สินเชื่อส่วนบุคคล(Personal lone)",
    "หนี้บ้าน หนี้ที่อยู่อาศัย หนี้บ้านแลกเงิน (Home for cash)",
    "หนี้จำนำทะเบียนรถ(Car for cash)",
    "หนี้เช่าซื้อรถ (Hire purchase)"
  ].map((value) => DropDownValueModel(name: value, value: value)).toList();
  static List<DropDownValueModel> debtStatusList = [
    "ปกติ หรือ ค้างชำระไม่เกิน 90 วัน",
    "Non-performing Loan (NPL) (ค้างชำระเกิน 90 วัน)",
    "อยู่ระหว่างกระบวนการกฎหมาย หรือ ศาลพิพากษาแล้ว",
  ].map((value) => DropDownValueModel(name: value, value: value)).toList();

  static List<DropDownValueModel> financialServiceProviderList = [
    "ธนาคารกรุงเทพ",
    "ธนาคารกรุงไทย",
    "ธนาคารกรุงศรีอยุธยา",
    "ธนาคารกสิกรไทย",
    "ธนาคารเกียรตินาคินภัทร",
    "ธนาคารซิตี้แบงก์",
    "ธนาคารซีไอเอ็มบีไทย",
    "ธนาคารทหารไทย",
    "ธนาคารทิสโก้",
    "ธนาคารไทยเครดิตเพื่อรายย่อย",
    "ธนาคารไทยพาณิชย์",
    "ธนาคารธนชาต",
    "ธนาคารพัฒนาวิสาหกิจขนาดกลางและขนาดย่อมแห่งประเทศไทย",
    "ธนาคารเพื่อการเกษตรและสหกรณ์การเกษตร",
    "ธนาคารเพื่อการส่งออกและนำเข้าแห่งประเทศไทย",
    "ธนาคารยูโอบี",
    "ธนาคารแลนด์ แอนด์ เฮ้าส์",
    "ธนาคารสแตนดาร์ดชาร์เตอร์ด (ไทย) จำกัด (มหาชน)",
    "ธนาคารแห่งประเทศจีน",
    "ธนาคารออมสิน",
    "ธนาคารอาคารสงเคราะห์",
    "ธนาคารออมสิน",
    "ธนาคารอาคารสงเคราะห์",
    "ธนาคารอิสลามแห่งประเทศไทย",
    "ธนาคารไอซีบีซี (ไทย)",
    "กรุงไทยธุรกิจ ลิสซิ่ง",
    "กรุงไทย ออโต้ลีส",
    "กรุ๊ปลีส",
    "คลังเศรษญการ",
    "ควิกลิสซิ่ง",
    "เงินต่อยอด",
    "เงิตนติดล้อ",
    "เงินเทอร์โบ",
    "บัตรกรุงไทย",
    "บัตรกรุงศรีเฟิร์สช้อยส์",
    "บัตรเครดิต กรุงศรี",
    "บัตรเครดิตเซ็นทรัล เดอะวัน",
    "บัตรเทาโก้ โลตัส วีซ่า",
    "เมืองไทย แคปปิตอล"
  ].map((name) => DropDownValueModel(name: name, value: name)).toList();

  static List<DropDownValueModel> incomeList = [
    "รายได้เสริม เช่นโบนัส ค่าโอที รายได้พิเศษ งานเสริม"
        "ผลตอบแทนการลงทุน",
    "ธุรกิจส่วนตัว",
    "รายได้จากครอบครัว"
  ].map((value) => DropDownValueModel(name: value, value: value)).toList();
  static List<DropDownValueModel> burdenList = [
    "ผ่อนหนี้ 1/3 ของรายได้ต่อเดือน",
    "ผ่อนหนี้มากกว่า 1/3 แต่ยังน้อยกว่า 1/2 ของรายได้ต่อเดือน",
    "ผ่อนหนี้มากกว่า 1/2 รายได้ต่อเดือนแต่น้อยกว่า 2/3 ต่อเดือน",
    "ผ่อนหนี้ 2/3 ของรายได้ต่อเดือน"
  ].map((value) => DropDownValueModel(name: value, value: value)).toList();
  List<SingleValueDropDownController> ProviderControllerList = [];
  List<SingleValueDropDownController> TypeControllerList = [];
  List<SingleValueDropDownController> debtStatusControllersList = [];
  List<TextEditingController> BranchControllersList = [];

  //ตัวแปรเก็บ container
  List<Container> RowOfFinancial = [];
  int index = 0;
  @override
  void initState() {
    _request = widget.request;
    super.initState();
    RowOfFinancial = [];
    TypeControllerList = [];
    RowOfFinancial = [];
    ProviderControllerList.add(SingleValueDropDownController());
    TypeControllerList.add(SingleValueDropDownController());
    debtStatusControllersList.add(SingleValueDropDownController());
    BranchControllersList.add(TextEditingController());

    RowOfFinancial.add(createProviderContainer(
        ProviderControllerList[0],
        TypeControllerList[0],
        debtStatusControllersList[0],
        BranchControllersList[0]));
    index += 1;
  }

  @override
  void dispose() {
    _scrollController.dispose(); // avoid memory leaks
    super.dispose();
  }

  Future<Map<String, dynamic>?> createRequest(Request request) async {
    userService.createRequest(request);
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

  Container createProviderContainer(
      SingleValueDropDownController financialServiceProviderController,
      SingleValueDropDownController debtTypeController,
      SingleValueDropDownController debtStatusController,
      TextEditingController BranchController) {
    return Container(
      width: 330,
      height: 411,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text("ผู้ให้บริการทางการเงิน"),
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
            child: DropDownTextField(
              controller: financialServiceProviderController,
              dropDownItemCount: 5,
              dropDownList: financialServiceProviderList,
              enableSearch: true,
              onChanged: (value) {
                // Handle data when user select from drop down
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text("ประเภท"),
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
            child: DropDownTextField(
              controller: debtTypeController,
              dropDownItemCount: 5,
              dropDownList: debtTypeList,
              onChanged: (value) {
                // Handle data when user select from drop down
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text("สภานะของหนี้"),
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
            child: DropDownTextField(
              controller: debtStatusController,
              dropDownItemCount: 3,
              dropDownList: debtStatusList,
              onChanged: (value) {
                // Handle data when user select from drop down
              },
            ),
          ),
          createTextField("สาขาที่ทำสัญญา", false, BranchController),
        ],
      ),
    );
  }

  List<String> getProviderList() {
    List<String> tempList = [];
    for (var i = 0; i < ProviderControllerList.length; i++) {
      tempList.add(ProviderControllerList[i].dropDownValue.toString());
    }
    return tempList;
  }

  List<String> getTypeList() {
    List<String> tempList = [];
    for (var i = 0; i < TypeControllerList.length; i++) {
      tempList.add(TypeControllerList[i].dropDownValue.toString());
    }
    return tempList;
  }

  List<int> getDebtStatusList() {
    List<int> tempList = [];
    for (var i = 0; i < debtStatusControllersList.length; i++) {
      try {
        int value = debtStatusControllersList[i].dropDownValue!.value;
        tempList.add(value);
      } catch (e) {
        // Handle error or provide default value if necessary
      }
    }
    return tempList;
  }

  List<String> getBranchList() {
    List<String> tempList = [];
    for (var i = 0; i < BranchControllersList.length; i++) {
      tempList.add(BranchControllersList[i].text);
    }
    return tempList;
  }

  @override
  Widget build(BuildContext context) {
    print(_request);
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
                    context.go(AppRoutes.SEND_REQUEST_USER);
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
          child: Column(
            children: [
              RawScrollbar(
                controller: _scrollController,
                thumbColor: const Color(0xFFBBB9F4),
                thumbVisibility: true,
                radius: const Radius.circular(20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
                thickness: 5,
                child: Container(
                    width: 360,
                    height: 602,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: DefaultTextStyle(
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: const Color(0xFF000000),
                            fontSize: 18.0,
                          ),
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: RowOfFinancial.length,
                        itemBuilder: (context, index) {
                          return RowOfFinancial[index];
                        },
                      ),
                    )),
              ),
            ],
          ),
        )),
        bottomNavigationBar: BottomAppBar(
          color: navBarColor,
          height: 120,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: Duration(milliseconds: 100),
                      curve: Curves.easeInOut,
                    );
                    ProviderControllerList.add(SingleValueDropDownController());
                    TypeControllerList.add(SingleValueDropDownController());
                    debtStatusControllersList
                        .add(SingleValueDropDownController());
                    BranchControllersList.add(TextEditingController());

                    RowOfFinancial.add(createProviderContainer(
                        ProviderControllerList[index],
                        TypeControllerList[index],
                        debtStatusControllersList[index],
                        BranchControllersList[index]));
                    index += 1;
                    setState(() {}); // Trigger a rebuild to update the ListView
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: Duration(milliseconds: 100),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Text('เพิ่มผู้ให้บริการทางการเงิน'),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        //function เรียกข้อมูลจาก list
                        _request.branch = getBranchList();
                        _request.provider = getProviderList();
                        _request.type = getTypeList();
                        _request.debtStatus = getDebtStatusList();
                        _request.userId = user!.uid;

                        createRequest(_request);
                        // context.go(AppRoutes.SEND_REQUESt_SUCCESS_USER);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: navBarColor,
                      ),
                      child: const Text(
                        'ส่งคำร้อง',
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
