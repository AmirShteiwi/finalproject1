import 'package:diet_app/constants/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_drawer.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneNumberInputController = TextEditingController();
    final emailInputController = TextEditingController();
    final faxNumberInputController = TextEditingController();

    emailInputController.text = "amirshtaiwi@gmail.com";
    phoneNumberInputController.text = "00905550933341";
    faxNumberInputController.text = "222-333-8888";

    return Scaffold( backgroundColor: Colors.white,
      appBar: const MyAppBar(title: 'Contact Us'),
      drawer: const MyDrawer(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/images/contact-image.png',
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Column(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(fontSize: 20.sp),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green.shade200),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          readOnly: true,
                          style: const TextStyle(color: Colors.green),
                          controller: emailInputController,
                          decoration: InputDecoration(
                            hintText: 'amirshtaiwi@gmail.com',
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                       Row(
                        children: [
                          Text(
                            'Phone number',
                            style: TextStyle(fontSize: 20.sp),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green.shade200),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          readOnly: true,
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(color: Colors.green),
                          controller: phoneNumberInputController,
                          decoration: InputDecoration(
                            hintText: '00905550933341',
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                       Row(
                        children: [
                          Text(
                            'Fax number',
                            style: TextStyle(fontSize: 20.sp),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green.shade200),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          readOnly: true,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.green),
                          controller: faxNumberInputController,
                          decoration: InputDecoration(
                            hintText: '222-333-8888',
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
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
