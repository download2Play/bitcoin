import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController _loopIndexController;
  late TextEditingController _coinController;
  late TextEditingController _rateController;
  late TextEditingController _foundController;
  late SharedPreferences _prefs;

  late TextEditingController _BTCController;
  late TextEditingController _ETHController;
  late TextEditingController _BNBController;
  late TextEditingController _TRXController;
  late TextEditingController _LTCController;
  late TextEditingController _XRPController;
  late TextEditingController _DOGEController;
  late TextEditingController _SOLController;
  late TextEditingController _allTimeController;
  late TextEditingController _recentController;

  @override
  void initState() {
    super.initState();
    _loopIndexController = TextEditingController();
    _coinController = TextEditingController();
    _rateController = TextEditingController();
    _foundController = TextEditingController();
    _BTCController = TextEditingController();
    _ETHController = TextEditingController();
    _BNBController = TextEditingController();
    _TRXController = TextEditingController();
    _LTCController = TextEditingController();
    _XRPController = TextEditingController();
    _DOGEController = TextEditingController();
    _SOLController = TextEditingController();
    _allTimeController = TextEditingController();
    _recentController = TextEditingController();
    _loadLoopIndex();
  }

  Future<void> _loadLoopIndex() async {
    _prefs = await SharedPreferences.getInstance();
    if (!mounted) return; // Ensure the widget is still in the tree
    setState(() {
      _loopIndexController.text = (_prefs.getInt('loopIndex') ?? 0).toString();
      _coinController.text = (_prefs.getDouble('coin') ?? 0).toString();
      _rateController.text = (_prefs.getDouble('rate') ?? 0).toString();
      _foundController.text = (_prefs.getInt('found') ?? 0).toString();
      _BTCController.text = (_prefs.getDouble('BTC') ?? 0).toString();
      _ETHController.text = (_prefs.getDouble('ETH') ?? 0).toString();
      _BNBController.text = (_prefs.getDouble('BNB') ?? 0).toString();
      _TRXController.text = (_prefs.getDouble('TRX') ?? 0).toString();
      _LTCController.text = (_prefs.getDouble('LTC') ?? 0).toString();
      _XRPController.text = (_prefs.getDouble('XRP') ?? 0).toString();
      _DOGEController.text = (_prefs.getDouble('DOGE') ?? 0).toString();
      _SOLController.text = (_prefs.getDouble('SOL') ?? 0).toString();
      _allTimeController.text = (_prefs.getString('allTime') ?? "").toString();
      _recentController.text = (_prefs.getString('recently') ?? "").toString();
    });
  }

  @override
  void dispose() {
    _loopIndexController.dispose();
    _coinController.dispose();
    _rateController.dispose();
    _foundController.dispose();
    _BTCController.dispose();
    _ETHController.dispose();
    _BNBController.dispose();
    _TRXController.dispose();
    _LTCController.dispose();
    _XRPController.dispose();
    _DOGEController.dispose();
    _SOLController.dispose();
    _allTimeController.dispose();
    _recentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Start Count:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _loopIndexController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter Start Count',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  int loopIndex = int.tryParse(_loopIndexController.text) ?? 0;
                  _saveLoopIndex(loopIndex);
                },
                child: const Text('Save'),
              ),
              const Text(
                'Set Coin:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _coinController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter Coin',
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  double coin = double.tryParse(_coinController.text) ?? 0;
                  _saveCoin(coin);
                },
                child: const Text('Save'),
              ),
              const Text(
                'Set Rate:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _rateController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter Rate',
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  double rate = double.tryParse(_rateController.text) ?? 0;
                  _saveRate(rate);
                },
                child: const Text('Save'),
              ),
              const Text(
                'Start Found Number:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _foundController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter Found Number',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  int found = int.tryParse(_foundController.text) ?? 0;
                  _saveFound(found);
                },
                child: const Text('Save'),
              ),
              CoinWidget(
                name: "BTC",
                controller: _BTCController,
                saveFunction: _saveBTC,
                context: context,
                assetPath: 'assets/images/bitcoin.png',
                color: Colors.orange,
              ),
              CoinWidget(
                name: "ETH",
                controller: _ETHController,
                saveFunction: _saveETH,
                context: context,
                assetPath: 'assets/images/ethereum_logo.png',
                color: Colors.blue,
              ),
              CoinWidget(
                name: "BNB",
                controller: _BNBController,
                saveFunction: _saveBNB,
                context: context,
                assetPath: 'assets/images/binance.png',
                color: Colors.yellowAccent,
              ),
              CoinWidget(
                name: "TRX",
                controller: _TRXController,
                saveFunction: _saveTRX,
                context: context,
                assetPath: 'assets/images/tron.png',
                color: Colors.white,
              ),
              CoinWidget(
                name: "LTC",
                controller: _LTCController,
                saveFunction: _saveLTC,
                context: context,
                assetPath: 'assets/images/litecoin.png',
                color: Colors.grey,
              ),
              CoinWidget(
                name: "XRP",
                controller: _XRPController,
                saveFunction: _saveXRP,
                context: context,
                assetPath: 'assets/images/ripple.png',
                color: Colors.white,
              ),
              CoinWidget(
                name: "DOGE",
                controller: _DOGEController,
                saveFunction: _saveDOGE,
                context: context,
                assetPath: 'assets/images/dogecoin.png',
                color: Colors.brown,
              ),
              CoinWidget(
                name: "SOL",
                controller: _SOLController,
                saveFunction: _saveSOL,
                context: context,
                assetPath: 'assets/images/solana.png',
                color: Colors.purple,
              ),
              PaymentWidget(
                name: "ALL Time",
                controller: _allTimeController,
                saveFunction: _saveALLTime,
                context: context,
                assetPath: 'assets/images/solana.png',
                color: Colors.purple,
              ),
              PaymentWidget(
                name: "Recently",
                controller: _recentController,
                saveFunction: _saveRecently,
                context: context,
                assetPath: 'assets/images/solana.png',
                color: Colors.purple,
              ),
              SizedBox(
                height: 200,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _saveLoopIndex(int loopIndex) async {
    await _prefs.setInt('loopIndex', loopIndex);
    _showSnackBar('Start Count saved successfully');
  }

  Future<void> _saveCoin(double coin) async {
    await _prefs.setDouble('coin', coin);
    _showSnackBar('Coin saved successfully');
  }

  Future<void> _saveRate(double rate) async {
    await _prefs.setDouble('rate', rate);
    _showSnackBar('Rate saved successfully');
  }

  Future<void> _saveFound(int found) async {
    await _prefs.setInt('found', found);
    _showSnackBar('Start Found Number saved successfully');
  }

  Future<void> _saveBTC(double value) async {
    await _prefs.setDouble('BTC', value);
    _showSnackBar('BTC saved successfully');
  }

  Future<void> _saveETH(double value) async {
    await _prefs.setDouble('ETH', value);
    _showSnackBar('ETH saved successfully');
  }

  Future<void> _saveBNB(double value) async {
    await _prefs.setDouble('BNB', value);
    _showSnackBar('BNB saved successfully');
  }

  Future<void> _saveTRX(double value) async {
    await _prefs.setDouble('TRX', value);
    _showSnackBar('TRX saved successfully');
  }

  Future<void> _saveLTC(double value) async {
    await _prefs.setDouble('LTC', value);
    _showSnackBar('LTC saved successfully');
  }

  Future<void> _saveXRP(double value) async {
    await _prefs.setDouble('XRP', value);
    _showSnackBar('XRP saved successfully');
  }

  Future<void> _saveDOGE(double value) async {
    await _prefs.setDouble('DOGE', value);
    _showSnackBar('DOGE saved successfully');
  }

  Future<void> _saveSOL(double value) async {
    await _prefs.setDouble('SOL', value);
    _showSnackBar('SOL saved successfully');
  }

  Future<void> _saveALLTime(String value) async {
    await _prefs.setString('allTime', value);
    _showSnackBar('All Time payment saved successfully');
  }

  Future<void> _saveRecently(String value) async {
    await _prefs.setString('recently', value);
    _showSnackBar('Recent payment saved successfully');
  }
}

class CoinWidget extends StatelessWidget {
  final String name;
  final TextEditingController controller;
  final Function(double) saveFunction;
  final BuildContext context;
  final String assetPath;
  final Color color;

  CoinWidget({
    required this.name,
    required this.controller,
    required this.saveFunction,
    required this.context,
    required this.assetPath,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(
                assetPath,
                width: 25.0,
                height: 25.0,
              ),
            ),
            SizedBox(width: 10),
            Text(
              'Set $name:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Enter $name',
          ),
        ),
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () {
            double value = double.tryParse(controller.text) ?? 0;
            saveFunction(value);
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}

class PaymentWidget extends StatelessWidget {
  final String name;
  final TextEditingController controller;
  final Function(String) saveFunction;
  final BuildContext context;
  final String assetPath;
  final Color color;

  PaymentWidget({
    required this.name,
    required this.controller,
    required this.saveFunction,
    required this.context,
    required this.assetPath,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(
                assetPath,
                width: 25.0,
                height: 25.0,
              ),
            ),
            SizedBox(width: 10),
            Text(
              'Set $name:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter $name',
          ),
        ),
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () {
            String value = controller.text;
            saveFunction(value);
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
