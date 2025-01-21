import 'package:flutter/material.dart';
import 'package:je_t_aime/core/Language/locales.dart';
import 'dart:async';

import '../Utilities/strings.dart';
import '../Utilities/text_style_helper.dart';
import '../Utilities/theme_helper.dart';

class OtpResendTimer extends StatefulWidget {
  final int initialSeconds; // Total countdown time in seconds
  final VoidCallback onResend;

  const OtpResendTimer({
    Key? key,
    required this.initialSeconds,
    required this.onResend,
  }) : super(key: key);

  @override
  State<OtpResendTimer> createState() => _OtpResendTimerState();
}

class _OtpResendTimerState extends State<OtpResendTimer> {
  late int remainingSeconds;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    remainingSeconds = widget.initialSeconds;
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secondsPart = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secondsPart';
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             GestureDetector(
                               onTap: () {
                                 widget.onResend();
                                 setState(() {
                                   remainingSeconds = widget.initialSeconds;
                                 });
                                 startTimer();
                               },
                               child: Text(
                                 Strings.resendCode.tr,
                                 textAlign: TextAlign.left,
                                 style: TextStyleHelper.of(context).b_16.copyWith(
                                     color: ThemeClass.of(context).secondaryBlackColor.withOpacity(0.6)),
                               ),
                             ),
                             Text(
                               remainingSeconds > 0
                             ? formatTime(remainingSeconds)
        : "Didn't receive the OTP?",
                              // Strings.timeCount.tr,
                               textAlign: TextAlign.left,
                               style: TextStyleHelper.of(context).b_16.copyWith(
                                   color: ThemeClass.of(context).primaryColor),
                             ),
                           ],
                         );
    //   Column(
    //   mainAxisSize: MainAxisSize.min,
    //   children: [
    //     Text(
    //       remainingSeconds > 0
    //           ? "Resend OTP in ${formatTime(remainingSeconds)}"
    //           : "Didn't receive the OTP?",
    //       style: const TextStyle(fontSize: 16, color: Colors.grey),
    //     ),
    //     if (remainingSeconds == 0)
    //       TextButton(
    //         onPressed: () {
    //           widget.onResend();
    //           setState(() {
    //             remainingSeconds = widget.initialSeconds;
    //           });
    //           startTimer();
    //         },
    //         child: const Text(
    //           "Resend OTP",
    //           style: TextStyle(color: Colors.blue),
    //         ),
    //       ),
    //   ],
    // );
  }
}
