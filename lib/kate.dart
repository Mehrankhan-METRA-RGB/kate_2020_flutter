import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:velocity_x/velocity_x.dart';

import 'adminPanel/backend.dart';
import 'authentications/blog/news_blog.dart';
import 'authentications/client_course_registration.dart';
import 'authentications/jobs/jobs_view.dart';
import 'authentications/library/library_view.dart';
import 'authentications/testimonials/testimonial_view.dart';
import 'authentications/verification.dart';
import 'constants/colors.dart';
import 'constants/data.dart';
import 'constants/urls.dart';
import 'courses/contacts.dart';
import 'courses/gallery.dart';
import 'widgets/blogs_slider.dart';
import 'widgets/card_text.dart';
import 'widgets/footer.dart';
import 'widgets/testimonials_slider.dart';
import 'widgets/training_calender.dart';

class KATE extends StatefulWidget {
  KATE({this.title = 'home'});
  final title;
  @override
  _KATEState createState() => _KATEState();
}

var _height, _width;

class _KATEState extends State<KATE> {
  var isoVal = 1;
  var oshaVal = 1;
  var safetyVal = 1;
  var moreVal = 1;
// var .pageVal='home';
  bool _isPlaying = true;
  CarouselSliderController? _sliderController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sliderController = CarouselSliderController();
  }

  bool? smallSize = false;

  route(toPage) {
    return VxNavigator.of(context).replace(Uri(
      path: '/$toPage',
    ));
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    print(_width);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        elevation: 0,
        leadingWidth: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.appBar,
        actions: [
          Spacer(),
          MaterialButton(
            onPressed: () {
              Connect.mail(
                  email: AppUrl.supportEmail, text: 'Support kateintl.com');
            },
            hoverColor: AppColors.google[3].withOpacity(0.4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.message,
                  size: _width > 500 ? 16 : 12,
                  color: AppColors.google[0],
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  'MESSAGE',
                  style: TextStyle(
                      color: AppColors.textBlack,
                      fontSize: _width > 500 ? 10 : 8),
                ),
              ],
            ),
          ),
          MaterialButton(
            onPressed: () {
              // route('lms');
              Connect.snackBar(context,
                  msg: const Text('This Feature will be available soon....'));
            },
            hoverColor: AppColors.google[3].withOpacity(0.4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.school_outlined,
                  size: _width > 500 ? 16 : 12,
                  color: AppColors.google[1],
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'LMS',
                  style: TextStyle(
                      color: AppColors.textBlack,
                      fontSize: _width > 500 ? 10 : 8),
                ),
              ],
            ),
          ),
          MaterialButton(
            onPressed: () {
              route('job');
            },
            hoverColor: AppColors.google[3].withOpacity(0.4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_outline_rounded,
                  size: _width > 500 ? 16 : 12,
                  color: AppColors.google[2],
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'JOBS',
                  style: TextStyle(
                      color: AppColors.textBlack,
                      fontSize: _width > 500 ? 10 : 8),
                ),
              ],
            ),
          ),
          MaterialButton(
            onPressed: () {
              route('library');
            },
            hoverColor: AppColors.google[3].withOpacity(0.4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.library_books,
                  size: _width > 500 ? 16 : 12,
                  color: AppColors.google[3],
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  'HSE DOCS',
                  style: TextStyle(
                      color: AppColors.textBlack,
                      fontSize: _width > 500 ? 10 : 8),
                ),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
      endDrawer: _width < 944
          ? Drawer(
              semanticLabel: 'Drawer',
              child: ListView(
// Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Image.asset(
                      'assets/logos/kate_logo.png',
                      width: 150,
                      height: 80,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.appBar,
                    ),
                  ),
                  ListTile(
                    title: Text('Home'),
                    subtitle: Text("This is home"),
                    onTap: () {
                      Data.pageVal = 'home';
                      route('home');
                    },
                  ),
                  ListTile(
                      title: Text(Data.courses[0]),
                      subtitle: Text("This is ${Data.courses[0]}"),
                      onTap: () {
                        setState(() {
                          Data.pageVal = 'course';
                          route('course');
                        });
                      }),
                  ListTile(
                      title: Text('ISO 9001'),
                      subtitle: Text(" ${Data.courses[1]}"),
                      onTap: () {
                        setState(() {
                          Data.pageVal = 'course';
                          route('course');
                        });
                      }),
                  ListTile(
                      title: Text('ISO 45001'),
                      subtitle: Text(Data.courses[2]),
                      onTap: () {
                        setState(() {
                          Data.pageVal = 'course';
                        });
                        route('course');
                      }),
                  ListTile(
                      title: Text('ISO 14001'),
                      subtitle: Text(Data.courses[3]),
                      onTap: () {
                        setState(() {
                          Data.pageVal = 'course';
                        });
                        route('course');
                      }),
                  ListTile(
                      title: Text('OSHA (IASP)'),
                      subtitle: Text(Data.courses[4]),
                      onTap: () {
                        setState(() {
                          Data.pageVal = 'course';
                        });
                        route('course');
                      }),
                  ListTile(
                      title: Text('OSHA - 48 Hr'),
                      subtitle: Text(Data.courses[5]),
                      onTap: () {
                        setState(() {
                          Data.pageVal = 'course';
                        });
                        route('course');
                      }),
                  ListTile(
                      title: Text('First Aid '),
                      subtitle: Text(Data.courses[6]),
                      onTap: () {
                        setState(() {
                          Data.pageVal = 'course';
                        });
                        route('course');
                      }),
                  ListTile(
                      title: Text('Fire Safety '),
                      subtitle: Text(Data.courses[7]),
                      onTap: () {
                        setState(() {
                          Data.pageVal = 'course';
                        });
                        route('course');
                      }),
                  ListTile(
                      title: Text('Risk Assessment'),
                      subtitle: Text(Data.courses[8]),
                      onTap: () {
                        setState(() {
                          Data.pageVal = 'course';
                        });
                        route('course');
                      }),
                  ListTile(
                      title: Text('Food Safety'),
                      subtitle: Text(Data.courses[9]),
                      onTap: () {
                        setState(() {
                          Data.pageVal = 'course';
                        });
                      }),
                  ListTile(
                      title: Text('OTHM'),
                      subtitle: Text(Data.courses[10]),
                      onTap: () {
                        setState(() {
                          Data.pageVal = 'course';
                        });
                        route('course');
                      }),
                  ListTile(
                      title: Text('TESTIMONIALS'),
                      onTap: () {
                        route('testimonial');
                      }),
                  ListTile(
                      title: Text('BLOG'),
                      onTap: () {
                        setState(() {
                          Data.pageVal = 'blog';
                        });
                        route('blog');
                      }),
                  ListTile(
                      title: Text('JOBS'),
                      onTap: () {
                        setState(() {
                          Data.pageVal = 'job';
                        });
                        route('job');
                      }),
                  ListTile(
                      title: Text('CONTACT'),
                      onTap: () {
                        setState(() {
                          Data.pageVal = 'contact';
                        });
                        route('contact');
                      }),
                ],
              ),
            )
          : null,
      body: Scrollbar(
        thickness: 8,
        thumbVisibility: true,
        // controller: _controllerOne,
        child: NestedScrollView(
          // controller: _controllerOne,
          scrollBehavior: const ScrollBehavior(),
          // floatHeaderSlivers:true,
          scrollDirection: Axis.vertical,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                leadingWidth: 0,
                toolbarHeight: 50,
                backgroundColor: AppColors.appBar,
                actions: _width > 944
                    ? [
                        Center(
                          child: Container(
                            height: 50,
                            width: _width - 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                MaterialButton(
                                  onPressed: () => setState(() {
                                    Data.pageVal = 'home';
                                    route('home');
                                  }),
                                  hoverColor:
                                      AppColors.google[3].withOpacity(0.9),
                                  child: const Center(
                                    child: Text(
                                      'HOME',
                                      style:
                                          TextStyle(color: AppColors.textBlack),
                                    ),
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: () => setState(() {
                                    Data.pageVal = 'course';
                                    route('course');
                                  }),
                                  hoverColor:
                                      AppColors.google[3].withOpacity(0.9),
                                  child: Center(
                                    child: Text(
                                      Data.courses[0],
                                      style: const TextStyle(
                                          color: AppColors.textBlack),
                                    ),
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: () {},
                                  hoverColor:
                                      AppColors.google[3].withOpacity(0.9),
                                  child: PopupMenuButton(
                                    offset: const Offset(0, 50),
                                    itemBuilder: (BuildContext context) {
                                      return [
                                        PopupMenuItem(
                                          value: 1,
                                          child: Text(Data.courses[1]),
                                          onTap: () => setState(() {
                                            Data.pageVal = 'course';
                                            route('course');
                                          }),
                                        ),
                                        PopupMenuItem(
                                          value: 2,
                                          child: Text(Data.courses[2]),
                                          onTap: () => setState(() {
                                            Data.pageVal = 'course';
                                            route('course');
                                          }),
                                        ),
                                        PopupMenuItem(
                                          value: 3,
                                          child: Text(Data.courses[3]),
                                          onTap: () => setState(() {
                                            Data.pageVal = 'course';
                                            route('course');
                                          }),
                                        ),
                                      ];
                                    },
                                    initialValue: 1,
                                    child: Center(
                                        child: Row(
                                      children: const [
                                        Text(
                                          'ISO ',
                                          style: TextStyle(
                                              color: AppColors.textBlack),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          color: AppColors.textBlack,
                                        )
                                      ],
                                    )),
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: () {},
                                  hoverColor:
                                      AppColors.google[3].withOpacity(0.9),
                                  child: PopupMenuButton(
                                    onSelected: (a) {},
                                    offset: const Offset(0, 50),
                                    itemBuilder: (BuildContext context) {
                                      return [
                                        PopupMenuItem(
                                          value: 2,
                                          child: Text(Data.courses[4]),
                                          onTap: () => setState(() {
                                            Data.pageVal = 'course';
                                            route('course');
                                          }),
                                        ),
                                        PopupMenuItem(
                                          value: 2,
                                          child: Text(Data.courses[5]),
                                          onTap: () => setState(() {
                                            Data.pageVal = 'course';
                                            route('course');
                                          }),
                                        ),
                                      ];
                                    },
                                    initialValue: isoVal,
                                    elevation: 0,
                                    child: Center(
                                        child: Row(
                                      children: const [
                                        Text(
                                          'OSHA ',
                                          style: TextStyle(
                                              color: AppColors.textBlack),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          color: AppColors.textBlack,
                                        )
                                      ],
                                    )),
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: () {},
                                  hoverColor:
                                      AppColors.google[3].withOpacity(0.9),
                                  child: PopupMenuButton(
                                    offset: const Offset(0, 50),
                                    onSelected: (int val) {},
                                    itemBuilder: (BuildContext context) {
                                      return [
                                        PopupMenuItem(
                                          value: 2,
                                          child: Text(Data.courses[6]),
                                          onTap: () => setState(() {
                                            Data.pageVal = 'course';
                                            route('course');
                                          }),
                                        ),
                                        PopupMenuItem(
                                          value: 2,
                                          child: Text(Data.courses[7]),
                                          onTap: () => setState(() {
                                            Data.pageVal = 'course';
                                            route('course');
                                          }),
                                        ),
                                        PopupMenuItem(
                                          value: 2,
                                          child: Text(Data.courses[8]),
                                          onTap: () => setState(() {
                                            Data.pageVal = 'course';
                                            route('course');
                                          }),
                                        ),
                                        PopupMenuItem(
                                          value: 2,
                                          child: Text(Data.courses[9]),
                                          onTap: () => setState(() {
                                            Data.pageVal = 'course';
                                            route('course');
                                          }),
                                        ),
                                      ];
                                    },
                                    initialValue: 1,
                                    elevation: 0,
                                    child: Center(
                                        child: Row(
                                      children: const [
                                        Text(
                                          'Safety ',
                                          style: TextStyle(
                                              color: AppColors.textBlack),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          color: AppColors.textBlack,
                                        )
                                      ],
                                    )),
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: () => setState(() {
                                    Data.pageVal = 'course';
                                    route('course');
                                  }),
                                  hoverColor:
                                      AppColors.google[3].withOpacity(0.9),
                                  child: Center(
                                    child: Text(
                                      Data.courses[10],
                                      style: const TextStyle(
                                          color: AppColors.textBlack),
                                    ),
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: () {},
                                  hoverColor:
                                      AppColors.google[3].withOpacity(0.9),
                                  child: PopupMenuButton(
                                    offset: const Offset(0, 50),
                                    onSelected: (int val) {},
                                    itemBuilder: (BuildContext context) {
                                      return [
                                        PopupMenuItem(
                                          value: 1,
                                          child: Text('BLOGS'),
                                          onTap: () => setState(() {
                                            Data.pageVal = 'blog';
                                            route('blog');
                                          }),
                                        ),
                                        PopupMenuItem(
                                          value: 2,
                                          child: Text('JOBS'),
                                          onTap: () => setState(() {
                                            Data.pageVal = 'job';
                                            route('job');
                                          }),
                                        ),
                                        PopupMenuItem(
                                          value: 3,
                                          child: Text('TESTIMONIALS'),
                                          onTap: () => setState(() {
                                            Data.pageVal = 'testimonial';
                                            route('testimonial');
                                          }),
                                        ),
                                        PopupMenuItem(
                                          value: 2,
                                          child: Text('CONTACTS'),
                                          onTap: () => setState(() {
                                            Data.pageVal = 'contact';
                                            route('contact');
                                          }),
                                        ),
                                      ];
                                    },
                                    initialValue: 1,
                                    elevation: 0,
                                    child: Center(
                                        child: Row(
                                      children: const [
                                        Text(
                                          'MORE',
                                          style: TextStyle(
                                              color: AppColors.textBlack),
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          color: AppColors.textBlack,
                                        )
                                      ],
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]
                    : null,
                expandedHeight: _width > 900.0 ? 500.0 : 300,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  titlePadding: const EdgeInsets.only(bottom: 6),
                  title: Image.asset(
                    'assets/logos/kate_logo.png',
                    width: _width >= 700 ? 200 : 90,
                    height: _width >= 700 ? 140 : 70,
                  ),
                  background: CarouselSlider.builder(
                      controller: _sliderController,
                      unlimitedMode: true,
                      enableAutoSlider: true,
                      // slideIndicator:false,
                      autoSliderDelay: Duration(seconds: 5),
                      slideBuilder: (index) {
                        return Image.asset(
                          'assets/slider/kate_$index.jpg',
                          width: _width,
                          height: _width >= 700 ? 500.0 : 300,
                          fit: BoxFit.fill,
                        );
                      },
                      slideTransform: CubeTransform(),
                      slideIndicator: CircularSlideIndicator(
                        padding: const EdgeInsets.only(
                            bottom: 5, top: 20, right: 15),
                        currentIndicatorColor: AppColors.primary,
                        alignment: Alignment.bottomRight,
                      ),
                      itemCount: 8),
                ),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.only(right: 11, left: 0, top: 50),
            child: Scrollbar(
              thickness: 10,
              thumbVisibility: true,
// controller: _controllerthree,
              child: chooseWidget(widget.title),
            ),
          ),
        ),
      ),
    );
  }

  Widget chooseWidget(page) {
    switch (page) {
      case 'home':
        return SingleChildScrollView(child: HomePage());
        break;
      case 'course':
        return const ClientCourseRegistration(
          isAppBar: false,
          isSeparate: false,
        );
        break;
      case 'blog':
        return BlogsView(
          width: _width >= 800 ? 800 : _width,
          height: _height,
          isSeparate: false,
          isAdmin: false,
        );
        break;
      case 'testimonial':
        return TestimonialsView(
          width: _width >= 800 ? 800 : _width,
          height: _height,
          isSeparate: false,
          isAdmin: false,
        );
        break;
      case 'job':
        return JobsView(
          width: _width >= 800 ? 800 : _width,
          isSeparate: false,
          isAdmin: false,
        );
        break;
      case 'contact':
        return Contacts();
        break;
      case 'gallery':
        return Gallery();
        break;
      case 'library':
        return LibraryView(
          width: _width >= 800 ? 800 : _width,
          isSeparate: true,
          isAdmin: false,
          type: null,
        );
        break;
      case 'bookLibrary':
        return LibraryView(
          width: _width >= 800 ? 800 : _width,
          isSeparate: false,
          isAdmin: false,
          type: 'book',
        );
        break;
      default:
        return SingleChildScrollView(child: HomePage());
        break;
    }
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<AboutModel>> getAbout() async {
    var dio = Dio();
    var response = await dio.get(
      '${AppUrl.temp}fetch/about',
    );
    // print(response.data.toString());
    var encode = jsonEncode(response.data);
    List decode = jsonDecode(encode);
    // print(decode);
    List<AboutModel> unsortedata =
        decode.map((user) => AboutModel.fromJson(user)).toList();

    return unsortedata;
  }

  CarouselSliderController _sliderController = CarouselSliderController();
  // final ScrollController _controllerHome = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sliderController = CarouselSliderController();
  }

  var _height, _width;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        ///verification
        Verification(
          width: _width >= 800 ? 800 : _width - 10,
        ),
        const SizedBox(
          height: 100,
        ),

        ///about kate
        Container(
            width: _width,
            height: _height + 100,
            // color: Colors.blue,
            child: Stack(alignment: Alignment.topCenter, children: [
              Image.asset(
                'assets/images/back_banner.jpg',
                fit: BoxFit.fill,
                height: _height / 1.6,
                width: _width,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                child: Text(
                  'About KATE',
                  style: TextStyle(
                      color: AppColors.text,
                      fontSize: _width >= 800 ? 30 : 20,
                      fontWeight: FontWeight.bold,
                      wordSpacing: 3),
                ),
              ),
              Positioned(
                top: 100,
                child: AppCard(
                  width: _width >= 800 ? 800 : _width * 0.95,
                  heading: ' ',
                  data: const SelectableText.rich(TextSpan(
                      text: 'KATE International',
                      style: TextStyle(fontSize: 17, wordSpacing: 3),
                      children: [
                        TextSpan(
                            text:
                                ''' is an accredited HSE training institute committed to establish itself as a center of excellence in creating and disseminating health and safety knowledge, spreading awareness, training and educating people for betterment of the mankind.\n\n''',
                            style: TextStyle(fontSize: 15, wordSpacing: 3)),
                        TextSpan(
                            text: 'KATE International ',
                            style: TextStyle(fontSize: 17, wordSpacing: 3),
                            children: [
                              TextSpan(
                                  text:
                                      '''is offering all HSE courses under highly professional Occupational Safety, Health, Environment, and Quality Management Advisors, Trainers and Consultants providing high impactful mentoring and coaching services\n\n''',
                                  style: TextStyle(
                                    fontSize: 15,
                                    wordSpacing: 3,
                                  )),
                            ]),
                        TextSpan(
                            text: 'KATE International',
                            style: TextStyle(fontSize: 17, wordSpacing: 3),
                            children: [
                              TextSpan(
                                  text:
                                      ''' provides opportunities for individuals, enterprises, and organizations to help them get the right knowledge, develop the needed skills, learn and implement best HSE business and technology practices, and access resources needed for a healthy and safe working environment.\n\n''',
                                  style: TextStyle(
                                    fontSize: 15,
                                    wordSpacing: 3,
                                  )),
                            ])
                      ])),
                ),
              ),
            ])),

        ///News
        const SizedBox(
          height: 100,
        ),
        Container(
          height: _height,
          width: _width,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.asset(
                'assets/images/banner_1.jpg',
                fit: BoxFit.fill,
                height: _height,
                width: _width,
              ),
              Positioned(
                  top: 10,
                  child: Text(
                    'KATE NEWS ',
                    style: TextStyle(
                        color: AppColors.text,
                        fontSize: _width >= 800 ? 30 : 20,
                        fontWeight: FontWeight.bold,
                        wordSpacing: 3),
                  )),
              BlogSlider(),
            ],
          ),
        ),
        const SizedBox(
          height: 100,
        ),
        const SizedBox(
          height: 100,
        ),

        ///Testimonials
        TestimonialSlider(),
        const SizedBox(
          height: 100,
        ),

        ///Calender
        TrainingCalender(
          isSeparate: false,
          isAdmin: false,
        ),
        const SizedBox(
          height: 100,
        ),

        ///Cards
        Container(
            width: _width,
            height: _height + 100,
            // color: Colors.blue,
            child: Stack(alignment: Alignment.topCenter, children: [
              Image.asset(
                'assets/images/back_banner.jpg',
                fit: BoxFit.fill,
                height: _height / 1.6,
                width: _width,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  'Safety Is A Choice You Make\n&\nThe Key To Safety Is In Your Hands!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: _width >= 800 ? 24 : 18,
                    fontWeight: FontWeight.bold,
                    wordSpacing: 3,
                  ),
                ),
              ),
              Positioned(
                top: 60,
                child: Container(
                    width: _width,
                    height: 700,
                    child: _width >= 800
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              Card(
                                elevation: 2,
                                child: Container(
                                  width: 300,
                                  height: 300,
                                  // margin: EdgeInsets.all(5),

                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                        const Radius.circular(5)),
                                    child: Column(
                                      children: [
                                        Image(
                                          image: AssetImage(
                                            'assets/slider/kate_6.jpg',
                                          ),
                                          // width: _width>=900?_width*30:_width*0.70,
                                          // height:90,
                                          fit: BoxFit.fill,
                                        ),

                                        Container(
                                          // color:AppColors.primary,
                                          padding: EdgeInsets.only(
                                              bottom: 10, left: 5, right: 5),
                                          child: Text(Data.courses[2],
                                              style: TextStyle(fontSize: 20)),
                                        ),

                                        // ignore: sized_box_for_whitespace
                                      ],
                                    ),
                                  ),
                                  // color: Colors.blue,
                                ),
                              ),
                              Spacer(),
                              Card(
                                elevation: 2,
                                child: Container(
                                  width: 300,
                                  height: 300,
                                  // margin: EdgeInsets.all(5),

                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    child: Column(
                                      children: [
                                        const Image(
                                          image: AssetImage(
                                            'assets/slider/kate_3.jpg',
                                          ),
                                          // width: _width>=900?_width*30:_width*0.70,
                                          // height:90,
                                          fit: BoxFit.fill,
                                        ),

                                        Container(
                                          padding: EdgeInsets.only(
                                              bottom: 10, left: 5, right: 5),
                                          child: Text(Data.courses[4],
                                              style: TextStyle(fontSize: 20)),
                                        ),

                                        // ignore: sized_box_for_whitespace
                                      ],
                                    ),
                                  ),
                                  // color: Colors.blue,
                                ),
                              ),
                              Spacer(),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              Card(
                                elevation: 2,
                                child: Container(
                                  width: 250,
                                  height: 300,
                                  // margin: EdgeInsets.all(5),

                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    child: Column(
                                      children: [
                                        const Image(
                                          image: AssetImage(
                                            'assets/slider/kate_6.jpg',
                                          ),
                                          // width: _width>=900?_width*30:_width*0.70,
                                          // height:90,
                                          fit: BoxFit.fill,
                                        ),

                                        Container(
                                          // color:AppColors.primary,
                                          padding: const EdgeInsets.only(
                                              bottom: 10, left: 5, right: 5),
                                          child: Row(
                                            children: [
                                              Text(Data.courses[2],
                                                  style: const TextStyle(
                                                      fontSize: 20)),
                                            ],
                                          ),
                                        ),

                                        // ignore: sized_box_for_whitespace
                                      ],
                                    ),
                                  ),
                                  // color: Colors.blue,
                                ),
                              ),
                              Spacer(),
                              Card(
                                elevation: 2,
                                child: Container(
                                  width: 250,
                                  height: 300,
                                  // margin: EdgeInsets.all(5),

                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    child: Column(
                                      children: [
                                        const Image(
                                          image: AssetImage(
                                            'assets/slider/kate_3.jpg',
                                          ),
                                          // width: _width>=900?_width*30:_width*0.70,
                                          // height:90,
                                          fit: BoxFit.fill,
                                        ),

                                        Container(
                                          padding: EdgeInsets.only(
                                              bottom: 10, left: 5, right: 5),
                                          child: Row(
                                            children: [
                                              Text(Data.courses[0],
                                                  style:
                                                      TextStyle(fontSize: 20)),
                                            ],
                                          ),
                                        ),

                                        // ignore: sized_box_for_whitespace
                                      ],
                                    ),
                                  ),
                                  // color: Colors.blue,
                                ),
                              ),
                              Spacer(),
                            ],
                          )),
              ),
            ])),
        const SizedBox(
          height: 100,
        ),
        Container(
            width: _width,
            height: _height + 100,
            // color: Colors.blue,
            child: Stack(alignment: Alignment.topCenter, children: [
              Image.asset(
                'assets/images/back_banner.jpg',
                fit: BoxFit.fill,
                height: _height / 1.6,
                width: _width,
              ),
              Positioned(
                top: 150,
                child: Container(
                  width: _width >= 800 ? 800 : _width * .93,
                  // height: 900,
                  child: Card(
                    elevation: 2,
                    child: Container(
                      width: _width >= 800 ? 800 : _width * .93,
                      height: 400,
                      // margin: EdgeInsets.all(5),

                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: Image(
                          image: const AssetImage(
                            'assets/images/kat_a.jpg',
                          ),
                          width: _width >= 800 ? 800 : _width * .93,
                          // height:90,
                          // fit: BoxFit.fill,
                        ),

                        // ignore: sized_box_for_whitespace
                      ),
                      // color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ])),
        const SizedBox(
          height: 100,
        ),
        Container(
            width: _width,
            height: _height + 100,
            // color: Colors.blue,
            child: Stack(alignment: Alignment.topCenter, children: [
              Image.asset(
                'assets/images/back_banner.jpg',
                fit: BoxFit.fill,
                height: _height / 1.6,
                width: _width,
              ),
              Positioned(
                top: 150,
                child: Container(
                  width: _width >= 800 ? 800 : _width * .93,
                  // height: 900,
                  child: Card(
                    elevation: 2,
                    child: Container(
                      width: _width >= 800 ? 800 : _width * .93,
                      height: 400,
                      // margin: EdgeInsets.all(5),

                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: Image(
                          image: const AssetImage(
                            'assets/images/kate_b.jpg',
                          ),
                          width: _width >= 800 ? 800 : _width * .93,
                          // height:90,
                          // fit: BoxFit.fill,
                        ),

                        // ignore: sized_box_for_whitespace
                      ),
                      // color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ])),
        const SizedBox(
          height: 100,
        ),
        Container(
            width: _width,
            height: _height + 100,
            // color: Colors.blue,
            child: Stack(alignment: Alignment.topCenter, children: [
              Image.asset(
                'assets/images/back_banner.jpg',
                fit: BoxFit.fill,
                height: _height / 1.6,
                width: _width,
              ),
              Positioned(
                top: 150,
                child: Container(
                  width: _width >= 800 ? 800 : _width * .93,
                  // height: 900,
                  child: Card(
                    elevation: 2,
                    child: Container(
                      width: _width >= 800 ? 800 : _width * .93,
                      height: 400,
                      // margin: EdgeInsets.all(5),

                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: Image(
                          image: const AssetImage(
                            'assets/images/kate_c.jpg',
                          ),
                          width: _width >= 800 ? 800 : _width * .93,
                          // height:90,
                          // fit: BoxFit.fill,
                        ),

                        // ignore: sized_box_for_whitespace
                      ),
                      // color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ])),
        const SizedBox(
          height: 100,
        ),

        ///Why IOSH
        Container(
            width: _width,
            height: _height + 500,
            // // color: Colors.blue,
            child: Stack(alignment: Alignment.topCenter, children: [
              Image.asset(
                'assets/images/back_banner.jpg',
                fit: BoxFit.fill,
                height: _height / 1.6,
                width: _width,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                child: Text(
                  'Why need IOSH Course?',
                  style: TextStyle(
                      color: AppColors.text,
                      fontSize: _width >= 800 ? 30 : 20,
                      fontWeight: FontWeight.bold,
                      wordSpacing: 3),
                ),
              ),
              Positioned(
                top: 100,
                child: AppCard(
                  width: _width >= 900 ? 900 : _width * 0.95,
                  heading: ' ',
                  data: const SelectableText.rich(TextSpan(
                      text:
                          'Benefits of being an approved training provider\n\n',
                      style: TextStyle(fontSize: 20, wordSpacing: 3),
                      children: [
                        TextSpan(
                            text:
                                '''+ Once you’ve been approved, the continued support we give is just one of the benefits of being an IOSH training provider:\n
+ Our course materials are the best available - keeping trainers well informed, updated and motivated\n
+ Our expertise ensures you'll deliver superior training which, means returns on investment for you and your clients\n
+ Our Quality Assurance Team uses National Occupational Standards for Learning and Development to benchmark good training and assessment practice - this gives reassurance to training providers, trainers and delegates\n
+ We have dedicated teams to help with technical training solutions, supporting you to maintain and raise quality standards.\n
+ The role of our Training Quality Assurance Team\n
+ We are here to help you with any aspect of delivering IOSH courses. Our team members are all qualified trainers or assessors wherever possible, and will travel to your premises to quality-assure your training. If we’re unable to visit you, there are options to speak online.\n
''',
                            style: TextStyle(fontSize: 15, wordSpacing: 3)),
                        TextSpan(
                            text:
                                'When we make our quality assurance checks, we will:\n\n',
                            style: TextStyle(fontSize: 20, wordSpacing: 3),
                            children: [
                              TextSpan(
                                  text:
                                      '''+ Ensure you are complying with our terms and conditions\n
+ Check your internal controls, processes, and guidelines against our standards\n
+ Look at your delegate feedback to make sure you’re on track with meeting their expectations\n
+ Look for accuracy and consistency if we’ve sampled your marked assessment papers - we can offer guidance to make you confident in meeting a consistent standard\n
+ Take a look at your training environment\n
+ Give you constructive feedback if we’ve observed a training session, sharing training best practice with you.''',
                                  style: TextStyle(
                                    fontSize: 15,
                                    wordSpacing: 3,
                                  )),
                            ])
                      ])),
                ),
              ),
            ])),

        const SizedBox(
          height: 100,
        ),

        ///Questions about KATE
        Container(
            width: _width,
            child: Stack(alignment: Alignment.topCenter, children: [
              Image.asset(
                'assets/images/back_banner.jpg',
                fit: BoxFit.fill,
                height: _height / 1.6,
                width: _width,
              ),
              Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                    child: Text(
                      'Questions about KATE?',
                      style: TextStyle(
                          color: AppColors.text,
                          fontSize: _width >= 800 ? 30 : 20,
                          fontWeight: FontWeight.bold,
                          wordSpacing: 3),
                    ),
                  ),
                  SizedBox(height: 60),
                  StreamBuilder<List<AboutModel>>(
                      stream: getAbout().asStream(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            width: _width >= 900 ? 900 : _width * 0.95,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 50),
                                  child: AppCard(
                                    width: _width >= 900 ? 900 : _width * 0.95,
                                    heading: ' ',
                                    data: SelectableText.rich(TextSpan(
                                        style: TextStyle(
                                            fontSize: 20, wordSpacing: 3),
                                        children: [
                                          TextSpan(
                                              text:
                                                  '''${snapshot.data![index].question}\n\n''',
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  wordSpacing: 3,
                                                  fontWeight: FontWeight.bold),
                                              children: [
                                                TextSpan(
                                                    text:
                                                        '''${snapshot.data![index].answer}''',
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        wordSpacing: 2,
                                                        fontWeight:
                                                            FontWeight.normal)),
                                              ]),
                                        ])),
                                  ),
                                );
                              },
                            ),
                          );
                        } else if (!snapshot.hasData) {
                          return const Center(child: LinearProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                                'Error occurred while connecting to server!'),
                          );
                        } else {
                          return const Center(child: LinearProgressIndicator());
                        }
                      }),
                ],
              ),
            ])),
        const SizedBox(
          height: 100,
        ),
        Footer(),
      ],
    );
  }
}

class AboutModel {
  final question;
  final id;
  final answer;
  final date;
  AboutModel({this.question, this.answer, this.id, this.date});
  factory AboutModel.fromJson(Map<String, dynamic> json) {
    return AboutModel(
        id: json['id'] as int?,
        question: json['question'] as String?,
        answer: json['answer'] as String?,
        date: json['date'] as String?);
  }
}

//
//
//
// class SideBar extends StatefulWidget {
//   @override
//   _SideBarState createState() => _SideBarState();
// }
//
// class _SideBarState extends State<SideBar> {
//   @override
//   Widget build(BuildContext context) {
//     return  Container( width: _width*0.27,
//         margin:const EdgeInsets.all(5),
//         padding:const EdgeInsets.all(10),
//         decoration:  BoxDecoration(
//           border:Border.all(
//               width: 0.1,
//               color: Colors.black54
//           ),
//
//
//         ),
//         child:Column(children: [
//           Container(height: 500,
//             child: AnimatedTextKit(
//               animatedTexts: [
//                 TypewriterAnimatedText(
//                   '''  Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebaseFlutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebaseFlutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebaseFlutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase',
//
//                                    ''',
//                   textStyle: const TextStyle(
//                     fontSize: 16.0,
//                     // fontWeight: FontWeight.bold,
//                   ),
//                   speed: const Duration(milliseconds: 50),
//                 ),
//               ],
//
//               totalRepeatCount: 200,
//               pause: const Duration(milliseconds: 100),
//               displayFullTextOnTap: true,
//               stopPauseOnTap: true,
//             ),
//           ),
//
//           Container(height: _height/1.5,
//             padding:const EdgeInsets.symmetric(vertical: 4),
//             decoration:  BoxDecoration(
//               border:Border.all(
//                   width: 0.1,
//                   color: Colors.black54
//               ),
//
//
//             ),
//             child: TestimonialsView(width: _width*0.25,height: 500,),
//           ),
//
//
//           AnimatedTextKit(
//             animatedTexts: [
//               TypewriterAnimatedText(
//                 'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android ',
//                 textStyle: const TextStyle(
//                   fontSize: 16.0,
//                   // fontWeight: FontWeight.bold,
//                 ),
//                 speed: const Duration(milliseconds: 100),
//               ),
//             ],
//
//             totalRepeatCount: 200,
//             pause: const Duration(milliseconds: 100),
//             displayFullTextOnTap: true,
//             stopPauseOnTap: true,
//           ),
//
//
//           //   Row(
//           //       mainAxisSize: MainAxisSize.min,
//           //       children: <Widget>[
//           //   const SizedBox(width: 20.0, height: 100.0),
//           //   const Text(
//           //     'Be',
//           //     style: TextStyle(fontSize: 43.0),
//           //   ),
//           //   const SizedBox(width: 20.0, height: 100.0),
//           //   DefaultTextStyle(
//           //     style: const TextStyle(
//           //       fontSize: 14.0,
//           //       fontFamily: 'Horizon',
//           //     ),
//           //     child: AnimatedTextKit(
//           //         animatedTexts: [
//           //           RotateAnimatedText('AWESOME'),
//           //           RotateAnimatedText('OPTIMISTIC'),
//           //           RotateAnimatedText('DIFFERENT'),
//           //         ],
//           //         onTap: () {
//           //   print("Tap Event");
//           //   },
//           //   ),
//           // ),
//           // ],
//           // ),
//
//           // TextLiquidFill(
//           //   text: 'LIQUIDY',
//           //   waveColor: Colors.blueAccent,
//           //   boxBackgroundColor: Colors.redAccent,
//           //   textStyle: TextStyle(
//           //     fontSize: 30.0,
//           //     fontWeight: FontWeight.bold,
//           //   ),
//           //   boxHeight: 300.0,
//           // ),
//
//
//         ],)
//     );
//   }
//   Widget SideBarWidget(){return Container(
//       alignment: Alignment.center,
//       margin: EdgeInsets.only(bottom: 30),
//       width: _width*0.25,
//       child: Card(
//         elevation: 10,
//         shadowColor: Colors.black87,
//         child: ClipRRect(
//           borderRadius:
//           BorderRadius.all(const Radius.circular(5)),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width:_width*0.25,
//                 padding: const EdgeInsets.all(5),
//                 decoration: const BoxDecoration(
//                   border:Border(
//
//                     bottom: BorderSide(width: 0.2, color: Colors.grey),
//                   ),
//                 ),
//                 child: const Text(
//                   'Title',
//                   style: TextStyle(
//                     color: Colors.black87,
//                     // AppColors.text,
//                     fontWeight: FontWeight.w600,
//                     fontSize:
//                     14,
//                   ),
//                 ),
//               ),
//
//               Image(image:const AssetImage('assets/images/b.jpg',),
//                 width: _width*0.25,
//               ),
//
//               Container(
//                 width:_width*0.25,
//                 padding: EdgeInsets.only(bottom: 10,left: 5,right: 5),
//                 child:const ReadMoreText(
//                   '''Using the legacy FadeAnimatedTextKit is equivalent to using AnimatedTextKit with FadeAnimatedText. An advantage of AnimatedTextKit is that the animatedTexts may be any subclass of AnimatedText, while using FadeAnimatedTextKit essentially restricts you to using just FadeAnimatedText.
//
// Legacy AnimatedTextKit classes
// Have you noticed that animation classes come in pairs? For example, there is FadeAnimatedText and FadeAnimatedTextKit. The significant refactoring with Version 3 split the original FadeAnimatedTextKit into FadeAnimatedText and a re-usable AnimatedTextKit, then FadeAnimatedTextKit was adjusted for backwards compatibility.
//
// When introducing a new AnimationText subclass, you may wonder if you also need to also introduce an additional Kit class. The answer is NO. 🎉
//
// Going forward, we are championing the adoption of the Version 3 approach, and have deprecated the legacy Kit classes. This will make creating new animations easier. We know it makes some legacy code more verbose, but the flexibility and simplicity is a conscious trade-off.''',
//                   style: TextStyle(
//                     fontSize:12,
//                   ),
//                   trimLines: 2,
//                   colorClickableText: Colors.deepOrange,
//                   trimMode: TrimMode.Length,
//                   trimCollapsedText: '... SHOW MORE',
//                   trimExpandedText: ' SHOW LESS...',
//                 ),
//               ),
//               Container(
//                 width:_width*0.25,
//                 child: Divider(
//                   height: 14,
//                   color: Colors.redAccent[700],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ));}
// }
// class MainBar extends StatefulWidget {
//
//
//   @override
//   _MainBarState createState() => _MainBarState();
// }
//
// class _MainBarState extends State<MainBar> {
//   var _width,_height;
//
//   @override
//   Widget build(BuildContext context) {
//     _height = MediaQuery.of(context).size.height;
//     _width = MediaQuery.of(context).size.width;
//
//     return Column(
//       // crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         const   SizedBox(
//           height: 30,
//         ),
//         Container(padding: const EdgeInsets.all(30),alignment: Alignment.center,
//
//           child: Verification(width: _width*0.5,),),
//
//         Container(width: _width*0.650,
//           height: 2000,
//           child: Expanded(
//             child: GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2, crossAxisSpacing: 10,mainAxisSpacing: 20,childAspectRatio: 1.3),
//
//               itemBuilder: (context, index) {
//                 return Card(elevation: 2,
//                   child: Container(
//
//                     margin: EdgeInsets.all(5),
//
//                     child: ClipRRect(
//                       borderRadius:
//                       BorderRadius.all(const Radius.circular(5)),
//                       child: Stack(
//
//                         children: [
//
//
//                           Image(image:
//
//                           AssetImage('assets/slider/kate_$index.jpg',),
//                             // width: _width>=900?_width*30:_width*0.70,
//                             // height:90,
//                             fit: BoxFit.fill,
//
//                           ),
//
//                           Positioned(bottom: 0,
//                             child: Container(
//                               // color:AppColors.primary,
//                               padding: EdgeInsets.only(bottom: 10,left: 5,right: 5),
//                               child: Row(
//                                 children: [
//                                   Text(Data.courses[index],style:TextStyle(fontSize: 20)),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           // ignore: sized_box_for_whitespace
//
//                         ],
//                       ),
//                     ),
//                     // color: Colors.blue,
//                   ),
//                 );
//               },
//               itemCount: 8,
//             ),
//           ),
//         ),
//
//
//         const   SizedBox(
//           height: 100,
//         ),
//
//         const SelectableText.rich(
//
//           TextSpan(children: [TextSpan(text:'Hello',style: TextStyle(color: Colors.blue),semanticsLabel: 'Label'),
//             TextSpan(text:'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for '),]),
//           autofocus: true,
//         ),
//         const SizedBox(
//           height: 100,
//         ),
//         const Divider(
//           color: Color(0xFF167F67),
//         ),
//         const SizedBox(
//           height: 100,
//         ),
//         Container(height: _height,
//             child: TrainingCalender(width: _width>1000?_width*0.65:_width,isSeparate: false,isAdmin: false,)),
//         HorizontalListView(width:_width>1000?200:140 ,),
//         const  SizedBox(
//           height: 100,
//         ),
//
//
//       ],
//     );
//   }
// }
