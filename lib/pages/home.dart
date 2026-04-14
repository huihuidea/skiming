import 'package:babay_pro/Utils/hive_storage.dart';
import 'package:babay_pro/pages/userInfo/userSetting.dart';
import 'package:babay_pro/store/providers.dart';
import 'package:babay_pro/widgets/home_card.dart';
import 'package:flutter/material.dart';
import '../store/userInfo.dart';
import '../widgets/home_recent.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
;
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ref1 = ref.watch(userProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                _usrInfo(context,ref),
                SizedBox(height: 40),
                _CicleData(),
                SizedBox(height: 32),
                _cardData(),
                SizedBox(height: 32),
                _recentSesstion(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Header - userInfo
  Widget _usrInfo(BuildContext cxt, WidgetRef ref) {
    final _isLogin = ref.watch(isLoginProvider);
    final _userInfo = ref.watch(userProvider);
    return Container(
      child: Row(
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: .center,
        children: [
          Column(
            crossAxisAlignment: .start,
            children: [
              // text1
              Text(
                "Thursday，dec 14",
                style: TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                  fontFamily: "",
                ),
              ),
              //text2
              Text(
                "Good morning, ${_isLogin ? _userInfo?.username ?? "Visitor" : "Mrs"}",
                style: TextStyle(fontSize: 24, fontWeight: .w500),
              ),
            ],
          ),
          //avater
          InkWell(
            child: Container(
              decoration: BoxDecoration(
                shape: .circle,
                border: Border.all(color: Colors.grey, width: 2),
              ),
              child: CircleAvatar(
                radius: 24,
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(
                  "https://picsum.photos/id/237/200/300",
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                cxt,
                MaterialPageRoute(
                  builder: (con) {
                    return Usersetting();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  //CicleData
  Widget _CicleData() {
    return Stack(
      alignment: .center,
      children: [
        Container(
          width: 192,
          height: 192,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: .circle,
            border: Border.all(width: 16, color: Color(0x5094A3B8)),
          ),
        ),
        //inner cicle
        Positioned(
          child: Container(
            width: 158,
            height: 158,
            decoration: BoxDecoration(
              shape: .circle,
              border: Border.all(width: 16, color: Colors.blue),
            ),
            child: Column(
              crossAxisAlignment: .center,
              mainAxisAlignment: .center,
              children: [
                Text(
                  "Distance",
                  style: TextStyle(fontSize: 14, color: Color(0xff94A3B8)),
                ),
                Text(
                  "42.5 km",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: .w500,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "+2.4km today",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    backgroundColor: Color(0xffECFDF5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  //Data Card
  Widget _cardData() {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Expanded(
          child: HomeCard(
            title: "Top Speed",
            iconData: Icons.shutter_speed_sharp,
            valStr: "68",
            unitStr: "km/h",
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: HomeCard(
            title: "Altitude",
            iconData: Icons.eighteen_mp_outlined,
            valStr: "3,2400",
            unitStr: "m",
          ),
        ),
      ],
    );
  }

  //Recent session
  Widget _recentSesstion() {
    return Container(
      alignment: .centerStart,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text("Recent Session", style: TextStyle(fontSize: 24)),
              TextButton(onPressed: () {}, child: Text("History")),
            ],
          ),
          SizedBox(height: 12),
          HomeRecent(),
        ],
      ),
    );
  }
}
