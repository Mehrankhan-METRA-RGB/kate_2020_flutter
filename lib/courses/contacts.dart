import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kate/constants/colors.dart';
import 'package:kate/constants/urls.dart';
import 'package:kate/widgets/footer.dart';

class Contacts extends StatefulWidget {
  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  var _width,_height;
  Future<List<ContactModel>> getContacts() async {
    var dio = Dio();
    var response = await dio.get(
      '${AppUrl.temp}fetch/contact',
    );
    // print(response.data.toString());
    var encode = jsonEncode(response.data);
    List decode = jsonDecode(encode);
     // print(decode);
    List<ContactModel> unsortedata =
    decode.map((user) => ContactModel.fromJson(user)).toList();

    return unsortedata;
  }
  Future<List<AddressModel>> getAddress() async {
    var dio = Dio();
    var response = await dio.get(
      '${AppUrl.temp}fetch/address',
    );
    // print(response.data.toString());
    var encode = jsonEncode(response.data);
    List decode = jsonDecode(encode);
    // print(decode);
    List<AddressModel> unsortedata =
    decode.map((user) => AddressModel.fromJson(user)).toList();

    return unsortedata;
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContacts();
    getAddress();
  }
  @override
  Widget build(BuildContext context) {
    _width=MediaQuery.of(context).size.width;
    _height=MediaQuery.of(context).size.height;

    return Container(width: _width>=900?900:_width*0.95,
      child: ListView(shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              children:  [


                const   SizedBox(height: 100,),
                Card(elevation: 10,shadowColor: Colors.black,color:    AppColors.card,clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(padding:const EdgeInsets.all(2),decoration:  BoxDecoration(gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.topLeft,

                          colors: [
                            AppColors.gradient[0],
                            AppColors.gradient[1],

                          ],
                        )),
                          child: Row(
                            children:const [
                              Text(' CONTACT US',style:  TextStyle(color: AppColors.text,fontSize: 20),),
                            ],
                          ),
                        ),


                        FutureBuilder<List<ContactModel>>(
                            future: getContacts(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                  width: _width>=900?900:_width*0.95,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:const NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context,index){

                                      return  Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(title: Text(snapshot.data![index].contact_title),
                                          subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SelectableText(snapshot.data![index].contact.toString()),
                                              SizedBox(height: 2,),
                                              SelectableText(snapshot.data![index].email.toString()),
                                            ],
                                          ),


                                        ),
                                      );
                                    },

                                  ),
                                );
                              } else if (!snapshot.hasData) {
                                // return const Center(child:  CircularProgressIndicator());
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return const Center(
                                  child: Text(
                                      'Error occurred while connecting to server!'),
                                );
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                            }
                        ),




                      ],),
                  ),
                ),
                const   SizedBox(height: 100,),
                Card(elevation: 10,shadowColor: Colors.black,color:    AppColors.card,clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(padding:const EdgeInsets.all(2),decoration:  BoxDecoration(gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.topLeft,

                          colors: [
                            AppColors.gradient[0],
                            AppColors.gradient[1],

                          ],
                        )),
                          child: Row(
                            children:const [
                              Text('ADDRESSES ',style:  TextStyle(color: AppColors.text,fontSize: 20),),
                            ],
                          ),
                        ),

                        FutureBuilder<List<AddressModel>>(
                            future: getAddress(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                  width: _width>=900?900:_width*0.95,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:const NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context,index){

                                      return   ListTile(title: Text(snapshot.data![index].address_title),
                                        subtitle: SelectableText(snapshot.data![index].address),

                                      );
                                    },

                                  ),
                                );
                              } else if (!snapshot.hasData) {
                                // return const Center(child:  CircularProgressIndicator());
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return const Center(
                                  child: Text(
                                      'Error occurred while connecting to server!'),
                                );
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                            }
                        ),




                      ],),
                  ),
                ),
                const    SizedBox(height: 100,),
                Footer(),
              ],
            ),
    );
  }
}
class ContactModel{
  final contact;
  final id;
  final contact_title;
  final email;
  ContactModel({this.contact,this.contact_title,this.id,this.email});
  factory  ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
        id: json['id'] as int?,
        email: json['email'] as String?,
        contact_title: json['contact_title'] as String?,
        contact: json['contact'] as String?
    );
  }

}
class AddressModel{
  final address;
  final id;
  final address_title;
  final address_sub;
  AddressModel({this.address,this.address_title,this.id,this.address_sub});
  factory  AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
        id: json['id'] as int?,
        address_sub: json['address_sub'] as String?,
        address_title: json['address_title'] as String?,
        address: json['address'] as String?
    );
  }

}
