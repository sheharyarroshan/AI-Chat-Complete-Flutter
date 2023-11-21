import 'package:ai_chatty/Model/OpenAppAd.dart';
import 'package:ai_chatty/Utils/constants.dart';
import 'package:ai_chatty/Utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  AppOpenAdManager appOpenAdManager = AppOpenAdManager();
  bool isPaused = false;

  BannerAd? bannerAd;
  BannerAd? bannerAd2;
  bool isLoading = false;
  bool isLoading2 = false;
  BannerAd? bannerAd3;
  bool isLoading3 = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    bannerAd = BannerAd(
        size: AdSize(height: 60, width: 468),
        adUnitId: "ca-app-pub-4954822599754413/7599345309",
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              isLoading = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
          },
        ),
        request: AdRequest());
    bannerAd!.load();

    // banner Ad 2
    bannerAd2 = BannerAd(
        size: AdSize(height: 60, width: 468),
        adUnitId: "ca-app-pub-4954822599754413/7105834360",
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              isLoading2 = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
          },
        ),
        request: AdRequest());
    bannerAd2!.load();

// banner Ad 3
    bannerAd3 = BannerAd(
        size: AdSize(height: 60, width: 468),
        adUnitId: "ca-app-pub-4954822599754413/1811600492",
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              isLoading3 = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
          },
        ),
        request: AdRequest());
    bannerAd3!.load();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appOpenAdManager.loadAd();

    WidgetsBinding.instance.addObserver(this);
    _controller.dispose();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      isPaused = true;
    }
    if (state == AppLifecycleState.resumed && isPaused) {
      print("Resumed==========================");
      appOpenAdManager.showAdIfAvailable();
      isPaused = false;
    }
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );

  @override
  Widget build(BuildContext context) {
    return Theme(
      data:
          ThemeData(primaryIconTheme: const IconThemeData(color: Colors.white)),
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: SingleChildScrollView(
          child: SizedBox(
            height: 600,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
              child: Drawer(
                backgroundColor: purple_clr,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RotationTransition(
                            turns: _animation,
                            child: SvgPicture.asset(
                              "assets/icon.svg",
                              height: 90,
                              width: 90,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Find More',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    AnimationLimiter(
                      child: Column(
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 375),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                          children: [
                            DisplayBox2(heading: 'Business Plans'),
                            const SizedBox(height: 15),
                            DisplayBox2(heading: 'Write Article'),
                            const SizedBox(height: 15),
                            DisplayBox2(heading: 'Write Program'),
                            const SizedBox(height: 15),
                            DisplayBox2(heading: 'Recomendation'),
                            const SizedBox(height: 15),
                            DisplayBox2(heading: 'Marketing'),
                            const SizedBox(height: 15),
                            DisplayBox2(heading: 'Any Question'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Text(
                        'Designed & Created By FinAstra Technologies',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          elevation: 20,
          toolbarHeight: 70,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          backgroundColor: purple_clr,
          title: Row(
            children: [
              SvgPicture.asset(height: 45, width: 45, "assets/icon.svg"),
              const SizedBox(width: 15),
              const Text('Ai Chatty')
            ],
          ),
          actions: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: GestureDetector(
                    onTap: () {
                      showAlertDialog(context);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: nMbtn,
                      child: const Text(
                        'i',
                        style: TextStyle(
                            fontFamily: "Georgia",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Get Innovative Ideas And Grow Your Business',
                  style: TextStyle(
                      letterSpacing: 1,
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Georgia'),
                ),
              ),
              SingleChildScrollView(
                child: AnimationLimiter(
                  child: Column(
                    children: AnimationConfiguration.toStaggeredList(
                      duration: Duration(milliseconds: 375),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: [
                        isLoading2
                            ? Center(
                                child: Container(
                                  width: double.infinity,
                                  height: 80,
                                  color: Colors.white,
                                  child: AdWidget(ad: bannerAd2!),
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(height: 10),
                        DisplayBox(heading: 'Business Ideas'),
                        const SizedBox(height: 12),
                        DisplayBox(heading: 'Business Description'),
                        const SizedBox(height: 12),
                        DisplayBox(heading: 'Auto Generate Unique Article'),
                        const SizedBox(height: 12),
                        DisplayBox(heading: 'Write Any Coding Program'),
                        const SizedBox(height: 12),
                        DisplayBox(heading: 'Innovative Captions'),
                        const SizedBox(height: 12),
                        DisplayBox(heading: 'Assignments'),
                        const SizedBox(height: 12),
                        DisplayBox(heading: 'Ask Any Question in Your Mind'),
                        const SizedBox(height: 20),
                        isLoading
                            ? Center(
                                child: Container(
                                  height: 80,
                                  color: Colors.white,
                                  child: AdWidget(ad: bannerAd!),
                                ),
                              )
                            : const SizedBox(),
                      ],
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

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: purple_clr,
      child: const Text(
        "OK",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // create AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      icon: const Icon(
        Icons.info_outline_rounded,
        color: Colors.green,
        size: 25,
      ),
      title: const Text(
        "Our Goal?",
        style: TextStyle(color: Colors.white),
      ),
      content: const Text(
        "Unlock the full potential of your business with FinAstra AI technologies - where intelligent automation meets unparalleled precision.",
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        Center(child: okButton),
      ],
      backgroundColor: const Color(0xff2B3047),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
