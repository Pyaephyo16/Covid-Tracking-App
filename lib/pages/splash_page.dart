import 'package:covid_track/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:covid_track/extension/push_extension.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {



@override
  void initState() {
    finishSplashFunction();
    super.initState();
  }

    void finishSplashFunction() {
     Future.delayed(Duration(seconds: 2),()async{
      print("work");
      context.pushEnd(HomePage());
  });
  }

  @override
  Widget build(BuildContext context) {
const kAnimationDurationForLogo = Duration(milliseconds: 1000);
    return Scaffold(
      body: Stack(
        children: [
            Positioned(
              child: Center(
                child: TweenAnimationBuilder(
                  duration: kAnimationDurationForLogo,
                  tween: Tween<double>(begin: 0,end: 1),
                  child: Container(
                    height: 44,
                    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Colors.orange,
                    ),
                    child: Center(
                      child: Text("Tracker",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                      ),
                    ),
                  ),
                  builder: ((context,double value, child) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedSize(
                      duration: Duration(milliseconds: 800),
                      child: Container(
                        margin: const EdgeInsets.only(top: 100,right: 4),
                        height: value == 1 ? null : 0.0,
                        child: const Text("Covid",
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 14,
                        top: value * 100,
                        ),
                        child: child,
                    ),
                    ],
                  )
                  ),
                ),
              ),
            ),
            
          Positioned(
              left: 0,
              right: 0,
              top: MediaQuery.of(context).size.height * 0.62,
            child: SpinKitFadingCircle(
              color: Colors.orange,
              size: 48,
              duration: Duration(milliseconds: 1200),
            ),
            ),
        ],
      ),
    );
  }

}