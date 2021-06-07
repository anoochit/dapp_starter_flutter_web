import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';

import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:web3dart/browser.dart';
import 'package:web3dart/web3dart.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    connectWallet();
    super.initState();
  }

  EthereumAddress? address;

  connectWallet() async {
    final eth = window.ethereum;
    if (eth == null) {
      print('MetaMask is not available');
      return;
    }

    final client = Web3Client.custom(eth.asRpcService());
    final credentials = await eth.requestAccount();

    // print('Using ${credentials.address}');
    // print('Client is listening: ${await client.getNetworkId()}');
    // print('Client is listening: ${await client.isListeningForNetwork()}');

    setState(() {
      address = credentials.address;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  SiteLogo(title: 'dApp Boilerplate'),
                  Spacer(),
                  (address == null)
                      ? ElevatedButton(
                          child: Text("Connect Wallet".toUpperCase()),
                          style: ButtonStyle(
                            // foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            // backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                //side: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            await connectWallet();
                          },
                        )
                      : JdenticonProfile(address: address)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SiteLogo extends StatelessWidget {
  final String title;
  const SiteLogo({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FlutterLogo(
          size: 48,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 24),
          ),
        )
      ],
    );
  }
}

class JdenticonProfile extends StatelessWidget {
  const JdenticonProfile({
    Key? key,
    required this.address,
  }) : super(key: key);

  final EthereumAddress? address;

  @override
  Widget build(BuildContext context) {
    var strLength = address.toString().length;
    var sub1 = address.toString().substring(0, 4);
    var sub2 = address.toString().substring(strLength - 4, strLength);
    var addrString = sub1 + "..." + sub2;

    return Container(
      height: 40,
      decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(40)),
      child: Row(
        children: [
          CircleAvatar(
            child: SvgPicture.string(Jdenticon.toSvg(address.toString())),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(addrString),
          ),
        ],
      ),
    );
  }
}
