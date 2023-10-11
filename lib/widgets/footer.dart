
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kate/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class Footer extends StatelessWidget {
  Footer({
    this.textSize = 14,
    this.textColor = AppColors.text,
    this.gradientColor = const [Colors.black, Colors.black87],
    this.height = 280,
  });

  final double? textSize;
  final double? height;
  final Color? textColor;
  final List<Color>? gradientColor;
  var _width;
  var _devUrl = 'https://www.fiverr.com/share/Ddmwjo';
  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    return Container(
      height: height!,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        AppColors.card,
        AppColors.background,
      ])),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/back_banner.jpg',
            fit: BoxFit.fill,
            height: height,
            width: _width,
          ),
          Container(
            width: _width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 13.0, top: 30),
                  child: Row(
                    children: [
                      AnimatedTextKit(
                        stopPauseOnTap: true,
                        repeatForever: true,
                        animatedTexts: [
                          WavyAnimatedText(
                            'KATE',
                            speed: const Duration(milliseconds: 1000),
                            textStyle: TextStyle(
                                color: textColor!,
                                fontSize: _width >= 800 ? 23 : 17,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 9),
                          ),
                        ],
                        isRepeatingAnimation: true,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      AnimatedTextKit(
                        stopPauseOnTap: true,
                        repeatForever: true,
                        animatedTexts: [
                          WavyAnimatedText(
                            ' INTERNATIONAL',
                            speed: const Duration(milliseconds: 1200),
                            textStyle: TextStyle(
                                color: textColor!,
                                fontSize: _width >= 800 ? 22 : 16,
                                fontWeight: FontWeight.bold,
                                wordSpacing: 3),
                          ),
                        ],
                        isRepeatingAnimation: true,
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () async {
                    await canLaunch(_devUrl)
                        ? await launch(_devUrl)
                        : throw 'Could not launch $_devUrl';
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Developed by Mehran Ullah Khan from METRA-IT',
                      style: TextStyle(
                          color: textColor!, fontSize: _width >= 800 ? 15 : 12),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          onPressed: ()async {
                            await canLaunch(
                                'https://play.app.goo.gl/?link=https://play.google.com/store/apps/details?id=com.dev.mehran.kate')
                                ? await launch(
                                'https://play.app.goo.gl/?link=https://play.google.com/store/apps/details?id=com.dev.mehran.kate')
                                : throw 'Result not found at the movement';

                          },
                          child: Image.asset(
                            'assets/images/google_play.png',
                            width: 100,
                            height: 35,
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: MaterialButton(
                          onPressed: () {},
                          child: Image.asset(
                            'assets/images/apple_store.png',
                            width: 100,
                            height: 35,
                          ),
                        )),
                    Spacer(),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    IconButton(
                      onPressed: () async {
                        await canLaunch(
                                'https://www.facebook.com/Kateinternational2021/')
                            ? await launch(
                                'https://www.facebook.com/Kateinternational2021/')
                            : throw 'Could not launch ';
                      },
                      // hoverColor: Colors.blue,
                      icon: Image.asset(
                        'assets/logos/fb.png',
                        color: AppColors.card,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {},
                      // hoverColor:  AppColors.gradient[0].withOpacity(0.2),
                      icon: Image.asset(
                        'assets/logos/in.png',
                        color: AppColors.card,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {},
                      // hoverColor:  AppColors.gradient[0].withOpacity(0.2),
                      icon: Image.asset(
                        'assets/logos/twitter.png',
                        color: AppColors.card,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () async{

                          const link = WhatsAppUnilink(
                            phoneNumber: '+92-(310)8893000',
                            text: "Hey! Write your message here",
                          );
                          // Convert the WhatsAppUnilink instance to a string.
                          // Use either Dart's string interpolation or the toString() method.
                          // The "launch" method is part of "url_launcher".
                          await launch('$link');

                      },
                      // hoverColor:  AppColors.gradient[0].withOpacity(0.2),
                      icon: Image.asset(
                        'assets/logos/whatsapp.png',
                       color: AppColors.card,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Copyright © 2021-${DateTime.now().year} All Right Reserved!',
                        style:
                            TextStyle(color: textColor!, fontSize: textSize!),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
