import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:velocity_x/velocity_x.dart';

import 'authentications/admin_signin.dart';
import 'constants/colors.dart';

void main() {
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _routerDelegate = VxNavigator(routes: {
    '/': (uri, params) => MaterialPage(
          child: SignInAdmin(),
          //     Dashboard(),
          // LibraryView(width: 900,isSeparate: true,),
          // KATE(),
          //   CreatePDF(),
        ),
    // '/home': (uri, params) {
    //   var title = uri.queryParameters['title'];
    //   // print(title);
    //   return MaterialPage(
    //     child: KATE(title: title ?? 'home'),
    //   );
    // },
    // '/login': (uri, params) {
    //   return MaterialPage(
    //     child: SignInAdmin(),
    //   );
    // },
    // '/home': (uri, params) {
    //   return MaterialPage(
    //     child:  KATE(title: 'home'),
    //   );
    // },
    // '/library': (uri, params) {
    //   return MaterialPage(
    //     child:  KATE(title: 'library'),
    //   );
    // },
    // '/blog': (uri, params) {
    //   return MaterialPage(
    //     child: KATE(title: 'blog'),
    //   );
    // },
    // '/testimonial': (uri, params) {
    //   return MaterialPage(
    //     child: KATE(title: 'testimonial'),
    //   );
    // },
    // '/job': (uri, params) {
    //   return MaterialPage(
    //     child: KATE(title: 'job'),
    //   );
    // },
    // '/course': (uri, params) {
    //   return MaterialPage(
    //     child: KATE(title: 'course'),
    //   );
    // },
    // '/contact': (uri, params) {
    //   return MaterialPage(
    //     child: KATE(title: 'contact'),
    //   );
    // },

    // '/second':(uri,params)=>MaterialPage(child: Test1(),),
    // '/third':(uri,params)=>MaterialPage(child: Test2(),),
  });
  // This widget is the root widget of  application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'KATE',
      theme: ThemeData(
        primaryColor: AppColors.appBar,
      ),
      routeInformationParser: VxInformationParser(),
      routerDelegate: _routerDelegate,
    );
  }
}
