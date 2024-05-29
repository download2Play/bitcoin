import 'package:bitcoin/code.dart';
import 'package:bitcoin/widget/bottom-nav.dart';
import 'package:flutter/material.dart';

class Blockchain extends StatefulWidget {
  const Blockchain({Key? key}) : super(key: key);

  @override
  _BlockchainState createState() => _BlockchainState();
}

class _BlockchainState extends State<Blockchain> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF002A59), Color(0xFF0B4D8A)],
        ),
      ),
      child: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Center(
              child: Text(
                'Select a Blockchain',
                style: TextStyle(
                  fontFamily: "American",
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'This is where you can enable the blockchain you want',
                  style: TextStyle(fontSize: 14.0, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 3.0,
                        mainAxisSpacing: 3.0,
                        childAspectRatio: 9 / 11,
                      ),
                      itemCount: cryptoData.length,
                      itemBuilder: (context, index) {
                        final crypto = cryptoData[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          child: _buildCryptoCard(
                            crypto['assetPath'],
                            crypto['color'],
                            index == _selectedIndex,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Implement your logic here
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CodeView(
                              slug: cryptoData[_selectedIndex!]['slug'],
                              image: cryptoData[_selectedIndex!]['assetPath'],
                              color: cryptoData[_selectedIndex!]['color'])),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                  ),
                  child: const Text(
                    'START',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCryptoCard(String assetPath, Color color, bool selected) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: selected ? Colors.white : Colors.transparent,
          width: 2.0,
        ),
        color: color,
        gradient: selected
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.2),
                  Colors.white.withOpacity(0.05)
                ],
              )
            : null,
      ),
      child: Center(
        child: Image.asset(
          assetPath,
          height: 80,
          width: 80,
        ),
      ),
    );
  }
}

const List<Map<String, dynamic>> cryptoData = [
  {
    "slug": "BTC",
    'assetPath': 'assets/images/bitcoin.png',
    'color': Colors.orange
  },
  {
    "slug": "ETH",
    'assetPath': 'assets/images/ethereum_logo.png',
    'color': Colors.blue
  },
  {
    "slug": "BNB",
    'assetPath': 'assets/images/binance.png',
    'color': Colors.yellowAccent
  },
  {"slug": "TRX", 'assetPath': 'assets/images/tron.png', 'color': Colors.white},
  {
    "slug": "LTC",
    'assetPath': 'assets/images/litecoin.png',
    'color': Colors.grey
  },
  {
    "slug": "XRP",
    'assetPath': 'assets/images/ripple.png',
    'color': Colors.white
  },
  {
    "slug": "DOGE",
    'assetPath': 'assets/images/dogecoin.png',
    'color': Colors.brown
  },
  {
    "slug": "SOL",
    'assetPath': 'assets/images/solana.png',
    'color': Colors.purple
  },
];
