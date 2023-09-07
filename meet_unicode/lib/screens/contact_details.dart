import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:meet_unicode/constants/colors.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactDetails extends StatefulWidget {
  final Contact contact;
  final String profile;
  ContactDetails(this.contact, this.profile, {super.key});

  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.white),
      child: Column(children: [
        const SizedBox(
          height: 20,
        ),
        CircleAvatar(
          radius: 60,
          child: Center(
            child: Text(
              widget.profile.toUpperCase(),
              style: const TextStyle(fontSize: 50),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          widget.contact.displayName,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
        ),
        Divider(
          color: Colors.grey.shade300,
        ),
        widget.contact.phones.isNotEmpty
            ? Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(children: [
                  const Icon(Icons.phone_outlined),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.contact.phones.first.number,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ]),
              )
            : const SizedBox(),
        widget.contact.emails.isNotEmpty
            ? Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(children: [
                  const Icon(Icons.email_outlined),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.contact.emails.first.address,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ]),
              )
            : const SizedBox(),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              widget.contact.phones.isNotEmpty
                  ? Expanded(
                      child: InkWell(
                        onTap: () {
                          launchUrlString(
                              "tel:${widget.contact.phones.first.number}");
                        },
                        child: Container(
                          height: 90,
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Call',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              //
              //
              widget.contact.phones.isNotEmpty
                  ? Expanded(
                      child: InkWell(
                        onTap: () {
                          launchUrlString(
                              "sms:${widget.contact.phones.first.number}");
                        },
                        child: Container(
                          height: 90,
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.message,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Message',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              //
              //
              widget.contact.emails.isNotEmpty
                  ? Expanded(
                      child: InkWell(
                        onTap: () {
                          launchUrlString(
                              "mailto:${widget.contact.emails.first.address}");
                        },
                        child: Container(
                          height: 90,
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Email',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        )
      ]),
    );
  }
}
