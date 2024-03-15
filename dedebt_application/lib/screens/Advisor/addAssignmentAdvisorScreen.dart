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
  List<Widget> containerList = [
    const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text("ประเภท"),
    ),
  ];

  static List<DropDownValueModel> assignmentTypeList = [
    "กรอกเอกสาร", //template
    "นัดหมาย"
  ].map((value) => DropDownValueModel(name: value, value: value)).toList();

  void initState() {
    super.initState();
    containerList.add(Container(
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
        onChanged: (value) {
          try {
            value = value.value;
          } catch (e) {
            value = "";
          }
          if (value == "นัดหมาย") {
            if (containerList.length > 5) {
              containerList.removeLast();
            }
            containerList.add(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("เลือกวันนัดหมาย"),
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
                    child: TextFormField(),
                  ),
                ],
              ),
            );

            setState(() {});
          } else if (value == "กรอกเอกสาร") {
            if (containerList.length > 5) {
              containerList.removeLast();
            }
            containerList.add(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("เลือกเทมเพลต"),
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
                    child: InkWell(
                      onTap: () => _showBottomSheet(),
                      child: TextFormField(
                        enabled: false,
                        decoration: const InputDecoration(),
                      ),
                    ),
                  ),
                ],
              ),
            );
            setState(() {});
          } else {
            containerList.removeLast();
            setState(() {});
          }
        },
      ),
    ));
    containerList.add(
      createTextField("หัวข้องาน", false, titleController),
    );
    containerList.add(const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text("รายการสิ่งที่ต้องทำ"),
    ));
    containerList.add(
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
          decoration: const InputDecoration(),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter Detail";
            }
            return null;
          },
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 22),
                    child: Text(
                      "เลือกเทมเพลต",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  getSelectTemplateContainer("เอกสารหักเงินของธนาคารกสิกร"),
                  getSelectTemplateContainer("เอกสารหักเงินของธนาคารกสิกร"),
                  getSelectTemplateContainer("เอกสารหักเงินของธนาคารกสิกร"),
                  getSelectTemplateContainer("เอกสารหักเงินของธนาคารกสิกร"),
                  getSelectTemplateContainer("เอกสารหักเงินของธนาคารกสิกร"),
                  getSelectTemplateContainer("เอกสารหักเงินของธนาคารกสิกร"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showPDFViewer() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 22),
                    child: Text(
                      "เลือกเทมเพลต",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Container(
                    width: 331,
                    height: 71,
                    child: const Row(
                      children: [
                        Icon(
                          Icons.account_balance,
                          size: 55,
                          color: Colors.black,
                        ),
                        Flexible(
                          child: Text(
                            "ใบหักเงินในบัญชีธนาคารกสิกรไทย",
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                                fontSize: 24, color: Color(0xFF36338C)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 280,
                    height: 280,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(28.0)),
                      color: Color(0xFFDAEAFA),
                    ),
                    padding: const EdgeInsets.fromLTRB(19, 11, 18, 35),
                    child: Stack(
                      children: [
                        Container(
                          width: 302,
                          height: 328,
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            color: Colors.white,
                          ),
                          child: Text("PDF To shown"),
                        ),
                        Positioned(
                          bottom: 1.0,
                          right: 1.0,
                          child: IconButton(
                            icon: Icon(
                              Icons.zoom_out_map,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              // ปุ่มดู pdf
                              print('Info button pressed!');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 325,
                    height: 62,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Color(0xFF2DC09C),
                    ),
                    child: InkWell(
                        onTap: () {
                          //เพิ่ม template
                        },
                        child: Center(
                          child: Text(
                            "เพิ่มเทมเพลต",
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  InkWell getSelectTemplateContainer(String t_name) {
    return InkWell(
      onTap: () {
        showPDFViewer();
      },
      child: Container(
        width: 325,
        height: 62,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Color(0xFFDAEAFA),
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Flexible(
              child: Text(t_name,
                  style:
                      const TextStyle(fontSize: 24, color: Color(0xFF36338C)),
                  overflow: TextOverflow.ellipsis),
            ),
            const Icon(Icons.chevron_right, size: 35, color: Color(0xFF36338C))
          ],
        ),
      ),
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
                  children: containerList),
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
                Center(
                  child: Text(
                    'เพิ่มสิ่งที่ต้องทำ',
                    style: const TextStyle(fontSize: 18.0, color: Colors.white),
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
