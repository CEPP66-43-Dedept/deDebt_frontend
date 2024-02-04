import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({super.key});

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _ssnController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _telController = TextEditingController();
  final _passwordController = TextEditingController();
  bool? isCheckedPersonal = false;
  bool? isCheckedAnotherrRoles = false;
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Stepper(
        currentStep: _currentStep,
        onStepTapped: (step) => setState(() => _currentStep = step),
        steps: [
          _buildStep1(),
          _buildStep2(),
        ],
        onStepContinue: () {
          _onStepContinue();
        },
      ),
    );
  }

  Step _buildStep1() {
    return Step(
      title: const Text('Step 1: ข้อมูลส่วนตัว'),
      isActive: true,
      state: _currentStep == 0 ? StepState.editing : StepState.complete,
      content: Column(
        children: [
          TextFormField(
            controller: _ssnController,
            decoration:
                const InputDecoration(labelText: 'เลขประจำตัวประชาชน SSN'),
            validator: (value) {
              if (value != null && value.isEmpty) {
                return 'กรุณากรอกเลขประจำตัวประชาชน';
              } else if (value != null && value.length != 14) {
                return 'เลขประจำตัวประชาชนต้องมี 14 หลัก';
              }
              return null;
            },
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(14),
            ],
          ),
          TextFormField(
            controller: _firstNameController,
            decoration:
                const InputDecoration(labelText: 'ชื่อจริง (Firstname)'),
            validator: (value) =>
                value != null && value.isEmpty ? 'กรุณากรอกชื่อ' : null,
          ),
          TextFormField(
            controller: _lastNameController,
            decoration: const InputDecoration(labelText: 'นามสกุล (LastName)'),
            validator: (value) =>
                value != null && value.isEmpty ? 'กรุณากรอกนามสกุล' : null,
          ),
          TextFormField(
            controller: _telController,
            decoration:
                const InputDecoration(labelText: 'เบอร์โทรศัพท์ (Tel.)'),
            validator: (value) {
              if (value != null && value.isEmpty) {
                return 'กรุณากรอกเบอร์โทรศัพท์';
              } else if (value != null && value.length != 10) {
                return 'เบอร์โทรศัพท์ต้องมี 10 ตัวอักษร';
              }
              return null;
            },
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'รหัสผ่าน (Password)'),
            validator: (value) {
              if (value != null && value.isEmpty) {
                return 'กรุณากรอกรหัสผ่านอย่างน้อย6ตัว';
              } else if (value != null && value.length < 6) {
                return 'รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร';
              }
              return null;
            },
          )
        ],
      ),
    );
  }

  Step _buildStep2() {
    return Step(
      title: const Text('Step 2: ยินยอมการเปิดเผยข้อมูล'),
      content: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: isCheckedPersonal,
                onChanged: (bool? value) {
                  setState(() {
                    isCheckedPersonal = value;
                  });
                },
              ),
              const Text(
                "ยินยอมให้แอพพลิเคชั่นเก็บบันทึกข้อมูล\nส่วนตัวและข้อมูลคำร้องขอของผู้ใช้งาน",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: isCheckedAnotherrRoles,
                onChanged: (bool? value) {
                  setState(() {
                    isCheckedAnotherrRoles = value;
                  });
                },
              ),
              const Column(
                children: [
                  Text(
                    "ยินยอมให้แอพพลิเคชั่นเปิดเผยข้อมูล\nคำร้องขอแก่พนักงานขององค์กร ดังนี้",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: "-ผู้รับคำปรึกษา",
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text:
                          "\n\t-เพื่อที่จะสามารถรับรู้รายละเอียดของคำร้องขอได้",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: "-ผู้จับคู่",
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text:
                          "\n\t-เพื่อที่จะสามารถรับรู้รายละเอียดของคำร้องขอได้",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  text: "-ผู้ดูแล",
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text:
                          "\n\t-เพื่อที่จะสามารถตรวจสอบรายละเอียดต่างๆของผู้ใช้งาน",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      isActive: _currentStep == 1,
      state: (_currentStep == 1 &&
              isCheckedPersonal == true &&
              isCheckedAnotherrRoles != true)
          ? StepState.complete
          : StepState.editing,
    );
  }

  void _onStepContinue() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      if (_currentStep < 1) {
        setState(() => _currentStep += 1);
      }
    }
  }

  void _onStepCancel() {
    if (_currentStep > 1) {
      setState(() => _currentStep -= 1);
    }
  }
}
