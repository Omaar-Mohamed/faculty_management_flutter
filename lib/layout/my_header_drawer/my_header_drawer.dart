
import 'package:flutter/material.dart';
import 'package:sms_flutter/modules/students_modules/profile/edit_profile_screen.dart';
import 'package:sms_flutter/modules/students_modules/profile/profile_screen.dart';
import 'package:sms_flutter/shared/network/local/cache_helper(shared_prefrenceds).dart';

import '../../shared/components/components.dart';
import '../../shared/constants/constants.dart';

class MyHeaderDrawer extends StatefulWidget {
  final String type;



  MyHeaderDrawer({Key? key, required this.type}) : super(key: key);
  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: GestureDetector(
        onTap: () {
          navigateTo(context, ProfileScreen(type: widget.type,));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  // image: widget.image !=null? AssetImage(widget.image):AssetImage('assets/images/profile.jpg'),
                  image:NetworkImage('https://sms.gxadev.me'+image),
                ),
              ),
            ),
            Text(
              fname+ " "+lname,
              // 'name',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              cacheEmail==null?'no email':cacheEmail,
              // 'email',
              style: TextStyle(
                color: Colors.grey[200],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
