// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../core/extensions/widget_extension.dart';
// import '../../controller/on_boarding_controller.dart';
// import '../widget/on_boarding_widget/get_started_button_on_boarding.dart';
// import '../widget/on_boarding_widget/indicator_on_boarding.dart';
// import '../widget/on_boarding_widget/page_view_on_boarding.dart';
// import '../widget/on_boarding_widget/skip_on_boarding.dart';
//
// class OnBoardingScreen extends StatelessWidget {
//   const OnBoardingScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     OnBoardingControllerImp controller = Get.put(OnBoardingControllerImp());
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           const PageViewOnBoarding(),
//           const IndicatorOnBoarding(),
//           const SkipOnBoarding()
//               .align(
//                 alignment: AlignmentDirectional.topEnd,
//               )
//               .paddingDirectional(
//                 const EdgeInsetsDirectional.only(
//                   top: 16,
//                   end: 16,
//                 ),
//               ),
//           const GetStartedButtonOnBoarding().align(
//             alignment: const Alignment(0, 0.725),
//           ),
//         ],
//       ).makeSafeArea().willPopScope(),
//     );
//   }
// }
