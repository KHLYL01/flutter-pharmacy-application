import 'package:flutter/material.dart';

import '../../core/constant/color.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            // AppColor.mainColor.withOpacity(0.5),
            // AppColor.mainColor,
            AppColor.style1secondary1,
            AppColor.style1secondary2,
          ],
          begin: AlignmentDirectional.topCenter,
          end: AlignmentDirectional.bottomCenter,
        ),
      ),
    );
  }
}
