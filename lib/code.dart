import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CodeView extends StatefulWidget {
  final String slug;
  final String image;
  final Color color;

  const CodeView(
      {Key? key, required this.slug, required this.image, required this.color})
      : super(key: key);

  @override
  State<CodeView> createState() => _CodeViewState();
}

class _CodeViewState extends State<CodeView> {
  late List<String> privateKeys;
  late List<String> ethAddresses;
  late ScrollController _scrollController;
  late int loopIndex;
  late int found;
  late double coin;
  late double rate;
  late Timer _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    privateKeys = [];
    ethAddresses = [];
    _scrollController = ScrollController();
    loopIndex = 0;
    coin = 0;
    rate = 0;
    found = 0;
    _loadLoopIndex();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _loadLoopIndex() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      loopIndex = prefs.getInt('loopIndex') ?? 0;
      coin = prefs.getDouble('coin') ?? 0;
      rate = prefs.getDouble('rate') ?? 0;
      found = prefs.getInt('found') ?? 0;
    });
  }

  void _startTimer() {
    if (!_isRunning) {
      _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
        _generateLines();
      });
      setState(() {
        _isRunning = true;
      });
    }
  }

  void _stopTimer() {
    _timer.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _generateLines() {
    final random = Random();
    setState(() {
      loopIndex++;
      privateKeys.add('PrivateKey: ${_generatePrivateKey(random)}');
      ethAddresses.add('EthAddress: ${_generateEthAddress(random)}');
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
    if (loopIndex >= 1000) {
      _stopTimer();
    }
  }

  String _generatePrivateKey(Random random) {
    const characters = '0123456789abcdef';
    String privateKey = '';
    for (var i = 0; i < 64; i++) {
      privateKey += characters[random.nextInt(characters.length)];
    }
    return privateKey;
  }

  String _generateEthAddress(Random random) {
    const characters = '0123456789abcdef';
    String ethAddress = '0x';
    for (var i = 0; i < 40; i++) {
      ethAddress += characters[random.nextInt(characters.length)];
    }
    ethAddress += '[Balance=0]';
    return ethAddress;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF002A59), Color(0xFF0B4D8A)],
            ),
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 21, 46),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 400,
                child: ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  itemCount: privateKeys.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          privateKeys[index],
                          style: const TextStyle(
                            color: Color.fromRGBO(17, 204, 26, 0.867),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          ethAddresses[index],
                          style: const TextStyle(
                            color: Color.fromARGB(221, 212, 212, 212),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _isRunning ? null : _startTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    child: const Text(
                      'Start',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _isRunning ? _stopTimer : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    child: const Text(
                      'Stop',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 21, 46),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Insp: $loopIndex [Fnd ${found}] = ${(coin * rate).ceil()}\$',
                          style: const TextStyle(
                            color: Color.fromARGB(221, 212, 212, 212),
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: widget.color, // Light background color
                              shape: BoxShape.circle, // Circle shape
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  4.0), // Padding for the image
                              child: Image.asset(
                                widget.image,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 30, 30,
                                    30), // Light background color for the row
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${coin.toStringAsFixed(2)} ${widget.slug} = ${(coin * rate).toStringAsFixed(2)}\$',
                                style: const TextStyle(
                                  color: Color.fromARGB(221, 212, 212, 212),
                                  fontSize: 18, // Increased font size
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
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
