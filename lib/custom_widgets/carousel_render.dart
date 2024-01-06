import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarouselRender extends StatelessWidget {
  final String imgPath;
  final String txtPath;

  const CarouselRender(this.txtPath, this.imgPath, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(imgPath, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            txtPath,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Cabin',
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
