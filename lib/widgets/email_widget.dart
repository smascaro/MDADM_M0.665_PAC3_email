import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mymail/model/backend.dart';
import 'package:mymail/model/datetime_helper.dart';
import 'package:mymail/model/email.dart';
import 'package:mymail/screens/details_screen.dart';

class EmailWidget extends StatefulWidget {
  static const double VISIBILITY_INDICATOR_WIDTH = 36.0;
  Email _model;

  EmailWidget(this._model);

  @override
  _EmailWidgetState createState() => _EmailWidgetState(_model);
}

class _EmailWidgetState extends State<EmailWidget> {
  Email _model;

  _EmailWidgetState(this._model);

  void _markAsRead() {
    setState(() {
      Backend().markEmailAsRead(_model.id);
    });
  }

  void _handleTap() {
    _markAsRead();
    Navigator.pushNamed(context, DetailsScreen.routeName, arguments: DetailsScreenArguments(_model));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
        child: Row(
          children: [
            buildVisibilityIndicator(context),
            buildMainContent(),
          ],
        ),
      ),
      onLongPress: _markAsRead,
      onTap: _handleTap,
    );
  }

  Container buildVisibilityIndicator(BuildContext context) {
    return Container(
      width: EmailWidget.VISIBILITY_INDICATOR_WIDTH,
      child: buildVisibilityIndicatorCircle(context),
    );
  }

  Center buildVisibilityIndicatorCircle(BuildContext context) {
    return _model.read
        ? null
        : Center(
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: Theme.of(context).accentColor, shape: BoxShape.circle),
            ),
          );
  }

  Column buildMainContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [buildDateTime(), buildFrom(), buildSubject()],
    );
  }

  Text buildSubject() {
    return Text(
      _model.subject,
      style: buildTextStyle(),
    );
  }

  Text buildFrom() {
    return Text(
      _model.from,
      style: buildTextStyle(),
    );
  }

  Text buildDateTime() => Text(DateTimeHelper.formatDate(_model.dateTime));

  TextStyle buildTextStyle() {
    return TextStyle(fontWeight: _model.read ? FontWeight.normal : FontWeight.bold);
  }
}
