import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:calendar/core.dart';

class EventView extends StatelessWidget {
  EventView({
    @required CalendarEvent this.event,
    @required Day this.day,
    @required ViewCallback this.switchViewCallback
  });

  final CalendarEvent event;
  final Day day;
  final ViewCallback switchViewCallback;

  Widget _generateEventViewHeader() {
    Widget component = new Container(
      margin: new EdgeInsets.only(top: 12.0),
      child: new Text('${event.title}')
    );
    return new Center(child: component);
  }

  Widget _generateEventViewBody() {
    Widget component = new Column(
      children: <Widget>[
        _generateEventViewBodyItem('${MonthNames[event.month - 1]["long"]} ${event.day}, ${event.year}'),
        _generateEventViewBodyItem('Start Time: ${event.getStartTime(military: false)}'),
        _generateEventViewBodyItem('End Time: ${event.getEndTime(military: false)}'),
        new Divider(),
        _generateEventViewBodyItem('${event.url}'),
        new Divider(),
        _generateEventViewBodyItem('${event.details}')
      ]
    );
    return new Expanded(child: component);
  }

  Widget _generateEventViewBodyItem(String text) {
    Widget component = new Container(
      margin: new EdgeInsets.only(right: 8.0, left: 8.0),
      child: new Align(
        alignment: FractionalOffset.centerLeft,
        child: new Text(text)
      )
    );
    return component;
  }

  Widget _generateEventViewFooter(BuildContext context) {
    Widget component = new Container(
      decoration: new BoxDecoration(
        backgroundColor: Theme.of(context).accentColor
      ),
      // padding: new EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: new Row(
        children: <Widget>[
          new IconButton(
            // padding: null,
            // alignment: null,
            icon: new Icon(Icons.arrow_back_ios),
            // color: null,
            // disabledColor: null,
            onPressed: () {
              switchViewCallback(
                view: RenderableView.events,
                selectedDay: day
              );
            },
            tooltip: 'Back to events'
          )
        ]
      )
    );
    return component;
  }

  @override
  Widget build(BuildContext context) {
    Widget component = new Container(
      child: new Center(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _generateEventViewHeader(),
            _generateEventViewBody(),
            _generateEventViewFooter(context)
          ]
        )
      )
    );
    return component;
  }
}