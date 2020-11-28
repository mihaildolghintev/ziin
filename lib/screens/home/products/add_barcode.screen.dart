import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:ziin/ui/z_button/z_button.dart';
import 'package:ziin/ui/z_textfield/z_textfield.dart';

class AddBarcodeScreenProps {
  AddBarcodeScreenProps({this.barcode, @required this.productTitle});
  final String barcode;
  final String productTitle;
}

class AddBarcodeScreen extends StatefulWidget {
  AddBarcodeScreen({@required this.props});
  final AddBarcodeScreenProps props;
  @override
  _AddBarcodeScreenState createState() => _AddBarcodeScreenState();
}

class _AddBarcodeScreenState extends State<AddBarcodeScreen> {
  TextEditingController _barcodeController;

  @override
  void initState() {
    super.initState();
    _barcodeController = TextEditingController(
        text: widget.props.barcode != null ? widget.props.barcode : '');
  }

  void _scan() async {
    final String barcode = await FlutterBarcodeScanner.scanBarcode(
      '#ffffff',
      'Отмена',
      false,
      ScanMode.BARCODE,
    );

    if (barcode == '-1') {
      _barcodeController.text = '';
    } else {
      _barcodeController.text = barcode;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          widget.props.productTitle,
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.props.productTitle.toUpperCase(),
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 24.0),
                  ZButton(
                    onPressed: _scan,
                    value: 'Сканировать',
                  ),
                  SizedBox(height: 24.0),
                  ZTextField(
                    controller: _barcodeController,
                    keyboardType: TextInputType.number,
                    hintText: '###########',
                    suffixIcon: Icons.qr_code,
                  ),
                ],
              ),
            ),
            ZButton(
              onPressed: () =>
                  Navigator.of(context).pop(_barcodeController.text),
              value: widget.props.barcode != null ? 'Обновить' : 'Добавить',
            ),
          ],
        ),
      ),
    );
  }
}
