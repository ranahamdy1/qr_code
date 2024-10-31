import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  late Box<String> qrBox;

  Future<void> initHive() async {
    await Hive.initFlutter();
    qrBox = await Hive.openBox<String>('qr_codes');
  }

  Future<void> saveScanResult(String code) async {
    await qrBox.add(code);
  }

  List<String> getAllScanResults() {
    return qrBox.values.toList();
  }
}
