import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mymail/model/backend.dart';
import 'package:mymail/model/email.dart';
import 'package:mymail/widgets/email_widget.dart';

class ListScreen extends StatefulWidget {
  static const routeName = "/";

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Email> _emailsList = Backend().getEmails();
  static const _SWIPE_SPEED_THRESHOLD = 2000;

  void _handleHorizontalDrag(DragEndDetails details, Email model) {
    if (details.primaryVelocity.abs() > _SWIPE_SPEED_THRESHOLD) {
      setState(() {
        Backend().deleteEmail(model.id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyMail"),
      ),
      body: _emailsList.isEmpty ? buildNoMailView() : buildMailList(),
    );
  }

  Padding buildNoMailView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: Text("Nothing to see around here")),
    );
  }

  ListView buildMailList() {
    return ListView.separated(
      itemCount: _emailsList.length,
      itemBuilder: (context, index) => buildEmailListTile(index),
      separatorBuilder: (context, index) => buildEmailListDivider(context),
    );
  }

  ListTile buildEmailListTile(int index) {
    return ListTile(
        key: ObjectKey(_emailsList[index]),
        contentPadding: EdgeInsets.all(0),
        title: GestureDetector(
          child: EmailWidget(_emailsList[index]),
          onHorizontalDragEnd: (details) => _handleHorizontalDrag(details, _emailsList[index]),
        ));
  }

  Padding buildEmailListDivider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: EmailWidget.VISIBILITY_INDICATOR_WIDTH, vertical: 0),
      child: Divider(
        color: Theme.of(context).colorScheme.primary,
        thickness: 1,
        height: 0.0,
      ),
    );
  }
}
