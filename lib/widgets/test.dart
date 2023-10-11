import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:kate/authentications/verification.dart';
import 'package:kate/constants/colors.dart';
import 'package:kate/constants/data.dart';
import 'package:kate/widgets/read_more_text.dart';
import 'package:velocity_x/velocity_x.dart';

import 'card_text.dart';
import 'footer.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Container(
        color: Colors.red,
        child: Center(child: Text('Index Page')),
      )),
    );
  }
}

class Test1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Container(
        color: Colors.indigo,
        child: Center(child: Text('second Page')),
      )),
    );
  }
}

class Test2 extends StatelessWidget {
  var _height, _width;

  List HSE=[{'question':'Why do you need KATE?',
    'answer':'With the new legislation, it is now more imperative to have a health and safety system in place to illustrate that your company has a robust system to support the management of Health and Safety within your company’s workplace at all times. Productivity being a key factor along with minimizing down time, KATE helps managers spread the associated health and safety work load easily to everyone thus maximizing a business’s productivity and focusing on the more important aspects of the company.'},
    {'question':'How accessible is KATE?','answer':'Since KATE is cloud base online system, it can be accessed anytime and anywhere of course with the availability of internet connections and a browsing device. Documents are stored in the system can be retrieved in an instant for any purposes like review, audit or for notifying or giving HSE alerts to other stakeholders or simply dissemination of lesson learned to wider audience. All data that your company has recorded are readily available unlike on a paper base Health and Safety system where the documents could get lost which could turn against your company in times of ACC review or audit.'},
    {'question':'Health and Safety reminders?','answer':'KATE has a reminder system designed to remind you to complete Health and Safety tasks, training, etc. These are set by your manager.'},
    {'question':'Are my data secure in the KATE environment?','answer':'Your data are secured in the KATE environment as it has employed one of the most dependable and consistent server providers around.'},

  ];
  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    CarouselSliderController _sliderController = CarouselSliderController();
    print(_width);
    _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Column(
            children: [
              ///verification
              Container(
                  width: _width,
                  height: _height/2,
                  child: Stack(
alignment: _width>=800?Alignment.center:Alignment.topCenter,
                    children: [
                      Image.asset(
                        'assets/images/back_banner.jpg',
                         width: _width,
                        fit: BoxFit.fitWidth,
                         height: _height/2,
                      ),
                      Center(
                          child: Verification(
                        width: _width * 0.70,
                      )),
                    ],
                  )),
              const SizedBox(
                height: 100,
              ),

              ///Cards
              Container(
                  width: _width,
                  height: _height+100,
                  // color: Colors.blue,
                  child: Stack(children: [
                    Image.asset(
                      'assets/images/back_banner.jpg',
                      fit: BoxFit.fill,
                      height: _height / 1.6,
                      width: _width,
                    ),
                    Positioned(
                      top: 100,
                      child: Container(
                          width: _width,
                          height: 900,
                          child: _width >= 800
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Spacer(),
                                    Card(
                                      elevation: 2,
                                      child: Container(
                                        width: 300,
                                        height: 400,
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
                                                    bottom: 10,
                                                    left: 5,
                                                    right: 5),
                                                child: Row(
                                                  children: [
                                                    Text(Data.courses[2],
                                                        style: TextStyle(
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
                                        width: 300,
                                        height: 400,
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
                                                    bottom: 10,
                                                    left: 5,
                                                    right: 5),
                                                child: Row(
                                                  children: [
                                                    Text(Data.courses[2],
                                                        style: TextStyle(
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
                                                    bottom: 10,
                                                    left: 5,
                                                    right: 5),
                                                child: Row(
                                                  children: [
                                                    Text(Data.courses[2],
                                                        style: TextStyle(
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
                                                    bottom: 10,
                                                    left: 5,
                                                    right: 5),
                                                child: Row(
                                                  children: [
                                                    Text(Data.courses[0],
                                                        style: TextStyle(
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
                                  ],
                                )),
                    ),
                  ])),
              const SizedBox(
                height: 100,
              ),
              ///Why IOSH
              Container(
                    width: _width,
                     height: _height+400,
                    // // color: Colors.blue,
                    child: Stack(alignment: Alignment.topCenter,
                        children: [
                      Image.asset(
                        'assets/images/back_banner.jpg',
                        fit: BoxFit.fill,
                        height: _height / 1.6,
                        width: _width,
                      ),
                          Container(
                            padding:const EdgeInsets.symmetric(vertical: 2,horizontal: 10),

                            child:  Text('Why need IOSH Course?',style:  TextStyle(color: AppColors.text,fontSize: _width>=800?30:20,fontWeight: FontWeight.bold,wordSpacing: 3),),
                          ),
                      Positioned(
                        top: 100,
                        child: AppCard(width: _width>=900?900:_width,
                          heading: ' ',data:
                       const   SelectableText.rich( TextSpan(text:'Benefits of being an approved training provider\n\n',style: TextStyle(fontSize: 20,wordSpacing: 3),
                       children: [
                         TextSpan(text:'''+ Once you’ve been approved, the continued support we give is just one of the benefits of being an IOSH training provider:\n
+ Our course materials are the best available - keeping trainers well informed, updated and motivated\n
+ Our expertise ensures you'll deliver superior training which, means returns on investment for you and your clients\n
+ Our Quality Assurance Team uses National Occupational Standards for Learning and Development to benchmark good training and assessment practice - this gives reassurance to training providers, trainers and delegates\n
+ We have dedicated teams to help with technical training solutions, supporting you to maintain and raise quality standards.\n
+ The role of our Training Quality Assurance Team\n
+ We are here to help you with any aspect of delivering IOSH courses. Our team members are all qualified trainers or assessors wherever possible, and will travel to your premises to quality-assure your training. If we’re unable to visit you, there are options to speak online.\n
''',style: TextStyle(fontSize: 15,wordSpacing: 3)),
                         TextSpan(text:'When we make our quality assurance checks, we will:\n\n',style: TextStyle(fontSize: 20,wordSpacing: 3),
                             children: [
                               TextSpan(text:'''+ Ensure you are complying with our terms and conditions\n
+ Check your internal controls, processes, and guidelines against our standards\n
+ Look at your delegate feedback to make sure you’re on track with meeting their expectations\n
+ Look for accuracy and consistency if we’ve sampled your marked assessment papers - we can offer guidance to make you confident in meeting a consistent standard\n
+ Take a look at your training environment\n
+ Give you constructive feedback if we’ve observed a training session, sharing training best practice with you.''',style: TextStyle(fontSize: 15,wordSpacing: 3,)),

                             ])
                       ]))

                         ,),
                      ),
                    ])),

              const SizedBox(
                height: 100,
              ),
              ///Testimonials
              Container(
                color: AppColors.card,
                width: _width,
                height: _height,
                child: Column(

                  children: [
                    Spacer(),
                    Container(
                      padding:const EdgeInsets.symmetric(vertical: 2,horizontal: 10),

                      child:  Text('TESTIMONIALS ',style:  TextStyle(color: AppColors.textBlack,fontSize: _width>=800?30:20,fontWeight: FontWeight.bold,wordSpacing: 3),),
                    ),
                  // SizedBox(height:50),

                    Spacer(),

                    SizedBox(height:_height-100 ,
                      child: CarouselSlider.builder(
                          controller: _sliderController,
                          unlimitedMode: true,
                          enableAutoSlider: true,
                          autoSliderDelay: Duration(seconds: 5),
                          slideBuilder: (index) {
                            return Container(
                              alignment: Alignment.center,
                              // color: images[index],

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                    child: Container(
                                        width: 60,
                                        height: 60,
                                        alignment: Alignment.center,
                                        color: AppColors.primary,
                                        child:const Icon(
                                          Icons.format_quote,
                                          color: AppColors.card,
                                        )),
                                  ),
                               const   Padding(
                                    padding:  EdgeInsets.all(40.0),
                                    child: Text(
                                      'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for',
                                      textAlign:TextAlign.center,
                                      style: TextStyle(
                                        letterSpacing: 4,
                                        color: Colors.black45,
                                          fontSize: 20,
                                          fontFamily: 'fonts/BebasNeue-Regular.ttf'),
                                    ),
                                  ),
                                  const   Padding(
                                    padding:  EdgeInsets.all(5.0),
                                    child: Text(
                                      'Mehran Ullah Khan',
                                      textAlign:TextAlign.center,
                                      style: TextStyle(
                                          letterSpacing: 3,
                                          color: AppColors.textBlack,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'fonts/Cinzel-ExtraBold.ttf'),
                                    ),
                                  ),
                                  const   Padding(
                                    padding:  EdgeInsets.all(5.0),
                                    child: Text(
                                     'Technical Manager',
                                      textAlign:TextAlign.center,
                                      style: TextStyle(
                                          letterSpacing: 3,
                                          color: Colors.black45,
                                          fontSize: 14,
                                          fontFamily: 'fonts/Comfortaa-Light.ttf'),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },

                          itemCount: 8),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              ///News
              const SizedBox(
                            height: 100,
                          ),
              Container(
                height: _height,
                width: _width,
                child: Stack(alignment: Alignment.bottomCenter,
                  children: [

                    Image.asset(
                      'assets/images/banner_1.jpg',
                      fit: BoxFit.fill,
                      height: _height ,
                      width: _width,
                    ),
                    Positioned(top:10,child: Text('KATE NEWS ',style:  TextStyle(color: AppColors.text,fontSize: _width>=800?30:20,fontWeight: FontWeight.bold,wordSpacing: 3),)),
                    Container(height: _height-100,
                      width: _width,
                      child:  CarouselSlider.builder(
                            controller: _sliderController,
                            unlimitedMode: true,
                            enableAutoSlider: true,
                            viewportFraction: 2,
                            scrollDirection:Axis.horizontal,
                            autoSliderDelay: Duration(seconds: 16),
                            slideBuilder: (index) {
                              return SingleChildScrollView(
                                child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(bottom: 30),
                                    width: _width>=800?800:_width-20,
                                    child: Card(
                                      elevation: 1,
                                      shadowColor: Colors.black87,
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.all(const Radius.circular(5)),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: _width>=800?800:_width-20,
                                              padding: const EdgeInsets.all(5),
                                              decoration: const BoxDecoration(
                                                border:Border(

                                                  bottom: BorderSide(width: 0.2, color: Colors.grey),
                                                ),
                                              ),
                                              child: Text('Flutter is Google’s mobile UI open source framework ',
                                                // snapshot.data![index].title_at!,
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                  // AppColors.text,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:
                                                  _width > 700 ? 18 : 16,
                                                ),
                                              ),
                                            ),

                                            Image(image:
                                            // NetworkImage('http://localhost:8080/$url', scale: 1.0),
                                            //   width: widget.width!=null?widget.width:_width >= 700
                                            //       ? 700
                                            //       : _width,
                                            //   height:_width >= 500
                                            //       ? 350
                                            //       : _width-150,
                                            //
                                            // ),
                                            AssetImage('assets/slider/kate_$index.jpg',),
                                              width: _width>=800?800:_width-20,
                                             height: _height*0.55,

                                            ),
                                            Container(
                                              decoration: const BoxDecoration(
                                                //   border:Border.all(
                                                //     width: 0.2,
                                                //     color: Colors.black
                                                // ),
                                                color: Colors.black12,
                                              ),
                                              alignment: Alignment.centerLeft,
                                              height: 18,
                                              width: _width>=800?800:_width-20,
                                              margin: EdgeInsets.only(bottom: 3,),

                                              child:
                                              Text(
                                                '  Uploaded by '
                                                // '${snapshot.data![index].uploader_at!}'
                                                    ' on'
                                                // ' ${ snapshot.data![index].dateTime_at!.substring(0,16)}'
                                                    '',
                                                style: TextStyle(
                                                    fontSize: _width > 700
                                                        ? 10
                                                        : 9,
                                                    color: Colors.black54),
                                              ),

                                            ),
                                            Container(
                                              width: _width>=800?800:_width-20,
                                              padding: EdgeInsets.only(bottom: 10,left: 5,right: 5),
                                              child: ReadMoreText(
                                                // snapshot.data![index].post_at!,
                                                'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces forFlutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces forFlutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces forFlutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for',
                                                style: TextStyle(
                                                  fontSize:
                                                  _width > 700 ? 15 : 13,
                                                ),
                                                trimLines: 2,
                                                colorClickableText: Colors.deepOrange,
                                                trimMode: TrimMode.Length,
                                                trimCollapsedText: '... SHOW MORE',
                                                trimExpandedText: ' SHOW LESS...',
                                              ),
                                            ),
                                            // ignore: sized_box_for_whitespace
                                            Container(
                                              width: _width>=800?800:_width-20,
                                              child: Divider(
                                                height: 5,
                                                color: Colors.redAccent[700],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              );
                            },

                            itemCount: 8),

                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 100,
              ),
///about KATE
              Container(
                  width: _width,
                  height: _width>=670?_height+400:_height+600,
                  // // color: Colors.blue,
                  child: Stack(alignment: Alignment.topCenter,
                      children: [
                        Image.asset(
                          'assets/images/back_banner.jpg',
                          fit: BoxFit.fill,
                          height: _height / 1.6,
                          width: _width,
                        ),
                        Container(
                          padding:const EdgeInsets.symmetric(vertical: 2,horizontal: 10),

                          child:  Text('Questions about KATE?',style:  TextStyle(color: AppColors.text,fontSize: _width>=800?30:20,fontWeight: FontWeight.bold,wordSpacing: 3),),
                        ),
                        Positioned(
                          top: 100,
                          child: Column(
                            children: [
                              for(var i=0;i<=HSE.length-1;i++)
                              AppCard(width: _width>=900?900:_width,
                                heading: ' ',data:

                                       SelectableText.rich( TextSpan(style: TextStyle(fontSize: 20,wordSpacing: 3),
                                        children: [

                                          TextSpan(text:'${HSE[i]['question']}\n\n',style: TextStyle(fontSize: 20,wordSpacing: 3,fontWeight: FontWeight.bold),
                                              children: [
                                                TextSpan(text:HSE[i]['answer'],style: TextStyle(fontSize: 15,wordSpacing: 2,fontWeight: FontWeight.normal)),

                                              ]),
                                        ])),

                                    ),
                              SizedBox(height: 20,),
                            ],
                          ),
                        ),
                      ])),
              Footer(),
            ],
          ),
        ),

    );
  }
}
