import 'dart:io';
import 'package:fake_call/screens/whatsAppIncoming.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:contact_picker/contact_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class ProfileCreate extends StatefulWidget {
  static const routeName = '/ProfileCreate';

  @override
  _ProfileCreateState createState() => _ProfileCreateState();
}

class _ProfileCreateState extends State<ProfileCreate> {
  int id;
  String name = 'Steve';
  String number = '08521234567';
  File image;
  dynamic contact;
  dynamic schedule;
  dynamic ringtone;
  dynamic callScreen;

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    initNotification();
    super.initState();
  }

  Future getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    });
  }

  Future getContact() async {
    final pickedContact = await ContactPicker().selectContact();

    setState(() {
      if (pickedContact != null) {
        contact = pickedContact;
        name = pickedContact.fullName;
      } else {
        print('No contact selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Call Profile"),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            InkWell(
              onTap: getContact,
              child: Container(
                height: 100.0,
                color: Colors.blue,
                child: Center(
                  child: Text('No Contact Selected'),
                  // child: contact == null ? Text('No Contact Selected') : Image.file(image),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: getImage,
                    child: Container(
                      height: 200,
                      color: Colors.blue,
                      child:
                          Center(child: image == null ? Text('Select Image') : Image.file(image)),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(hintText: 'Name'),
                        controller: TextEditingController(text: name),
                        onChanged: (value) {
                          name = value;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        decoration: InputDecoration(hintText: 'Number'),
                        controller: TextEditingController(text: number),
                        onChanged: (value) {
                          number = value;
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 100.0,
              color: Colors.purple,
              child: Center(
                child: Text('Schedule'),
              ),
            ),
            Container(
              height: 100.0,
              color: Colors.green,
              child: Center(
                child: Text('Ringtone'),
              ),
            ),
            Container(
              height: 100.0,
              color: Colors.purple,
              child: Center(
                child: Text('Call Screen'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          displayNotification();
          print("Display Notification");
        },
      ),
    );
  }

  Future<void> initNotification() async {
    const initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
    final initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String payload) async {
        if (payload != null) {
          debugPrint('Notification payload: $payload');
        }
        await Navigator.pushNamed(context, WhatsAppIncoming.routeName,
            arguments: InfoWhatsAppIncoming(name, image));
      },
    );
  }

  Future<void> displayNotification() async {
    final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    var scheduleTime = tz.TZDateTime.now(tz.local).add(Duration(seconds: 5));

    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'idAlarmNotif',
      'nameAlarmNotif',
      'descAlarmNotif',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      fullScreenIntent: true,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'plain title',
      'plain body',
      scheduleTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
