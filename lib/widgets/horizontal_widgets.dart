import 'package:flutter/material.dart';
import 'package:kate/widgets/read_more_text.dart';

class HorizontalListView extends StatefulWidget {
  final double? width;
  HorizontalListView({this.width});
  @override
  _HorizontalListViewState createState() => _HorizontalListViewState();
}

class _HorizontalListViewState extends State<HorizontalListView> {
  var blog_image = 'assets/images/Business.jpg';
  var blog_title = ' This a business in Amazon';
  var blog_post =
      'Islamia College, Peshawar is a public university located in Peshawar, Khyber Pakhtunkhwa, Pakistan. Founded by the personal initiatives led by Sir S.A. Qayyum and Sir George Roos-Keppel in 1913, it is one of the oldest institutions of higher education in Pakistan, and its historical roots are traced from the culminating point of the Aligarh Movement. The university provides higher learning in arts, languages, humanities, social sciences and modern sciences. In 1950, the University of Peshawar was founded as an offshoot of Islamia College Peshawar, with the later being associated to the university as a constituent college. Initially established as Islamia College, it was granted university status by the Government of Pakistan in 2008; the word college is retained in its title for preserving its historical roots.';
  var _width, _height;
  ScrollController _controllerOne = ScrollController();
  @override
  void initState() {
    //Initialize the  scrollController
    _controllerOne = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    return Container(
      width: _width * 0.70,
      height: 300,
      padding: EdgeInsets.all(5),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.2, color: Colors.grey),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return FutureBuilder(
            builder: (context, snapshot) {
              // print(snapshot.data.toString());
              // print('snapshot:${snapshot.data}');
              // if (snapshot.hasData) {
              return Scrollbar(
                thickness: 10,
                thumbVisibility: true,
                controller: _controllerOne,
                child: ListView.builder(
                    controller: _controllerOne,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      // ignore: valid_regexps

                      // String url=snapshot.data![index].imageUrl_at!.replaceRange(11,12,'//');
// print(url);
                      return Container(
                        child: SingleChildScrollView(
                          child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(bottom: 30),
                              width: widget.width != null
                                  ? widget.width
                                  : constraints.maxWidth >= 700
                                      ? 700
                                      : constraints.maxWidth,
                              child: Card(
                                elevation: 10,
                                shadowColor: Colors.black87,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                      const Radius.circular(5)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: widget.width != null
                                            ? widget.width
                                            : constraints.maxWidth >= 700
                                                ? 700
                                                : constraints.maxWidth,
                                        padding: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                                width: 0.2, color: Colors.grey),
                                          ),
                                        ),
                                        child: Text(
                                          blog_title,
                                          // snapshot.data![index].title_at!,
                                          style: TextStyle(
                                            color: Colors.black87,
                                            // AppColors.text,
                                            fontWeight: FontWeight.w600,
                                            fontSize: constraints.maxWidth > 700
                                                ? 13
                                                : 10,
                                          ),
                                        ),
                                      ),

                                      Image(
                                        image:
                                            // NetworkImage('http://localhost:8080/$url', scale: 1.0),
                                            //   width: widget.width!=null?widget.width:constraints.maxWidth >= 700
                                            //       ? 700
                                            //       : constraints.maxWidth,
                                            //   height:constraints.maxWidth >= 500
                                            //       ? 350
                                            //       : constraints.maxWidth-150,
                                            //
                                            // ),
                                            AssetImage(
                                          blog_image,
                                        ),
                                        width: widget.width != null
                                            ? widget.width
                                            : constraints.maxWidth >= 700
                                                ? 700
                                                : constraints.maxWidth,
                                        // height:constraints.maxWidth >= 500
                                        //     ? 350
                                        //     : constraints.maxWidth-150,
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
                                        width: widget.width != null
                                            ? widget.width
                                            : constraints.maxWidth >= 700
                                                ? 700
                                                : constraints.maxWidth,
                                        margin: EdgeInsets.only(
                                          bottom: 3,
                                        ),
                                        child: Text(
                                          '  Uploaded by '
                                          // '${snapshot.data![index].uploader_at!}'
                                          ' on'
                                          // ' ${ snapshot.data![index].dateTime_at!.substring(0,16)}'
                                          '',
                                          style: TextStyle(
                                              fontSize:
                                                  constraints.maxWidth > 700
                                                      ? 9
                                                      : 7,
                                              color: Colors.black54),
                                        ),
                                      ),
                                      Container(
                                        width: widget.width != null
                                            ? widget.width
                                            : constraints.maxWidth >= 700
                                                ? 700
                                                : constraints.maxWidth,
                                        padding: EdgeInsets.only(
                                            bottom: 10, left: 5, right: 5),
                                        child: ReadMoreText(
                                          // snapshot.data![index].post_at!,
                                          blog_post,
                                          style: TextStyle(
                                            fontSize: constraints.maxWidth > 700
                                                ? 11
                                                : 8,
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
                                        width: widget.width != null
                                            ? widget.width
                                            : constraints.maxWidth >= 700
                                                ? 700
                                                : constraints.maxWidth,
                                        child: Divider(
                                          height: 14,
                                          color: Colors.redAccent[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                      );
                    },
                    itemCount: 10
                    // (snapshot.data)!.length,
                    ),
              );
              // }else if(snapshot.hasError){return const Center(child: Text('Error Occured'),);}else if(!snapshot.hasData){ return const Center(child: CircularProgressIndicator());}else{return const Center(child: CircularProgressIndicator());}
            },
            future: Future.value(),
            // future: getData(),
          );
        },
      ),
    );
  }
}
