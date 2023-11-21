import 'package:ai_chatty/Model/AdHelper.dart';
import 'package:ai_chatty/Utils/constants.dart';
import 'package:ai_chatty/Views/ChatScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class DisplayBox extends StatefulWidget {
  late String heading;
  DisplayBox({required this.heading, super.key});

  @override
  State<DisplayBox> createState() => _DisplayBoxState();
}

class _DisplayBoxState extends State<DisplayBox> {
  AdmobHelper admobHelper = new AdmobHelper();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    admobHelper.createInterad();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        admobHelper.showInterad();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChatScreen()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: purple_clr,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(3, 3),
                  blurRadius: 4,
                ),
              ]),
          height: 80,
          child: Center(
            child: Text(
              widget.heading,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 18,
                fontFamily: 'Georgia',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

BoxDecoration nMbox = BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    color: purple_clr,
    boxShadow: [
      BoxShadow(
        color: mCD,
        offset: Offset(10, 10),
        blurRadius: 10,
      ),
      BoxShadow(
        color: mCL,
        offset: Offset(-10, -10),
        blurRadius: 10,
      ),
    ]);

BoxDecoration nMboxInvert = BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    color: purple_clr,
    boxShadow: [
      BoxShadow(
          color: mCL, offset: Offset(3, 3), blurRadius: 3, spreadRadius: -3),
    ]);

BoxDecoration nMboxInvertActive = nMboxInvert.copyWith(color: mCC);

BoxDecoration nMbtn = BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    color: purple_clr,
    boxShadow: [
      BoxShadow(
        color: mCD,
        offset: const Offset(6, 6),
        blurRadius: 2,
      ),
      BoxShadow(
        color: mCD,
        offset: const Offset(-6, -6),
        blurRadius: 2,
      ),
    ]);

class DisplayBox2 extends StatefulWidget {
  late String heading;
  DisplayBox2({required this.heading, super.key});

  @override
  State<DisplayBox2> createState() => _DisplayBox2State();
}

class _DisplayBox2State extends State<DisplayBox2> {
  //AD
  int num_of_attempt_load = 0;
  InterstitialAd? _interstitialAd;
// create interstitial ads
  void createInterad() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-4954822599754413/3702664025',
      request: AdRequest(),
      adLoadCallback:
          InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
        _interstitialAd = ad;
        num_of_attempt_load = 0;
      }, onAdFailedToLoad: (LoadAdError error) {
        num_of_attempt_load + 1;
        _interstitialAd = null;

        if (num_of_attempt_load <= 2) {
          createInterad();
        }
      }),
    );
  }

// show interstitial ads to user
  void showInterad() {
    if (_interstitialAd == null) {
      return;
    }

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) {
      print("ad onAdshowedFullscreen");
    }, onAdDismissedFullScreenContent: (InterstitialAd ad) {
      print("ad Disposed");
      ad.dispose();
    }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError aderror) {
      print('$ad OnAdFailed $aderror');
      ad.dispose();
      createInterad();
    });

    _interstitialAd!.show();

    _interstitialAd = null;
  }

//---------------------------------------------

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createInterad();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showInterad();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChatScreen()),
        );
      },
      child: Container(
        decoration: nMboxInvert,
        height: 45,
        width: 260,
        child: Center(
          child: Text(
            widget.heading,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 15,
              fontFamily: 'Georgia',
            ),
          ),
        ),
      ),
    );
  }
}
