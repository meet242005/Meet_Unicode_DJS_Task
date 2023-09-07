import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:meet_unicode/main.dart';
import 'package:meet_unicode/screens/contact_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var name = "";
  var nameinitial = "";
  var email = "";
  var phone = "";
  var dob = "";
  var city = "";
  List<Contact>? contacts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchStorageData();
    getContactsList();
    geoLocator();
  }

  Future fetchStorageData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var storedData = sharedPreferences.getStringList('userinfo');
    setState(() {
      name = storedData![0];
      phone = storedData[1];
      email = storedData[2];
      dob = storedData[3];

      var tempname = name;

      if (tempname.contains(" ")) {
        List name = tempname.split(" ");
        nameinitial =
            name[0].substring(0, 1) + name[name.length - 1].substring(0, 1);
      } else {
        nameinitial = tempname[0];
      }
    });
  }

  Future deleteStorageData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('userinfo');
    Get.offAll(() => const SplashScreen());
  }

  Future getContactsList() async {
    if (await FlutterContacts.requestPermission(readonly: true)) {
      contacts = await FlutterContacts.getContacts();
    }
  }

  Future geoLocator() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ignore: use_build_context_synchronously
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        title: 'Error Occured',
        desc: "Location services are disabled. Please Enable them in Settings.",
        dialogBorderRadius: const BorderRadius.all(Radius.circular(20)),
        btnOkColor: AppColors.primaryColor,
        btnOkOnPress: () => Geolocator.openAppSettings(),
      )..show();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: use_build_context_synchronously
        return AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.scale,
          title: 'Error Occured',
          desc:
              "Location services are disabled. Please Enable them in Settings.",
          dialogBorderRadius: const BorderRadius.all(Radius.circular(20)),
          btnOkColor: AppColors.primaryColor,
          btnOkOnPress: () {
            Geolocator.openAppSettings();
          },
        )..show();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      // ignore: use_build_context_synchronously
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.scale,
        title: 'Error Occured',
        desc: "Location services are disabled. Please Enable them in Settings.",
        dialogBorderRadius: const BorderRadius.all(Radius.circular(20)),
        btnOkColor: AppColors.primaryColor,
        btnOkOnPress: () {
          Geolocator.openAppSettings();
        },
      )..show();
    }

    Position? position = await Geolocator.getCurrentPosition();
    var placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    setState(() {
      city = placemark[0].locality.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
          scrolledUnderElevation: 0,
          centerTitle: false,
          backgroundColor: AppColors.primaryColor,
          title: const Text(
            "DJSCE Unicode'23",
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white),
          )),
      body: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          child: Text(nameinitial.toUpperCase()),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Hello, $name",
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        deleteStorageData();
                      },
                      child: const Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 0.3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          size: 16,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          phone,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          dob,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.calendar_month,
                          size: 16,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.email,
                          size: 16,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          email,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          city,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
                child: contacts == null
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ))
                    : ListView.builder(
                        itemCount: contacts!.length,
                        itemBuilder: (context, index) {
                          var profile = contacts![index].displayName;

                          if (profile.contains(" ")) {
                            List name = profile.split(" ");
                            profile = name[0].substring(0, 1) +
                                name[name.length - 1].substring(0, 1);
                          } else {
                            profile = profile[0];
                          }
                          return Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  final fullContact =
                                      await FlutterContacts.getContact(
                                          contacts![index].id);
                                  Get.bottomSheet(
                                    ContactDetails(fullContact!, profile),
                                  );
                                },
                                child: Container(
                                    width: double.infinity,
                                    height: 60,
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          child: Text(profile.toUpperCase()),
                                        ),
                                        VerticalDivider(
                                          color: Colors.grey.shade300,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                contacts![index].displayName,
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              Divider(
                                color: Colors.grey.shade300,
                              )
                            ],
                          );
                        },
                      ),
              ),
            ),
          ),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "DJSCE Unicode'23 Task by Meet Chavan SY - 60004230269",
                style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 11,
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
