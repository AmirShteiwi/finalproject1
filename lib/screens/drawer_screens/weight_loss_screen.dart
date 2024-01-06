import 'package:diet_app/constants/app_bar.dart';
import 'package:diet_app/screens/drawer_screens/diet_plan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class WeightLossScreen extends StatelessWidget {
  const WeightLossScreen({super.key});

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MyAppBar(title: 'Weight Loss'),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/images/weight-loss-image.png',
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Text(
                'To lose weight, the energy entering the body must be less than the energy spent, that is, a calorie deficit must be created in the body. For this, the calories of the foods consumed during the day must be calulated',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.sp),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DietPlanScreen(),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey),
                        bottom: BorderSide(color: Colors.grey),
                      ),
                      color: Color.fromARGB(146, 203, 255, 144),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.green,
                            offset: Offset(3, 5),
                            blurRadius: 5,
                            spreadRadius: 3),
                      ]),
                  child: Text(
                    'Diet list that helps you lose 10 kilos in 1 week (free)',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ),
              ),
              Column(
                children: [
                  const Text(
                    'For a special personal diet, you can reach us via WhatsApp',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width,
                    child: GestureDetector(
                      onTap: () {
                        _launchUrl(
                          Uri.parse('https://wa.link/c96p48'),
                        );
                      },
                      child: Image.asset(
                        'assets/images/whatsapp-label.png',
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.7,
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
