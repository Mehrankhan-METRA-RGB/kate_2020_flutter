import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:kate/authentications/blog/news_blog.dart';
import 'package:kate/constants/urls.dart';
import 'package:kate/widgets/read_more_text.dart';
class BlogSlider extends StatefulWidget {
  @override
  _BlogSliderState createState() => _BlogSliderState();
}

class _BlogSliderState extends State<BlogSlider> {
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
    return    Container(height: _height-100,
      width: _width,
      child:  StreamBuilder <List<BlogModel>>(
          stream: getBlogs().asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CarouselSlider.builder(
                  controller: _sliderController,
                  unlimitedMode: true,
                  enableAutoSlider: true,
                  viewportFraction: 2,
                  scrollDirection:Axis.horizontal,
                  autoSliderDelay: Duration(seconds: 16),
                  slideBuilder: (index) {
                    String? url;
                    var date=snapshot.data![index].dateTime_at!.substring(0,16);
                    var newdate='${date.substring(0,4)}/${date.substring(4,6)}/${date.substring(6,8)}';
                    var newtime='${date.substring(8,10)}:${date.substring(10,12)}:${date.substring(12,14)}';
                    (snapshot.data!).length<1?'url':
                    url = snapshot.data![index].imageUrl_at!
                        .replaceAll('public_html/', '');
                    (snapshot.data!).length<1?1:
                    date = snapshot.data![index].dateTime_at!;

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
                                    child: Text(
                                      snapshot.data![index].title_at!,
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
                                  NetworkImage(url!, scale: 1.0),


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
                                      '  Uploaded by admin '
                                          '${snapshot.data![index].uploader_at!}'
                                          ' on'
                                          ' $newdate'
                                          '   $newtime',
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
                                      snapshot.data![index].post_at!,
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

                  itemCount: snapshot.data!.length);
            } else if (snapshot.hasError) {
              return const Center(
                child: LinearProgressIndicator(),
              );
            } else if (!snapshot.hasData) {
              return const Center(child: LinearProgressIndicator());
            } else {
              return const Center(child: LinearProgressIndicator());
            }

          }
      ),

    );
  }
  Future<List<BlogModel>> getBlogs() async {
    var dio = Dio();
    var response = await dio.get(
      '${AppUrl.temp}fetch/blogs',
    );
    // print(response.data.toString());
    var encode = jsonEncode(response.data);
    List decode = jsonDecode(encode);
    // print(decode);
    List<BlogModel> unsortedata =
    decode.map((user) => BlogModel.fromJson(user)).toList();
    List<BlogModel> list = [];
    for (var date in unsortedata) {
      list.add(date);
    }
    list.sort((a, b) => -a.dateTime_at!.compareTo(b.dateTime_at!));
    return list;
  }


}
