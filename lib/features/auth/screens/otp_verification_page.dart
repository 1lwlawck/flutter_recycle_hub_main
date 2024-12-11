import 'package:flutter/material.dart';
import 'package:flutter_recycle_hub/features/auth/service/otp_service_api.dart';

class OtpVerificationPage extends StatefulWidget {
  final String email;

  const OtpVerificationPage({super.key, required this.email});

  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final TextEditingController otpController = TextEditingController();
  final FocusNode otpFocusNode = FocusNode();

  void showSnackBar(String message, {Function? onRetry}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: onRetry != null
            ? SnackBarAction(
                label: 'Coba Lagi',
                onPressed: () {
                  onRetry();
                },
              )
            : null,
      ),
    );
  }

  Future<void> verifyOtp(String otp) async {
    final otpService = OtpServiceApi();
    final response = await otpService.verifyOtp(widget.email, otp);

    if (response != null && response.containsKey('message')) {
      String message = response['message'] ?? 'Unknown error';
      showSnackBar(message);

      if (message == 'OTP valid') {
        Navigator.pushReplacementNamed(context, '/home');
      } else if (message == 'OTP invalid') {
        showSnackBar('OTP yang Anda masukkan salah. Silakan coba lagi.');
      } else {
        showSnackBar('Terjadi kesalahan, coba lagi nanti.');
      }
    } else {
      showSnackBar('Terjadi kesalahan, coba lagi nanti.');
    }
  }

  // Future<void> resendOtp() async {
  //   final otpService = OtpServiceApi();
  //   final response = await otpService.sendOtp(widget.email); // Send OTP

  //   if (response != null && response.containsKey('message')) {
  //     String message = response['message'] ?? 'Unknown error';
  //     showSnackBar(message);
  //   } else {
  //     showSnackBar('Terjadi kesalahan saat mengirim OTP. Coba lagi nanti.');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final email = widget.email;

    return Scaffold(
      appBar: AppBar(title: const Text('Verifikasi OTP')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('OTP Telah dikirim ke email: $email'),
            TextField(
              controller: otpController,
              focusNode: otpFocusNode,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Masukkan OTP'),
            ),
            ElevatedButton(
              onPressed: () {
                String otp = otpController.text;
                if (otp.isNotEmpty) {
                  verifyOtp(otp);
                } else {
                  showSnackBar('OTP tidak boleh kosong!');
                }
              },
              child: const Text('Verifikasi OTP'),
            ),
            // TextButton(
            //   onPressed: () {
            //     resendOtp(); // Kirim ulang OTP
            //   },
            //   child: const Text('Kirim ulang OTP'),
            // ),
          ],
        ),
      ),
    );
  }
}
