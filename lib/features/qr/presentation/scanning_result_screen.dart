import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code/core/widgets/custom_button.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ScanningResultScreen extends StatelessWidget {
  final String code;
  final Function() closeScreen;

  const ScanningResultScreen({super.key, required this.code, required this.closeScreen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
                onTap: (){
                  closeScreen();
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Image.asset('assets/images/icon2.png'),
                ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(data: code,size: 150,version: QrVersions.auto),
            const SizedBox(height: 10),
            const Text('Scanning Result', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            const SizedBox(height: 10),
            const Text(
              'Proreader will Keep your last 10 days history\nto keep your all scanned history please\npurchase our pro package',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: Colors.grey[200]
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 18.0),
                      child: Image.asset('assets/images/icon3.png'),
                    ),
                    Text(code, style: const TextStyle(fontSize: 16),),
                  ],
                ),
              ),
            ),
            CustomButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: code));
                },
                text: 'Copy'
            ),
          ],
          ),
        ),
      ),
    );
  }
}
