import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mymail/model/datetime_helper.dart';
import 'package:mymail/model/email.dart';

class DetailsScreenArguments {
  final Email email;

  DetailsScreenArguments(this.email);
}

class DetailsScreen extends StatelessWidget {
  static const routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final DetailsScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: buildAppBar(args),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildFrom(args.email.from),
              verticalDivider(context),
              buildSubjectAndDate(args.email.subject, args.email.dateTime),
              verticalDivider(context),
              buildBody(args.email.body)
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(DetailsScreenArguments args) {
    return AppBar(
      title: Text(args.email.subject),
    );
  }

  Padding buildFrom(String from) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Text(
        "From: $from",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Padding buildSubjectAndDate(String subject, DateTime dateTime) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSubject(subject),
            buildDateTime(dateTime),
          ]),
    );
  }

  Text buildSubject(String subject) {
    return Text(
      subject,
      style: TextStyle(fontWeight: FontWeight.w600),
    );
  }

  Text buildDateTime(DateTime dateTime) {
    return Text(
      DateTimeHelper.formatDateTime(dateTime),
      style: TextStyle(color: Colors.grey),
    );
  }

  Padding buildBody(String body) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Text(
        body,
      ),
    );
  }

  Divider verticalDivider(BuildContext context) {
    return Divider(
      color: Theme.of(context).colorScheme.primary,
      thickness: 1,
      height: 0.0,
    );
  }
}
