import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code/core/hive_services.dart';
import 'package:qr_code/core/widgets/custom_button.dart';
import 'package:qr_code/features/qr/presentation/scanning_result_screen.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});
  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  bool isScanCompleted = false;
  void closeScreen() {
    isScanCompleted = false;
  }

  final hiveService = HiveService();

  @override
  void initState() {
    super.initState();
    hiveService.initHive();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset('assets/images/icon1.png'),
                    ],
                  ),
                  const Text(
                    'Scan QR code',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Place QR code inside the frame to scan please\navoid shake to get results quickly',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  MobileScanner(
                    onDetect: (BarcodeCapture barcode) async {
                      if (!isScanCompleted && barcode.barcodes.isNotEmpty) {
                        String code = barcode.barcodes.first.rawValue ?? '----';
                        isScanCompleted = true;
                        await hiveService.saveScanResult(code);
                        print("save in hive ${hiveService.getAllScanResults()}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScanningResultScreen(
                              closeScreen: closeScreen,
                              code: code,
                            ),
                          ),
                        );
                        print('Barcode found: $code');
                      }
                    },
                  ),
                  QRScannerOverlay(
                    overlayColor: Colors.white,
                    borderColor: const Color(0xffFE7D55),
                    borderStrokeWidth: 11,
                  ),
                ],
              ),
            ),
            const Text('Scanning Code...', style: TextStyle(color: Colors.grey)),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: CustomButton(onPressed: () {}, text: 'Place Camera Code'),
            ),
          ],
        ),
      ),
    );
  }
}
