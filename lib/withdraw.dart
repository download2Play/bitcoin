import 'package:bitcoin/widget/withdraw-option.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlockchainStatsScreen extends StatefulWidget {
  @override
  _BlockchainStatsScreenState createState() => _BlockchainStatsScreenState();
}

class _BlockchainStatsScreenState extends State<BlockchainStatsScreen> {
  final List<Map<String, dynamic>> assets = [
    {
      "slug": "BTC",
      'assetPath': 'assets/images/bitcoin.png',
      'color': Colors.orange,
    },
    {
      "slug": "ETH",
      'assetPath': 'assets/images/ethereum_logo.png',
      'color': const Color.fromARGB(255, 168, 206, 238),
    },
    {
      "slug": "BNB",
      'assetPath': 'assets/images/binance.png',
      'color': Colors.yellowAccent,
    },
    {
      "slug": "TRX",
      'assetPath': 'assets/images/tron.png',
      'color': Color.fromARGB(255, 255, 151, 203),
    },
    {
      "slug": "LTC",
      'assetPath': 'assets/images/litecoin.png',
      'color': Color.fromARGB(255, 243, 207, 207),
    },
    {
      "slug": "XRP",
      'assetPath': 'assets/images/ripple.png',
      'color': Color.fromARGB(255, 135, 221, 233),
    },
    {
      "slug": "DOGE",
      'assetPath': 'assets/images/dogecoin.png',
      'color': Color.fromARGB(255, 206, 155, 137),
    },
    {
      "slug": "SOL",
      'assetPath': 'assets/images/solana.png',
      'color': Color.fromARGB(255, 223, 165, 233),
    },
  ];

  Map<String, dynamic> coinValues = {};

  String allTimeValue = "";
  String recently = "";

  @override
  void initState() {
    super.initState();
    _loadCoinValues();
  }

  Future<void> _loadCoinValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      coinValues = {
        "BTC": prefs.getDouble('BTC') ?? 0.0,
        "ETH": prefs.getDouble('ETH') ?? 0.0,
        "BNB": prefs.getDouble('BNB') ?? 0.0,
        "TRX": prefs.getDouble('TRX') ?? 0.0,
        "LTC": prefs.getDouble('LTC') ?? 0.0,
        "XRP": prefs.getDouble('XRP') ?? 0.0,
        "DOGE": prefs.getDouble('DOGE') ?? 0.0,
        "SOL": prefs.getDouble('SOL') ?? 0.0,
      };
      allTimeValue = prefs.getString('allTime') ?? "";
      // "allTime": prefs.getString('allTime') ?? "",
      recently = prefs.getString('recently') ?? "";
    });
  }

  void _showWithdrawOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WithdrawOptionsDialog(onOptionSelected: _performWithdrawal);
      },
    );
  }

  Future<void> _performWithdrawal(String method) async {
    Navigator.of(context).pop(); // Close the options dialog

    // Show a processing dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: const Text('Processing'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Withdrawing via $method...'),
              ],
            ),
          ),
        );
      },
    );

    await Future.delayed(Duration(seconds: 2)); // Simulate delay

    Navigator.of(context).pop(); // Close the processing dialog

    // Show a success dialog with custom animation
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 400),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return AlertDialog(
          title: const Text('Success'),
          content: SuccessTick(animation: animation),
          actions: [],
        );
      },
    );

    // Wait for a few seconds before dismissing the success dialog
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).pop(); // Close the success dialog
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF002A59),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Blockchain',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'STATISTICS ON specific blockchain',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 3.0,
                  mainAxisSpacing: 4.0,
                  childAspectRatio: 5 / 1.8,
                  children: List.generate(
                    assets.length,
                    (index) => StatCard(
                      value: coinValues[assets[index]["slug"]] ?? 0.0,
                      symbol: assets[index]["slug"],
                      color: assets[index]["color"],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'STATISTICS ON BLOCKCHAIN DISCOVERED',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 2.0),
                      child: DashboardCard(
                        title: "${allTimeValue}\$",
                        subtitle: "all time",
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: DashboardCard(
                        title: "${recently}\$",
                        subtitle: "recently",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: _showWithdrawOptions,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text(
                    'WITHDRAW',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final double value;
  final String symbol;
  final Color color;

  StatCard({
    required this.value,
    required this.symbol,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[900],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${value.toStringAsFixed(2)}\$",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  symbol,
                  style: TextStyle(
                    color: color,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Text(
              "in all the time",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String subtitle;

  DashboardCard({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: 100,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessTick extends StatelessWidget {
  final Animation<double> animation;

  SuccessTick({required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        // Determine visibility based on animation value
        final bool isVisible = animation.value > 0.5;

        return Visibility(
          visible: isVisible,
          child: Transform.scale(
            scale: Curves.easeInOutBack.transform(animation.value),
            child: Opacity(
              opacity: Curves.easeInOut.transform(animation.value),
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 80,
              ),
            ),
          ),
        );
      },
    );
  }
}
