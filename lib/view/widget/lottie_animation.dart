import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/constant/animation_assets.dart';
import '../../core/constant/color.dart';

class LottieAnimation extends StatelessWidget {
  const LottieAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      AppAnimationAssets.done,
      delegates: LottieDelegates(
        values: [
          ValueDelegate.color(
            ['**', 'Shape Layer 2', '**'],
            value: AppColor.style1secondary1,
          ),
          ValueDelegate.color(
            ['**', 'Shape Layer 1', '**'],
            value: AppColor.style1secondary1,
          ),
        ],
      ),
      height: 200,
      repeat: false,
    );
  }
}
