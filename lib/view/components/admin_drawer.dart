
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moneymaker/model/route/app_routes.dart';
import 'package:moneymaker/model/theme/sizebox_wiget.dart';

class AdminDrawer extends StatelessWidget {
  const AdminDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 1000;
    return Drawer(
      width:isDesktop?350:250,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child:
      Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          S.H(20),
          Container(
            height: 100,
            width: double.infinity,
           decoration: BoxDecoration(
             shape: BoxShape.circle,
              color: Colors.white,
             boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
             ]
           ),
           child: const Center(
             child: FaIcon(
               FontAwesomeIcons.user,
               size: 50,
               color: Colors.black,
             ),
           ),
           ),
          S.H(40),
          const Text('Admin Control',style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),),
          S.H(20),
          const Divider(
            color: Colors.black,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
          S.H(20),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pushNamed(context, '/dashboard');
            },
          ),
          ListTile(
            leading: const Icon(Icons.swap_horiz_outlined),
            title: const Text('Transactions'),
            onTap: () {

            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Setting'),
            onTap: () {

            },
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: const Text('Logout'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    icon: const Icon(
                      FontAwesomeIcons.question,
                      color: Colors.redAccent,
                    ),
                    title: Text("ยืนยันการออกจากระบบ"),
                    content: Text("คุณต้องการออกจากระบบหรือไม่"),
                    actions: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent,
                          ),
                          child: Center(child: Text("ยกเลิก")),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, Paths.signIn);
                          // Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.redAccent.withOpacity(0.3),
                          ),
                          child: Center(child: Text("ตกลง")),
                        ),
                      ),
                    ],
                  );
                },
              );

            },
          ),
        ],
      )
    );
  }

}
