import 'package:batteryapp/models/battery_info.dart';
import 'package:batteryapp/theming_and_state_management/presentation/home/healthview.dart';
import 'package:batteryapp/theming_and_state_management/presentation/theme.dart';
import 'package:batteryapp/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cool_alert/cool_alert.dart';

const logoSize = 45.0;

class HealthScreen extends StatefulWidget {
  @override
  _HealthScreenState createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  DatabaseHelper helper = DatabaseHelper();

  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  final f = new DateFormat('yyyy-MM-dd hh:mm');

  int _capacity;
  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    _dateTime = DateTime.now();
    helper
        .initializeDatabase()
        .then((value) => {print('>>>>>>>> database initialized !')});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final moreSize = 50.0;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Positioned(
                  bottom: logoSize,
                  left: -moreSize / 2,
                  right: -moreSize / 2,
                  height: width + moreSize,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.5, 1.0],
                        colors: deliveryGradients,
                      ),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(200),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: logoSize,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset('assets/images/heart.png'),
                      )),
                )
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Column(
                  key: formKey,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      'Health',
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Capacity',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.battery_alert_outlined,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          hintText: 'capacity'),
                      validator: (val) {
                        if (val.isEmpty) {
                          print('validate capacity $val');
                          return 'Capacity is Required...!';
                        }
                      },
                      onSaved: (val) => _capacity = int.parse(val),
                      onChanged: (value) => _capacity = int.parse(value),
                    ),
                    const SizedBox(height: 20),
                    // Text(
                    //   'Storage',
                    //   style: Theme.of(context).textTheme.subtitle1.copyWith(
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    // ),
                    // TextFormField(
                    //   decoration: InputDecoration(
                    //       prefixIcon: Icon(
                    //         Icons.storage_outlined,
                    //         color: Theme.of(context).iconTheme.color,
                    //       ),
                    //       hintText: 'storage'),
                    //   validator: (val) {
                    //     if (val.isEmpty) {
                    //       return 'Storage is Required...!';
                    //     }
                    //   },
                    //   onSaved: (val) => _storage = val,
                    //   onChanged: (value) => _storage = value,
                    // ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: InkWell(
              onTap: () {
                // if (formKey.currentState.validate()) {
                //   formKey.currentState.save();
                //   _save();
                // }
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.success,
                  text: 'Battery Health Added Successfully!',
                  autoCloseDuration: Duration(seconds: 2),
                );

                _save();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => HealthHomeScreen(),
                ));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: deliveryGradients,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _save() async {
    String nowDate = DateFormat('yyyy-MM-dd – kk:mm').format(_dateTime);
    HealthInfo healthInfo = HealthInfo(_capacity, nowDate);
    int result;
    result = await helper.insertHealth(healthInfo);

    if (result != 0) {
      print('Success');
    } else {
      print('Failed');
    }
  }
}
