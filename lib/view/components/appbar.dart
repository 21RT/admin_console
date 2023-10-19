import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:moneymaker/controller/getController/components/appbarControl.dart';
import 'package:moneymaker/model/theme/app_constants.dart';

class AppBarAdmin extends StatefulWidget {
  const AppBarAdmin({Key? key, required this.scaffoldKey}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<AppBarAdmin> createState() => _AppBarAdminState();
}

class _AppBarAdminState extends State<AppBarAdmin> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppBarController>(
        builder: (appBarController){
          if(MediaQuery.of(context).size.width>1080){
            widget.scaffoldKey.currentState?.closeEndDrawer();
          }
          final isScroll = appBarController.scrollController.value;
          return Column(
            children: [
              Container(
                height: kSpacing * 4,
                decoration: BoxDecoration(
                  color: isScroll ? Colors.white.withOpacity(0.8) : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                padding:  const EdgeInsets.symmetric(horizontal: kSpacing * 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isScroll
                        ? Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.redAccent
                      ),
                    )
                        : Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.teal
                      ),
                    ),
                    if(MediaQuery.of(context).size.width>1080)
                      Row(
                        children: [
                          const SizedBox(width: kSpacing),
                          const Text("Dashboard", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          const SizedBox(width: kSpacing * 1.5),
                          const Text("Transaction",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(width: kSpacing * 1.5),
                          const Text('Setting',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(width: kSpacing * 1.5),
                          Container(
                            height: 50,
                            width: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: isScroll
                                  ? Colors.transparent
                                  : Colors.white.withOpacity(0.8)
                            ),child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.transparent,
                                child: const Icon(Icons.person, color: Colors.black,),
                              ),
                              Text("Admin Control",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            ],
                          ),
                          ),
                        ],
                      )
                    else
                      GestureDetector(
                        onTap: (){
                          print("TEST");
                          widget.scaffoldKey.currentState?.openEndDrawer();
                        },
                          child: const Icon(Icons.menu, size: 30, color: Colors.black,)),
                  ],
                ),
              ),
            ],
          );
        }
    );
  }
}
