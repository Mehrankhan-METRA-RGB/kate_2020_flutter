import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:kate/authentications/testimonials/testimonial_view.dart';
import 'package:kate/constants/colors.dart';
import 'package:kate/constants/urls.dart';
class TestimonialSlider extends StatefulWidget {
  @override
  _TestimonialSliderState createState() => _TestimonialSliderState();
}

class _TestimonialSliderState extends State<TestimonialSlider> {
  var _height,_width;
  CarouselSliderController _sliderController = CarouselSliderController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sliderController = CarouselSliderController();
  }
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return   Container(
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

          Spacer(),

          SizedBox(height:_height-100 ,
            child: StreamBuilder <List<TestimonialModel>>(
                stream: getTestimonials().asStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CarouselSlider.builder(

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
                                Padding(
                                  padding:  EdgeInsets.all(40.0),
                                  child: Text(
                                    snapshot.data![index].detail!,
                                    textAlign:TextAlign.center,
                                    style:const TextStyle(
                                        letterSpacing: 4,
                                        color: Colors.black45,
                                        fontSize: 20,
                                        fontFamily: 'fonts/BebasNeue-Regular.ttf'),
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.all(5.0),
                                  child: Text(
                                    snapshot.data![index].name!,
                                    textAlign:TextAlign.center,
                                    style:const TextStyle(
                                        letterSpacing: 3,
                                        color: AppColors.textBlack,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'fonts/Cinzel-ExtraBold.ttf'),
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.all(5.0),
                                  child: Text(
                                    snapshot.data![index].companyName!,
                                    textAlign:TextAlign.center,
                                    style:const TextStyle(
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

                        itemCount: snapshot.data!.length);
                  } else if (!snapshot.hasData) {
                    return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            LinearProgressIndicator(),
                            // Text(
                            //     'snapshot has no data\n\n Thread:!snapshot.hasData'),
                          ],
                        ));
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: LinearProgressIndicator(),
                    );
                  } else {
                    return const Center(child: LinearProgressIndicator());
                  }


                }
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
  Future<List<TestimonialModel>> getTestimonials() async {
    var dio = Dio();
    var response= await dio.get(
      '${AppUrl.temp}fetch/testimonials',
    );

    var encode = jsonEncode(response.data);
    List decode = jsonDecode(encode);

    List<TestimonialModel> unsortedata =
    decode.map((user) => TestimonialModel.fromJson(user)).toList();
    List<TestimonialModel> list = [];
    for (var date in unsortedata) {
      list.add(date);
    }
    list.sort((a, b) => -a.date!.compareTo(b.date!));
    return list;
  }


}
