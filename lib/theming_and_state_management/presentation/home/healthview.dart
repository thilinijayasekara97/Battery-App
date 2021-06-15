import 'package:batteryapp/data.dart';
import 'package:batteryapp/models/battery_info.dart';
import 'package:batteryapp/theming_and_state_management/presentation/theme.dart';
import 'package:batteryapp/utils/database_helper.dart';
import 'package:flutter/material.dart';

class HealthHomeScreen extends StatefulWidget {
  @override
  _HealthHomeScreenState createState() => _HealthHomeScreenState();
}

class _HealthHomeScreenState extends State<HealthHomeScreen> {
  int currentIndex = 0;

  DatabaseHelper _helper = DatabaseHelper();
  Future<List<HealthInfo>> _healthList;

  @override
  void initState() {
    _healthList = _helper.getHealthList();
    super.initState();
  }

  double _calcCapacity(int estimateCapacity) {
    return (estimateCapacity / 4000) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: IndexedStack(
              index: currentIndex,
              children: <Widget>[
                // _BatteryPage(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 54),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Battery Health',
                        style: TextStyle(
                            fontFamily: 'avenir',
                            fontWeight: FontWeight.w700,
                            color: DeliveryColors.purple,
                            fontSize: 24),
                      ),
                      Expanded(
                          child: FutureBuilder<List<HealthInfo>>(
                        future: _healthList,
                        builder: (context, snapshot) {
                          // var data = snapshot.data.map((e) => e.date);
                          // print('data: $data');
                          if (snapshot.hasData) {
                            // _currentHealth = snapshot.data;
                            return ListView(
                              children: snapshot.data.map((battery) {
                                var capacity = (battery.capacity);
                                print('capacity: $capacity');
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 32),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: GradientColors.sky,
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: GradientColors.sunset.first
                                            .withOpacity(0.4),
                                        blurRadius: 8,
                                        spreadRadius: 2,
                                        offset: Offset(4, 4),
                                      )
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.label,
                                                color: Colors.white,
                                                size: 24,
                                              ),
                                              SizedBox(
                                                width: 10,
                                                height: 14,
                                              ),
                                              Text(
                                                battery.date.toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'avenir',
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Switch(
                                            value: true,
                                            onChanged: (bool value) {},
                                            activeColor: Colors.white,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Estimated Capacity',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'avenir'),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "${battery.capacity} mAh",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'avenir',
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Design Capacity',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'avenir'),
                                          ),
                                          Text(
                                            '4000 mAh',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'avenir',
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Battery Health',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'avenir',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            '${_calcCapacity(battery?.capacity ?? 0)}%',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'avenir',
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          }
                          return Center(
                            child: Text(
                              'Loading..',
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        },
                      ))
                    ],
                  ),
                )
              ],
            ),
          ),
          _DeliveryNavogationBar(
              index: currentIndex,
              onIndexSelected: (index) {
                setState(() {
                  currentIndex = index;
                });
              }),
        ],
      ),
    );
  }
}

class _BatteryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 54),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Battery Health',
            style: TextStyle(
                fontFamily: 'avenir',
                fontWeight: FontWeight.w700,
                color: DeliveryColors.purple,
                fontSize: 24),
          ),
          Expanded(
              child: ListView(
                  // children: [].map((battery) {
                  //   // return Container(
                  //   //   margin: const EdgeInsets.only(bottom: 32),
                  //   //   padding:
                  //   //       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  //   //   decoration: BoxDecoration(
                  //   //     gradient: LinearGradient(
                  //   //       colors: battery.gradientColors,
                  //   //       begin: Alignment.centerLeft,
                  //   //       end: Alignment.centerRight,
                  //   //     ),
                  //   //     boxShadow: [
                  //   //       BoxShadow(
                  //   //         color: battery.gradientColors.last.withOpacity(0.4),
                  //   //         blurRadius: 8,
                  //   //         spreadRadius: 2,
                  //   //         offset: Offset(4, 4),
                  //   //       )
                  //   //     ],
                  //   //     borderRadius: BorderRadius.all(Radius.circular(24)),
                  //   //   ),
                  //   //   child: Column(
                  //   //     crossAxisAlignment: CrossAxisAlignment.start,
                  //   //     children: <Widget>[
                  //   //       Row(
                  //   //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   //         children: <Widget>[
                  //   //           Row(
                  //   //             children: <Widget>[
                  //   //               Icon(
                  //   //                 Icons.label,
                  //   //                 color: Colors.white,
                  //   //                 size: 24,
                  //   //               ),
                  //   //               SizedBox(
                  //   //                 width: 10,
                  //   //                 height: 14,
                  //   //               ),
                  //   //               Text(
                  //   //                 'January',
                  //   //                 style: TextStyle(
                  //   //                     color: Colors.white,
                  //   //                     fontFamily: 'avenir',
                  //   //                     fontSize: 18,
                  //   //                     fontWeight: FontWeight.bold),
                  //   //               ),
                  //   //             ],
                  //   //           ),
                  //   //           Switch(
                  //   //             value: true,
                  //   //             onChanged: (bool value) {},
                  //   //             activeColor: Colors.white,
                  //   //           ),
                  //   //         ],
                  //   //       ),
                  //   //       Row(
                  //   //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   //         children: <Widget>[
                  //   //           Text(
                  //   //             'Estimated Capacity',
                  //   //             style: TextStyle(
                  //   //                 color: Colors.white, fontFamily: 'avenir'),
                  //   //           ),
                  //   //           SizedBox(width: 10),
                  //   //           Text(
                  //   //             '1140 mAh',
                  //   //             style: TextStyle(
                  //   //               color: Colors.white,
                  //   //               fontFamily: 'avenir',
                  //   //             ),
                  //   //           ),
                  //   //         ],
                  //   //       ),
                  //   //       Row(
                  //   //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   //         children: <Widget>[
                  //   //           Text(
                  //   //             'Design Capacity',
                  //   //             style: TextStyle(
                  //   //                 color: Colors.white, fontFamily: 'avenir'),
                  //   //           ),
                  //   //           Text(
                  //   //             '4000 mAh',
                  //   //             style: TextStyle(
                  //   //               color: Colors.white,
                  //   //               fontFamily: 'avenir',
                  //   //             ),
                  //   //           ),
                  //   //         ],
                  //   //       ),
                  //   //       SizedBox(
                  //   //         height: 10,
                  //   //       ),
                  //   //       Row(
                  //   //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   //         children: <Widget>[
                  //   //           Text(
                  //   //             'Battery Health',
                  //   //             style: TextStyle(
                  //   //                 color: Colors.white,
                  //   //                 fontFamily: 'avenir',
                  //   //                 fontSize: 20,
                  //   //                 fontWeight: FontWeight.w700),
                  //   //           ),
                  //   //           Text(
                  //   //             '95%',
                  //   //             style: TextStyle(
                  //   //               color: Colors.white,
                  //   //               fontFamily: 'avenir',
                  //   //               fontSize: 20,
                  //   //               fontWeight: FontWeight.w700,
                  //   //             ),
                  //   //           ),
                  //   //         ],
                  //   //       ),
                  //   //     ],
                  //   //   ),
                  //   // );
                  // }).toList(),
                  ))
        ],
      ),
    );
  }
}

const TWO_PI = 3.14 * 2;

class _ProgreesBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = 200.0;
    return SafeArea(
      child: Scaffold(
          body: Container(
        padding: const EdgeInsets.all(20.0),
        child: TweenAnimationBuilder(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(seconds: 4),
            builder: (context, value, child) {
              int percentage = (value * 100).ceil();

              return Container(
                width: size,
                height: size,
                child: Stack(children: [
                  ShaderMask(
                    shaderCallback: (rect) {
                      return SweepGradient(
                              startAngle: 0.0,
                              endAngle: TWO_PI,
                              stops: [value, value],
                              center: Alignment.center,
                              colors: [Colors.blue, Colors.transparent])
                          .createShader(rect);
                    },
                    child: Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: Image.asset('assets/images/radial_scale.png')
                                .image),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: size - 40,
                      height: size - 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          "$percentage",
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
                    ),
                  ),
                ]),
              );
            }),
      )),
    );
  }
}

class _DeliveryNavogationBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onIndexSelected;

  const _DeliveryNavogationBar({
    Key key,
    this.index,
    this.onIndexSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          border: Border.all(
            color: Theme.of(context).bottomAppBarColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Material(
                child: IconButton(
                  icon: Icon(
                    Icons.home,
                    color: index == 0
                        ? DeliveryColors.green
                        : DeliveryColors.lightGrey,
                  ),
                  onPressed: () => onIndexSelected(0),
                ),
              ),
              Material(
                child: IconButton(
                  icon: Icon(
                    Icons.store,
                    color: index == 1
                        ? DeliveryColors.green
                        : DeliveryColors.lightGrey,
                  ),
                  onPressed: () => onIndexSelected(1),
                ),
              ),
              Material(
                child: CircleAvatar(
                  backgroundColor: DeliveryColors.purple,
                  radius: 23,
                  child: IconButton(
                    icon: Icon(
                      Icons.shopping_basket,
                      color: index == 2
                          ? DeliveryColors.green
                          : DeliveryColors.white,
                    ),
                    onPressed: () => onIndexSelected(2),
                  ),
                ),
              ),
              Material(
                child: IconButton(
                  icon: Icon(
                    Icons.favorite_border,
                    color: index == 3
                        ? DeliveryColors.green
                        : DeliveryColors.lightGrey,
                  ),
                  onPressed: () => onIndexSelected(3),
                ),
              ),
              InkWell(
                onTap: () => onIndexSelected(4),
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
