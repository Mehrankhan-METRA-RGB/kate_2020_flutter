import 'dart:typed_data';

import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'package:kate/constants/colors.dart';
import 'package:kate/constants/data.dart';
import 'package:kate/widgets/textfield.dart';

import 'backend.dart';

class Edit extends StatefulWidget {
  Edit({required this.type, required this.popData, this.id, this.onPress});
  final String? type;
  final popData;
  final id;
  final ValueChanged? onPress;

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _uploadFormKey = GlobalKey<FormState>();

  TextEditingController?

      ///Testimonials

      _controller_detail = TextEditingController(),
      _controller_name = TextEditingController(),
      _controller_currentCompany = TextEditingController(),

      ///Blogs
      _controller_title = TextEditingController(),
      _controller_post = TextEditingController(),
      _controller_uploader = TextEditingController(),
      _controller_imageUrl = TextEditingController(),
      _controller_dateTime = TextEditingController(),

      ///Jobs
      _controller_from = TextEditingController(),
      _controller_date = TextEditingController(),
      _controller_category = TextEditingController(),
      _controller_region = TextEditingController(),

      ///Calender
      _controller_subtitle = TextEditingController(),
      _controller_endDate = TextEditingController(),
      _controller_loc = TextEditingController(),
      _controller_duration = TextEditingController(),
      _controller_seat_availablity = TextEditingController(),
      _controller_price = TextEditingController(),
      _controller_nic = TextEditingController(),
      _controller_email = TextEditingController(),
      _controller_phone = TextEditingController(),
      _controller_nationality = TextEditingController(),
      _controller_address = TextEditingController();
  var currentFileExtension;
  List abouts = ["Available", " Booked "];
  var image, formatedDate1, formatedDate2;
  var seat_availablity;
  Uint8List? imagebytes;
  FilePickerCross? file;
  String? imagePath;
  List gender = ["Male", "Female", "Other"];
  List abouts1 = ["Ads", "News", "word of mouth"];
  Object? about1;
  Object? selectedGender;
  Object? _trainingMode;
  Object? _trainingLoc;
  Object? _courseChoice;
  var extension,
      _post,
      _title,
      _from,
      _region,
      _category,
      _initdate,
      _enddate,
      _width,
      _currentCompany,
      _detail,
      _name,
      _nationality,
      _height,
      _price,
      _seat,
      _address,
      _email,
      _loc,
      _phone,
      _duration,
      _nic,
      _subtitle,
      genderIndex = 0,
      aboutIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller_detail!.addListener(() {
      setState(() {});
    });
    _controller_name!.addListener(() {
      setState(() {});
    });
    _controller_currentCompany!.addListener(() {
      setState(() {});
    });

    if (widget.type == EditType().testimonials) {
      _controller_name!.text = widget.popData['name'];
      _controller_detail!.text = widget.popData['detail'];
      _controller_currentCompany!.text = widget.popData['companyName'];
      _name = widget.popData['name'];
      _detail = widget.popData['detail'];
      _currentCompany = widget.popData['companyName'];
    } else if (widget.type == EditType().jobs) {
      _controller_title!.text = widget.popData['title_at'];
      _controller_from!.text = widget.popData['from_at'];
      _controller_category!.text = widget.popData['category_at'];
      _controller_region!.text = widget.popData['region_at'];
      _controller_detail!.text = widget.popData['detail_at'];
      _title = widget.popData['title_at'];
      _from = widget.popData['detail_at'];
      _category = widget.popData['category_at'];
      _region = widget.popData['region_at'];
      _detail = widget.popData['detail_at'];
    } else if (widget.type == EditType().blogs) {
      _controller_title!.text = widget.popData['title'];
      _controller_detail!.text = widget.popData['detail'];
      _title = widget.popData['title'];
      _detail = widget.popData['detail'];
    } else if (widget.type == EditType().calenders) {
      _controller_title!.text = widget.popData['title'];
      _controller_subtitle!.text = widget.popData['subtitle'];
      _controller_price!.text = widget.popData['price'];
      _controller_loc!.text = widget.popData['loc'];
      _controller_duration!.text = widget.popData['duration'];
      _initdate = widget.popData['initdate'];
      _enddate = widget.popData['enddate'];

      setState(() {
        _seat = widget.popData['seat'];
      });

      formatedDate1 =
          '${_initdate.toString().substring(0, 4)}-${_initdate.toString().substring(4, 6)}-${_initdate.toString().substring(6, 8)}';
      formatedDate2 =
          '${_enddate.toString().substring(0, 4)}-${_enddate.toString().substring(4, 6)}-${_enddate.toString().substring(6, 8)}';
      _title = widget.popData['title'];
      _subtitle = widget.popData['subtitle'];
      _loc = widget.popData['loc'];
      _price = widget.popData['price'];
      _duration = widget.popData['duration'];
    } else if (widget.type == EditType().studentRequests) {
      _controller_name!.text = widget.popData['name'];
      _name = widget.popData['name'];
      _controller_address!.text = widget.popData['address'];
      _address = widget.popData['address'];
      _controller_nic!.text = widget.popData['NIC'];
      _nic = widget.popData['NIC'];
      _controller_phone!.text = widget.popData['phone'];
      _phone = widget.popData['phone'];
      _controller_email!.text = widget.popData['email'];
      _email = widget.popData['email'];
      _controller_nationality!.text = widget.popData['nationality'];
      _nationality = widget.popData['nationality'];
      _initdate = widget.popData['init_date'];

      formatedDate1 =
          '${_initdate.toString().substring(0, 4)}-${_initdate.toString().substring(4, 6)}-${_initdate.toString().substring(6, 8)}';
      _trainingLoc = widget.popData['trainingLoc'];
      _trainingMode = widget.popData['trainingMode'];
      _courseChoice = widget.popData['courseChoice'];
      selectedGender = widget.popData['gender'];
      about1 = widget.popData['about'];
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller_detail!.dispose();
    _controller_name!.dispose();
    _controller_currentCompany!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    return Container(
      child: widget.type == EditType().testimonials
          ? Form(
              key: _uploadFormKey,
              child: SizedBox(
                width: _width > 800 ? 800 : _width,
                child: Column(
                  children: [
                    SizedBox(
                      width: _width > 800 ? 800 : _width,
                      child: TheTextField(
                        hintText: 'Company Name',
                        controller: _controller_currentCompany,
                        onChange: (a) => setState(() {
                          _currentCompany = a;
                        }),
                      ),
                    ),
                    Container(
                      width: _width > 800 ? 800 : _width,
                      padding: const EdgeInsets.all(15),
                      child: Card(
                        color: AppColors.card,
                        elevation: 10,
                        child: TextFormField(
                          controller: _controller_detail,
                          maxLines: null,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10),
                            hintText: 'Writing testimonial details...',
                            labelText: 'Testimonial details...',
                            border: const UnderlineInputBorder(),
                            alignLabelWithHint: true,
                            hoverColor: AppColors.gradient[0].withOpacity(0.1),
                            focusColor: AppColors.primary,
                            fillColor: AppColors.gradient[0].withOpacity(0.1),
                          ),
                          minLines: 6,
                          showCursor: true,
                          keyboardType: TextInputType.multiline,
                          onChanged: (a) => setState(() {
                            _detail = a;
                          }),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: _width > 800 ? 800 : _width,
                      child: TheTextField(
                        controller: _controller_name,
                        hintText: 'Customer Name',
                        onChange: (a) => setState(() {
                          _name = a;
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: MaterialButton(
                        color: AppColors.gradient[0],
                        onPressed: () async {
                          if (_uploadFormKey.currentState!.validate()) {
                            await Connect.update(data: {
                              'id': '${widget.popData['id']}',
                              'table': 'testimonial',
                              'name': _name,
                              'detail': _detail,
                              'companyName': _currentCompany,
                            }).then((value) {
                              if (value == 200) {
                                Navigator.pop(context);
                              } else {
                                // print(value);
                              }
                            });
                            onChange();
                          }
                        },
                        child: const SizedBox(
                          width: 100,
                          child: Center(
                            child: Text(
                              ' update ',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
          : widget.type == EditType().jobs
              ? Form(
                  key: _uploadFormKey,
                  child: SizedBox(
                    width: _width > 800 ? 800 : _width,
                    child: Column(
                      children: [
                        SizedBox(
                          width: _width > 800 ? 800 : _width,
                          child: TheTextField(
                            controller: _controller_title,
                            hintText: 'Job Title',
                            onChange: (a) => setState(() {
                              _title = a;
                            }),
                          ),
                        ),
                        SizedBox(
                          width: _width > 800 ? 800 : _width,
                          child: TheTextField(
                            controller: _controller_from,
                            hintText: 'Poster Email',
                            onChange: (a) => setState(() {
                              _from = a;
                            }),
                          ),
                        ),
                        SizedBox(
                          width: _width > 800 ? 800 : _width,
                          child: TheTextField(
                            controller: _controller_category,
                            hintText: 'Category',
                            onChange: (a) => setState(() {
                              _category = a;
                            }),
                          ),
                        ),
                        SizedBox(
                          width: _width > 800 ? 800 : _width,
                          child: TheTextField(
                            controller: _controller_region,
                            hintText: 'Region',
                            onChange: (a) => setState(() {
                              _region = a;
                            }),
                          ),
                        ),
                        SizedBox(
                          width: _width > 800 ? 800 : _width,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Card(
                              color: AppColors.card,
                              elevation: 10,
                              child: TextFormField(
                                controller: _controller_detail,
                                maxLines: null,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  hintText: 'Writing job details...',
                                  labelText: 'Job details...',
                                  border: const UnderlineInputBorder(),
                                  // const OutlineInputBorder(
                                  //   borderRadius: BorderRadius.all(
                                  //     Radius.circular(3),
                                  //   ),
                                  // ),
                                  alignLabelWithHint: true,
                                  hoverColor:
                                      AppColors.gradient[0].withOpacity(0.1),
                                  focusColor: AppColors.primary,
                                  fillColor:
                                      AppColors.gradient[0].withOpacity(0.1),
                                ),
                                minLines: 6,
                                showCursor: true,
                                keyboardType: TextInputType.multiline,
                                onChanged: (a) => setState(() {
                                  _detail = a;
                                }),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: MaterialButton(
                            color: AppColors.gradient[0],
                            onPressed: () async {
                              if (_uploadFormKey.currentState!.validate()) {
                                // await uploadJob();
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>Blog_News(),));
                                await Connect.update(data: {
                                  'id': '${widget.popData['id']}',
                                  'table': 'job',
                                  'title': _title,
                                  'from': _from,
                                  'category': _category,
                                  'region': _region,
                                  'detail': _detail,
                                }).then((value) {
                                  if (value == 200) {
                                    Navigator.pop(context);
                                  } else {
                                    // print(value);
                                  }
                                });
                                onChange();
                              }
                            },
                            child: const SizedBox(
                              width: 100,
                              child: Center(
                                child: Text(
                                  'Update Job',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )

              ///Blog's
              : widget.type == EditType().blogs
                  ? Form(
                      key: _uploadFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(
                            height: 29,
                          ),
                          // Card(
                          //   elevation: 10,
                          //   color: AppColors.card,
                          //   child: Container(
                          //     width: _width > 800 ? 800 : _width,
                          //     margin: const EdgeInsets.only(top: 0),
                          //     decoration: const BoxDecoration(
                          //         borderRadius:
                          //             BorderRadius.all(Radius.circular(5)),
                          //         color: AppColors.card),
                          //     child: Stack(
                          //       children: [
                          //         imagebytes != null
                          //             ? Image.memory(
                          //                 imagebytes!,
                          //                 width: _width > 800 ? 800 : _width,
                          //                 height: _width > 800 ? 300 : 200,
                          //                 fit: BoxFit.fitHeight,
                          //               )
                          //             : Image.asset(
                          //                 'assets/logos/kate_logo.png',
                          //                 width: _width > 800 ? 800 : _width,
                          //                 height: _width > 800 ? 300 : 200,
                          //               ),
                          //         Positioned(
                          //           bottom: 20,
                          //           right: 20,
                          //           child: IconButton(
                          //             color: AppColors.gradient[0],
                          //             alignment: Alignment.center,
                          //             onPressed: () async {
                          //               // await  pickIamgeWeb();
                          //
                          //               // currentFileExtension = [
                          //               //   "jpg",
                          //               //   'jpeg',
                          //               //   'png',
                          //               //   'gif'
                          //               // ];
                          //               // image = await ImagePicker()
                          //               //     .pickImage(source: ImageSource.gallery);
                          //               // imagebytes = await image.readAsBytes();
                          //               //
                          //
                          //               setState(() {});
                          //               // await pickImage();
                          //             },
                          //             icon: Icon(
                          //               Icons.camera_alt,
                          //               size: _width > 800 ? 35 : 25,
                          //               color: AppColors.gradient[0],
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            width: _width > 800 ? 800 : _width,
                            // color: AppColors.gradient[1].withOpacity(0.9),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 3,
                                ),
                                Card(
                                  elevation: 10,
                                  color: AppColors.card,
                                  child: TextFormField(
                                    controller: _controller_title,
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                      hintText: 'Writing Title...',
                                      labelText: 'Title...',
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(3),
                                        ),
                                      ),
                                      alignLabelWithHint: true,
                                      hoverColor:
                                          AppColors.card.withOpacity(0.6),
                                      focusColor: AppColors.card,
                                      fillColor: AppColors.card,
                                    ),
                                    minLines: 1,
                                    showCursor: true,
                                    keyboardType: TextInputType.multiline,
                                    onChanged: (a) => setState(() {
                                      _title = a;
                                    }),
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Card(
                                  elevation: 10,
                                  color: AppColors.card,
                                  child: TextFormField(
                                    controller: _controller_detail,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      hintText: 'Writing Blog...',
                                      labelText: 'Blog Text...',
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(3),
                                        ),
                                      ),
                                      alignLabelWithHint: true,
                                      hoverColor: AppColors.gradient[0]
                                          .withOpacity(0.1),
                                      focusColor: AppColors.primary,
                                      fillColor: AppColors.gradient[0]
                                          .withOpacity(0.1),
                                    ),
                                    minLines: 6,
                                    showCursor: true,
                                    keyboardType: TextInputType.multiline,
                                    onChanged: (a) => setState(() {
                                      _detail = a;
                                    }),
                                  ),
                                ),
                                MaterialButton(
                                  color: AppColors.gradient[0],
                                  onPressed: () async {
                                    if (_uploadFormKey.currentState!
                                        .validate()) {
                                      await Connect.update(data: {
                                        'id': '${widget.popData['id']}',
                                        'table': 'blog',
                                        'title': _title,
                                        'detail': _detail,
                                      }).then((value) {
                                        if (value == 200) {
                                          Navigator.pop(context);
                                        }
                                      });
                                    }
                                    onChange();
                                  },
                                  child: Container(
                                    width: 150,
                                    margin: const EdgeInsets.all(7.0),
                                    child: const Center(
                                      child: Text(
                                        'Update',
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )

                  ///Calender
                  : widget.type == EditType().calenders
                      ? Form(
                          key: _uploadFormKey,
                          child: SizedBox(
                            width: _width > 800 ? 800 : _width,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 3,
                                ),
                                Card(
                                  elevation: 10,
                                  color: AppColors.card,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: TextFormField(
                                      controller: _controller_title,
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                        hintText: 'Writing Title...',
                                        labelText: 'Title...',
                                        border: InputBorder.none,
                                        hintStyle: const TextStyle(
                                            color: Colors.black54),
                                        hoverColor:
                                            AppColors.card.withOpacity(0.6),
                                        focusColor: AppColors.card,
                                        fillColor: AppColors.card,
                                      ),
                                      minLines: 1,
                                      showCursor: true,
                                      keyboardType: TextInputType.multiline,
                                      onChanged: (a) => setState(() {
                                        _title = a;
                                      }),
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 10,
                                  color: AppColors.card,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: TextFormField(
                                      controller: _controller_subtitle,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        hintText: 'Writing Subtitle...',
                                        labelText: 'Blog Subtitle...',
                                        border: InputBorder.none,
                                        hintStyle: const TextStyle(
                                            color: Colors.black54),
                                        hoverColor: AppColors.gradient[0]
                                            .withOpacity(0.1),
                                        focusColor: AppColors.primary,
                                      ),
                                      showCursor: true,
                                      keyboardType: TextInputType.multiline,
                                      onChanged: (a) => setState(() {
                                        _subtitle = a;
                                      }),
                                    ),
                                  ),
                                ),

                                ///seat availability
                                Card(
                                  elevation: 10,
                                  shadowColor: Colors.black,
                                  color: AppColors.card,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: DropdownButton(
                                      isExpanded: true,
                                      iconSize: 25,
                                      elevation: 10,
                                      // icon: Icon(Icons.font_download),
                                      hint: const Text('Seat Availability'),
                                      dropdownColor: Colors.white,
                                      value: _seat,
                                      items: const [
                                        DropdownMenuItem(
                                          // enabled: booked!,
                                          child: Text('Booked'),
                                          value: 'Booked',
                                        ),
                                        DropdownMenuItem(
                                          // enabled: avail!,
                                          child: Text('Available'),
                                          value: 'Available',
                                        ),
                                      ],

                                      onChanged: (Object? a) {
                                        setState(() {
                                          _seat = a.toString();

                                          // print('seat:$_seat');
                                        });
                                      },
                                    ),
                                  ),
                                ),

                                ///date
                                Card(
                                  elevation: 10,
                                  shadowColor: Colors.black,
                                  color: AppColors.card,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            return AppColors.gradient[0]
                                                .withOpacity(0.3);
                                          }
                                          if (states.contains(
                                              MaterialState.hovered)) {
                                            return const Color(0xBAD2D1CF);
                                          }
                                          return const Color(
                                              0xE6EFEFEF); // Use the component's default.
                                        }),
                                      ),
                                      onPressed: () {
                                        _showDatePicker('date');
                                      },
                                      child: Container(
                                        height: 55,
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Initial Date',
                                              style: TextStyle(
                                                fontSize:
                                                    _width > 598.0 ? 18 : 11,
                                                color: AppColors.textBlack,
                                              ),
                                            ),
                                            SizedBox(
                                              width: _width > 598.0 ? 20 : 10,
                                            ),
                                            Icon(
                                              Icons.date_range,
                                              size: _width > 598.0 ? 28 : 18,
                                              color: AppColors.iconsBlack,
                                            ),
                                            const Spacer(),
                                            Text(
                                              formatedDate1 ?? 'YY-MM-DD',
                                              style: TextStyle(
                                                fontSize:
                                                    _width > 598.0 ? 20 : 12,
                                                color: AppColors.textBlack,
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                ),

                                ///End Date
                                Card(
                                  elevation: 10,
                                  shadowColor: Colors.black,
                                  color: AppColors.card,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                          if (states.contains(
                                              MaterialState.pressed)) {
                                            return AppColors.gradient[0]
                                                .withOpacity(0.3);
                                          }
                                          if (states.contains(
                                              MaterialState.hovered)) {
                                            return const Color(0xBAD2D1CF);
                                          }
                                          return const Color(
                                              0xE6EFEFEF); // Use the component's default.
                                        }),
                                      ),
                                      onPressed: () {
                                        _showDatePicker('endDate');
                                      },
                                      child: Container(
                                        height: 55,
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Row(
                                          children: [
                                            Text(
                                              'End Date',
                                              style: TextStyle(
                                                fontSize:
                                                    _width > 598.0 ? 18 : 11,
                                                color: AppColors.textBlack,
                                              ),
                                            ),
                                            SizedBox(
                                              width: _width > 598.0 ? 20 : 10,
                                            ),
                                            Icon(
                                              Icons.date_range,
                                              size: _width > 598.0 ? 28 : 18,
                                              color: AppColors.iconsBlack,
                                            ),
                                            const Spacer(),
                                            Text(
                                              formatedDate2 ?? 'YY-MM-DD',
                                              style: TextStyle(
                                                fontSize:
                                                    _width > 598.0 ? 20 : 12,
                                                color: AppColors.textBlack,
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                ),

                                Card(
                                  elevation: 10,
                                  color: AppColors.card,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: TextFormField(
                                      controller: _controller_price,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        hintText: 'Writing new price...',
                                        labelText: 'Price...',
                                        border: InputBorder.none,
                                        hintStyle: const TextStyle(
                                            color: Colors.black54),
                                        hoverColor: AppColors.gradient[0]
                                            .withOpacity(0.1),
                                        focusColor: AppColors.primary,
                                      ),
                                      showCursor: true,
                                      keyboardType: TextInputType.multiline,
                                      onChanged: (a) => setState(() {
                                        _price = a;
                                      }),
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 10,
                                  color: AppColors.card,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: TextFormField(
                                      controller: _controller_duration,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        hintText: 'Writing course duration...',
                                        labelText: 'Duration...',
                                        border: InputBorder.none,
                                        hintStyle: const TextStyle(
                                            color: Colors.black54),
                                        hoverColor: AppColors.gradient[0]
                                            .withOpacity(0.1),
                                        focusColor: AppColors.primary,
                                      ),
                                      showCursor: true,
                                      keyboardType: TextInputType.multiline,
                                      onChanged: (a) => setState(() {
                                        _duration = a;
                                      }),
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 10,
                                  color: AppColors.card,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: TextFormField(
                                      controller: _controller_loc,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        hintText: 'Writing new Location...',
                                        labelText: 'Location...',
                                        border: InputBorder.none,
                                        hintStyle: const TextStyle(
                                            color: Colors.black54),
                                        hoverColor: AppColors.gradient[0]
                                            .withOpacity(0.1),
                                        focusColor: AppColors.primary,
                                      ),
                                      showCursor: true,
                                      keyboardType: TextInputType.multiline,
                                      onChanged: (a) => setState(() {
                                        _loc = a;
                                      }),
                                    ),
                                  ),
                                ),

                                MaterialButton(
                                  color: AppColors.gradient[0],
                                  onPressed: () async {
                                    if (_uploadFormKey.currentState!
                                        .validate()) {
                                      await Connect.update(data: {
                                        'id': '${widget.id}',
                                        'table': 'calender',
                                        'title': _title,
                                        'subtitle': _subtitle,
                                        'initdate': _initdate,
                                        'enddate': _enddate,
                                        'price': _price,
                                        'loc': _loc,
                                        'seat': _seat,
                                        'duration': _duration,
                                      }).then((value) {
                                        if (value == 200) {
                                          Navigator.pop(context);
                                        }
                                      });
                                    }
                                    onChange();
                                  },
                                  child: Container(
                                    width: 150,
                                    margin: const EdgeInsets.all(7.0),
                                    child: const Center(
                                      child: Text(
                                        'Update',
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        )

                      ///student request
                      : widget.type == EditType().studentRequests
                          ? Form(
                              key: _uploadFormKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Personal',
                                          style: TextStyle(
                                              fontSize:
                                                  _width > 598.0 ? 33 : 25),
                                        ),
                                        const Divider(),
                                      ],
                                    ),
                                  ),
                                  TheTextField(
                                    controller: _controller_name,
                                    hintText: 'Full Name',
                                    validator: (a) {},
                                    onChange: (a) => setState(() {
                                      _name = a;
                                    }),
                                  ),
                                  TheTextField(
                                    controller: _controller_address,
                                    hintText: 'Address',
                                    onChange: (a) => setState(() {
                                      _address = a;
                                    }),
                                  ),
                                  TheTextField(
                                    controller: _controller_nic,
                                    hintText: 'NIC',
                                    validator: (a) {
                                      RegExp _numeric = RegExp(r'^-?[0-9]+$');
                                      String? aa;
                                      if (!_numeric.hasMatch(a!)) {
                                        // // print(a);
                                        aa = 'Only Numeric data are allowed';
                                      }
                                      return aa;
                                    },
                                    onChange: (a) => setState(() {
                                      _nic = a;
                                    }),
                                  ),
                                  TheTextField(
                                    controller: _controller_phone,
                                    hintText: 'Phone Number',
                                    validator: (a) {
                                      RegExp _numeric = RegExp(r'^-?[0-9]+$');
                                      String? aa;
                                      if (!_numeric.hasMatch(a!)) {
                                        aa =
                                            'Only numbers allowed in this field';
                                      }
                                      return aa;
                                    },
                                    onChange: (a) => setState(() {
                                      _phone = a;
                                    }),
                                  ),
                                  TheTextField(
                                    controller: _controller_email,
                                    hintText: 'Email',
                                    validator: (a) {
                                      RegExp _email = RegExp(
                                          r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");
                                      String? aa;
                                      if (!_email.hasMatch(a!)) {
                                        aa =
                                            'Enter the Correct Email.  i.e : (abcd@domain.com)';
                                      }
                                      return aa;
                                    },
                                    onChange: (a) => setState(() {
                                      _email = a;
                                    }),
                                  ),
                                  TheTextField(
                                    controller: _controller_nationality,
                                    hintText: 'Nationality',
                                    validator: (a) {
                                      RegExp _numeric =
                                          RegExp(r'^-?[a-zA-Z]+$');
                                      String? aa;
                                      if (!_numeric.hasMatch(a!)) {
                                        aa =
                                            'Numbers & Special character are not allowed in this field';
                                      }
                                      return aa;
                                    },
                                    onChange: (a) => setState(() {
                                      _nationality = a;
                                    }),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 30, horizontal: 5),
                                    child: _width > 598.0
                                        ? Row(
                                            children: <Widget>[
                                              Text(
                                                'Select Gender',
                                                style: TextStyle(
                                                    fontSize: _width > 598.0
                                                        ? 20
                                                        : 16),
                                              ),
                                              const Spacer(),
                                              addRadioButton(0, 'Male'),
                                              addRadioButton(1, 'Female'),
                                              addRadioButton(2, 'Others'),
                                            ],
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              const Text(
                                                'Select Gender',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              const Divider(),
                                              addRadioButton(0, 'Male'),
                                              addRadioButton(1, 'Female'),
                                              addRadioButton(2, 'Others'),
                                            ],
                                          ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Education',
                                          style: TextStyle(
                                              fontSize:
                                                  _width > 598.0 ? 33 : 25),
                                        ),
                                        const Divider(),
                                      ],
                                    ),
                                  ),

                                  ///Training Mode
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 5),
                                    child: Card(
                                      elevation: 10,
                                      shadowColor: Colors.black,
                                      color: AppColors.card,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: DropdownButton(
                                          isExpanded: true,
                                          iconSize: 25,
                                          elevation: 10,
                                          // icon: Icon(Icons.font_download),
                                          hint: const Text(
                                              'Choose Mode of Training'),
                                          dropdownColor: Colors.white,
                                          value: _trainingMode,
                                          items: const [
                                            DropdownMenuItem(
                                              child: Text('Classroom Training'),
                                              value: 'Physical',
                                            ),
                                            DropdownMenuItem(
                                              child: Text('Online Training'),
                                              value: 'Online',
                                            ),
                                          ],

                                          onChanged: (Object? a) {
                                            setState(() {
                                              _trainingMode = a!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),

                                  ///Location of Training
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 5),
                                    child: Card(
                                      elevation: 10,
                                      shadowColor: Colors.black,
                                      color: AppColors.card,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: DropdownButton(
                                          isExpanded: true,
                                          iconSize: 25,
                                          elevation: 9,
                                          // icon: Icon(Icons.font_download),
                                          hint: const Text('Select Location'),
                                          dropdownColor: Colors.white,
                                          value: _trainingLoc,
                                          items: const [
                                            DropdownMenuItem(
                                              child: ListTile(
                                                title: Text('Mardan Shergarh'),
                                              ),
                                              value: 'Shergarh Mardan',
                                            ),
                                          ],

                                          onChanged: (Object? a) {
                                            setState(() {
                                              _trainingLoc = a!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),

                                  ///Course Choice
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 5),
                                    child: Card(
                                      elevation: 10,
                                      shadowColor: Colors.black,
                                      color: AppColors.card,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: DropdownButton(
                                          isExpanded: true,
                                          iconSize: 25,
                                          elevation: 9,
                                          // icon: Icon(Icons.font_download),
                                          hint: const Text('Course Choice'),
                                          dropdownColor: Colors.white,
                                          value: _courseChoice,
                                          items: [
                                            DropdownMenuItem(
                                              child: const Text(
                                                  'IOSH Managing Safety '),
                                              value: Data.courses[0],
                                            ),
                                            DropdownMenuItem(
                                              child: const Text('ISO 9001 QMS'),
                                              value: Data.courses[1],
                                            ),
                                            DropdownMenuItem(
                                              child:
                                                  const Text('ISO 45001 OHSMS'),
                                              value: Data.courses[2],
                                            ),
                                            DropdownMenuItem(
                                              child:
                                                  const Text('ISO 14001 EMS'),
                                              value: Data.courses[3],
                                            ),
                                            DropdownMenuItem(
                                              child: const Text(
                                                  'OSHA (IASP) 30 Hr- General Industry'),
                                              value: Data.courses[4],
                                            ),
                                            DropdownMenuItem(
                                              child: const Text('OSHA - 48 Hr'),
                                              value: Data.courses[5],
                                            ),
                                            DropdownMenuItem(
                                              child: const Text(
                                                  'First Aid Level 2&3'),
                                              value: Data.courses[6],
                                            ),
                                            DropdownMenuItem(
                                              child: const Text(
                                                  'Fire Safety Level 2&3'),
                                              value: Data.courses[7],
                                            ),
                                            DropdownMenuItem(
                                              child: const Text(
                                                  'Risk Assessment Level 2&3'),
                                              value: Data.courses[8],
                                            ),
                                            DropdownMenuItem(
                                              child: const Text('Food Safety'),
                                              value: Data.courses[9],
                                            ),
                                            DropdownMenuItem(
                                              child: const Text(
                                                  'OTHM LEVEL 6 Diploma'),
                                              value: Data.courses[10],
                                            ),
                                          ],

                                          onChanged: (Object? a) {
                                            setState(() {
                                              _courseChoice = a!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 5),
                                      child: Card(
                                        elevation: 10,
                                        shadowColor: Colors.black,
                                        color: AppColors.card,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith<Color>((Set<
                                                              MaterialState>
                                                          states) {
                                                if (states.contains(
                                                    MaterialState.pressed)) {
                                                  return AppColors.gradient[0]
                                                      .withOpacity(0.3);
                                                }
                                                if (states.contains(
                                                    MaterialState.hovered)) {
                                                  return const Color(
                                                      0xBAD2D1CF);
                                                }
                                                return const Color(
                                                    0xE6EFEFEF); // Use the component's default.
                                              }),
                                            ),
                                            onPressed: () {
                                              _showDatePicker('date');
                                            },
                                            child: Container(
                                              height: 55,
                                              padding: const EdgeInsets.only(
                                                  right: 20),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Indicate Date of Training',
                                                    style: TextStyle(
                                                      fontSize: _width > 598.0
                                                          ? 18
                                                          : 11,
                                                      color:
                                                          AppColors.textBlack,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: _width > 598.0
                                                        ? 20
                                                        : 10,
                                                  ),
                                                  Icon(
                                                    Icons.date_range,
                                                    size: _width > 598.0
                                                        ? 28
                                                        : 18,
                                                    color: AppColors.iconsBlack,
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    formatedDate1 != ''
                                                        ? formatedDate1
                                                        : 'YY-MM-DD',
                                                    style: TextStyle(
                                                      fontSize: _width > 598.0
                                                          ? 20
                                                          : 12,
                                                      color:
                                                          AppColors.textBlack,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )),
                                      )),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 30, horizontal: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Additional Information',
                                          style: TextStyle(
                                              fontSize:
                                                  _width > 598.0 ? 33 : 25),
                                        ),
                                        const Divider(),
                                        Text(
                                          'How do you hear about Kate International?',
                                          style: TextStyle(
                                            fontSize: _width > 598.0 ? 18 : 16,
                                          ),
                                        ),
                                        aboutRadioButton(0, 'Ads'),
                                        aboutRadioButton(1, 'News'),
                                        aboutRadioButton(2, 'Word of Mouth'),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: MaterialButton(
                                          onPressed: () async {
                                            var data = {
                                              'id': '${widget.popData['id']}',
                                              'table': 'request',
                                              "name": _name,
                                              "address": _address,
                                              "NIC": _nic,
                                              "phoneNo": _phone,
                                              "nationality": _nationality,
                                              "email": _email,
                                              "gender": selectedGender,
                                              "trainingMode": _trainingMode,
                                              "trainingLoc": _trainingLoc,
                                              "courseChoice": _courseChoice,
                                              "about": about1,
                                              "init_date": _initdate,
                                              "end_date":
                                                  Connect.completionDate(
                                                      _initdate)
                                            };
                                            // print(data);
                                            if (_uploadFormKey.currentState!
                                                .validate()) {
                                              await Connect.update(data: data)
                                                  .then((value) {
                                                if (value == 200) {
                                                  Navigator.pop(context);
                                                }
                                              });
                                            }
                                            setState(() {});
                                            onChange();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                              begin: Alignment.topRight,
                                              end: Alignment.topLeft,
                                              colors: [
                                                AppColors.gradient[0],
                                                AppColors.gradient[1],
                                              ],
                                            )),
                                            child: const Row(
                                              children: [
                                                Text(
                                                  'UPDATE REQUEST',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: AppColors.text),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : const Text('No EditType is selected'),
    );
  }

  void onChange() {
    var onchanged = widget.onPress!;
    if (onchanged != null) {
      var a = 0;
      onchanged(a);
    }
  }

  Row addRadioButton(int btnValue, String title) {
    // genderIndex=btnValue;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
            child: Radio(
          activeColor: AppColors.primary,
          value: gender[btnValue],
          groupValue: selectedGender,
          onChanged: (dynamic value) {
            setState(() {
              selectedGender = value;
              // // print(selectedGender);
            });
          },
        )),
        Text(
          title,
          style: const TextStyle(fontSize: 15),
        )
      ],
    );
  }

  Row aboutRadioButton(int btnValue, String title) {
    // aboutIndex=btnValue;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
            child: Radio(
          activeColor: AppColors.primary,
          value: abouts1[btnValue],
          groupValue: about1,
          onChanged: (dynamic value) {
            setState(() {
              about1 = value;
              // // print(about);
            });
          },
        )),
        Text(
          title,
          style: const TextStyle(fontSize: 15),
        )
      ],
    );
  }

  Future<void> _showDatePicker(dateType) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2010, 8),
        lastDate: DateTime(2040, 8));
    if (picked != null) {
      setState(() {
        var numdate = picked.toString().substring(0, 10).replaceAll('-', '');
        // print('picked: $numdate');
        var date = picked.toString().substring(0, 10);
        if (dateType == 'date') {
          _initdate = numdate;
          formatedDate1 = date;
        } else {
          _enddate = numdate;
          formatedDate2 = date;
        }
      });
    }
  }
}

class EditType {
  final String testimonials = 'testimonials';
  final String jobs = 'jobs';
  final String blogs = 'blogs';
  final String calenders = 'calenders';
  final String studentRequests = 'request';
}
