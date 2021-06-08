import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jdenticon_dart/jdenticon_dart.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
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
                  // (address == null)
                  //     ? ElevatedButton(
                  //         child: Text("Connect Wallet".toUpperCase()),
                  //         style: ButtonStyle(
                  //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  //             RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(18.0),
                  //             ),
                  //           ),
                  //         ),
                  //         onPressed: () async {
                  //           await connectWallet();
                  //         },
                  //       )
                  //     : JdenticonProfile(address: address)
                ],
              ),
            ),
            ElevatedButton(onPressed: () {}, child: Text("Test"))
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
          size: 46,
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

  final String? address;

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
