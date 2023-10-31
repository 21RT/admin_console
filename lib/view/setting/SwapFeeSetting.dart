import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moneymaker/controller/getController/settingControl/swapControl/swapSettingController.dart';
import 'package:moneymaker/model/theme/app_constants.dart';
import 'package:moneymaker/model/theme/sizebox_wiget.dart';
import 'package:moneymaker/view/components/responsive_builder.dart';

class SwapFeeSetting extends StatefulWidget {
  const SwapFeeSetting({Key? key}) : super(key: key);

  @override
  State<SwapFeeSetting> createState() => _SwapFeeSettingState();
}

class _SwapFeeSettingState extends State<SwapFeeSetting> {
  TextEditingController feeController = TextEditingController();
  List indexPage = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  String showValue = '1';
  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBuilder.isMobile(context);
    return Container(
        width: Get.width,
        height: Get.height,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? kSpacing : kSpacing * 2,
          vertical: kSpacing * 2,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: .4, color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        child: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Swap Fee Setting',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: kSpacing),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                      ),
                      child: Text(
                        DateFormat('d MMMM yyyy HH:mm a').format(DateTime.now()),
                      )),
                  isMobile
                      ? Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey,
                          ),
                          child: DropdownButton(
                            underline: Container(),
                            items: [
                              for(int i =0; i< indexPage.length; i++)
                                DropdownMenuItem(
                                  child: Text(indexPage[i]),
                                  value: indexPage[i],
                                )
                            ], onChanged: (Object? value) {
                              setState(() {
                                showValue = value.toString();
                              });
                          },
                          ),
                        )
                      : Container(
                    height: 40,width: 200,
                    // color: Colors.teal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey,
                          ),child: Center(child: FaIcon(FontAwesomeIcons.anglesLeft,color: Colors.white,)),
                        ),
                        Container(
                          width: 80,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey,
                          ),child: Center(child: Text('หน้า 1',style: TextStyle(
                          color: Colors.white),)),),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey,
                          ),child: Center(child: FaIcon(FontAwesomeIcons.anglesRight,color: Colors.white,))
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: kSpacing),
              Container(
                height: Get.height * 0.8,
                child: GetBuilder<SwapSettingController>(
                  init: SwapSettingController(),
                  builder: (swap) => ListView.builder(
                    itemCount: swap.swapSetting.length,
                    itemBuilder: (context, index) => Container(
                      height: 90,
                      width: Get.width,
                      decoration: BoxDecoration(
                        color:
                            index % 2 == 0 ? Colors.grey.shade100 : Colors.white,
                        borderRadius: BorderRadius.circular(kBorderRadius),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  S.W(20),
                                  Center(
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image:
                                              AssetImage(swap.swapSetting[index]["icon"]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  S.W(10),
                                  Center(child: Text(swap.swapSetting[index]['code'])),
                                ],
                              ),
                              Padding(
                                padding:  EdgeInsets.only(left: 20,top: 20),
                                child: Container(
                                  width: 100,
                                    child: Text('~ ${swap.swapSetting[index]['currency'].toString()}')),
                              ),
                            ],
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Center(child: FaIcon(FontAwesomeIcons.arrowRight)),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  S.W(20),
                                  Center(
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image:
                                          AssetImage(swap.coinSwap[index]["icon"]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  S.W(10),
                                  Center(child: Text(swap.coinSwap[index]['code'])),
                                ],
                              ),
                              Padding(
                                padding:  EdgeInsets.only(left: 20,top: 20),
                                child: Container(
                                    width: 100,
                                    child: Text('~ ${swap.coinSwap[index]['currency'].toString()}')),
                              ),
                            ],
                          ),
                          Padding(
                            padding:  EdgeInsets.only(right: 15),
                            child: InkWell(
                              onTap: (){
                                showDialog(context: context, builder: (context)=>showEdit(swap.swapSetting[index]['currency'].toString(),swap.swapSetting[index]['icon'],swap.coinSwap[index]['currency'].toString(),swap.coinSwap[index]['icon']));
                              },
                              child: Container(
                                height: 30,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(5)
                                ),child: Center(child: Text('Edit',style: TextStyle(color: Colors.black),))
                              ),
                            ),
                          ),
                          // S.W(10)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              S.H(kSpacing*20),
            ],
          ),
        )
    );
  }

  Widget showEdit(textCoin, icon,textCoinSwap,iconSwap) => Dialog(
    backgroundColor: Colors.transparent,
    child: Container(
      height: 500,
      width: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 3),
                            blurRadius: 10,
                          )
                        ],
                        shape: BoxShape.circle,
                        color: textCoin == 'BTC'
                            ? const Color(0xFFa77030)
                            : textCoin == 'ETH'
                            ? const Color(0xFF2768ea)
                            : textCoin == 'USDT'
                            ? const Color(0xFF06759b)
                            : textCoin == 'USDC'
                            ? const Color(0xFF0566e8)
                            : textCoin == 'EUROC'
                            ? const Color(0xFF016ace)
                            : textCoin == 'PAXG'
                            ? const Color(0xFFFFFFFF)
                            : textCoin == 'BUSD'
                            ? const Color(
                            0xFFf3ba2f)
                            : Colors.transparent,
                        image: DecorationImage(
                          image: AssetImage(icon),
                          fit: BoxFit.cover,
                        ),
                        // shape: BoxShape.circle,
                        // color: Colors.purpleAccent.withOpacity(0.2),
                      ),
                    ),
                    S.H(10),
                    Text(
                      textCoin,
                      style: const TextStyle(
                          color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
                const FaIcon(
                  FontAwesomeIcons.arrowRightArrowLeft,
                  color: Colors.black,
                ),
                Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 3),
                            blurRadius: 10,
                          )
                        ],
                        shape: BoxShape.circle,
                        color: textCoinSwap == 'BTC'
                            ? const Color(0xFFa77030)
                            : textCoin == 'ETH'
                            ? const Color(0xFF2768ea)
                            : textCoin == 'USDT'
                            ? const Color(0xFF06759b)
                            : textCoin == 'USDC'
                            ? const Color(0xFF0566e8)
                            : textCoin == 'EUROC'
                            ? const Color(0xFF016ace)
                            : textCoin == 'PAXG'
                            ? const Color(0xFFFFFFFF)
                            : textCoin == 'BUSD'
                            ? const Color(
                            0xFFf3ba2f)
                            : Colors.transparent,
                        image: DecorationImage(
                          image: AssetImage(iconSwap),
                          fit: BoxFit.cover,
                        ),
                        // shape: BoxShape.circle,
                        // color: Colors.purpleAccent.withOpacity(0.2),
                      ),
                    ),
                    S.H(10),
                    Text(
                      textCoinSwap,
                      style: const TextStyle(
                          color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            // S.H(10),
            // const Text('จำนวนเหรียญ'),
            // Row(
            //   children: [
            //     Container(
            //       width: 200,
            //       child: TextFormField(
            //         controller: coinController,
            //         decoration: InputDecoration(
            //           // hintText: "ใส่จำนวนเหรียญ",
            //           // hintStyle: TextStyle(color: Colors.grey),
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //         ),
            //         onChanged: (value) {
            //           setState(() {
            //             final valueCoin = Get.put(SwapSettingController());
            //             valueCoin.coinInsert = int.parse(value);
            //             print(valueCoin.coinInsert);
            //           });
            //         },
            //       ),
            //     ),
            //     S.W(20),
            //     Container(
            //       child: const Text(
            //         '/ 1 USD',
            //         style: TextStyle(color: Colors.black, fontSize: 24),
            //       ),
            //     )
            //   ],
            // ),
            S.H(10),
            const Text('Fee'),
            Row(
              children: [
                Container(
                  width: 200,
                  child: TextFormField(
                    controller: feeController,
                    decoration: InputDecoration(
                      hintText: "0",
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        final valueCoin = Get.put(SwapSettingController());
                        if (value == '' || value == null) {
                          valueCoin.fee = 0;
                        } else {
                          valueCoin.fee = int.parse(value);
                        }
                        print(valueCoin.fee);
                      });
                    },
                  ),
                ),
                const Spacer(),
                FaIcon(
                  FontAwesomeIcons.coins,
                  color: Colors.black.withOpacity(0.3),
                  size: 50,
                ),
                S.W(10)
              ],
            ),
            S.H(10),
            const Divider(
              color: Colors.black,
            ),
            S.H(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: const Text('Cancel'),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: const Text('Save'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
