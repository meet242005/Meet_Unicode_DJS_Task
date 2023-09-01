import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:meet_unicode/constants/colors.dart';
import 'package:meet_unicode/screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final birthdateController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future checkSignIn() async {
    // if (GetStorage().hasData("is_signed_in")) {
    //   Get.offAll(() => const HomePage());
    // }
  }

  Future registerUser() async {
    if (!formKey.currentState!.validate()) return;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setStringList('userinfo', [
      nameController.text,
      phoneController.text,
      emailController.text,
      birthdateController.text
    ]);

    Get.offAll(() => const HomePage());
  }

  void clearForm() {
    nameController.text = "";
    phoneController.text = "";
    emailController.text = "";
    birthdateController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SizedBox(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 60, 15, 20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome,",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                        color: AppColors.primaryColor),
                  ),
                  Text(
                    "Please Proceed with Registration",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.grey.shade900),
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: SvgPicture.asset(
                      "assets/svg/login.svg",
                      fit: BoxFit.contain,
                      height: 200,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      autovalidateMode: AutovalidateMode.disabled,
                      validator: (input) {
                        if (input!.isNotEmpty) {
                          return null;
                        } else {
                          return "Enter a valid name";
                        }
                      },
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                          hintText: "Enter Your Name",
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.person)),
                      onChanged: ((value) {}),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      autovalidateMode: AutovalidateMode.disabled,
                      validator: (input) {
                        if (input!.isNotEmpty && input.length > 9) {
                          return null;
                        } else {
                          return "Enter a valid phone";
                        }
                      },
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                          hintText: "Enter Your Phone No.",
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.phone)),
                      onChanged: ((value) {}),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      autovalidateMode: AutovalidateMode.disabled,
                      validator: (input) {
                        if (GetUtils.isEmail(input.toString())) {
                          return null;
                        } else {
                          return "Enter a valid email";
                        }
                      },
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                          hintText: "Enter Your Email ID.",
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.email)),
                      onChanged: ((value) {}),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      controller: birthdateController,
                      autovalidateMode: AutovalidateMode.disabled,
                      readOnly: true,
                      validator: (input) {
                        if (input!.isNotEmpty) {
                          return null;
                        } else {
                          return "Enter a valid date";
                        }
                      },
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1990),
                            lastDate: DateTime.now());

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('dd/MM/yyyy').format(pickedDate);
                          setState(() {
                            birthdateController.text = formattedDate;
                          });
                        }
                      },
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                          hintText: "Select Your D.O.B",
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.calendar_month)),
                      onChanged: ((value) {}),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            clearForm();
                          },
                          child: Container(
                              width: double.infinity,
                              height: 60,
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: const Center(
                                child: Text(
                                  "CLEAR",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: AppColors.primaryColor),
                                ),
                              )),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            registerUser();
                          },
                          child: Container(
                              width: double.infinity,
                              height: 60,
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: const Center(
                                child: Text(
                                  "PROCEED",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  InkWell(
                    onTap: () {
                      Get.offAll(() => const HomePage());
                    },
                    child: const Center(
                      child: Text(
                        "DJSCE Unicode'23 Task by Meet Chavan SY - 60004230269",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
