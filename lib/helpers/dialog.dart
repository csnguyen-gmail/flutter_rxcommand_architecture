import 'package:flutter/material.dart';
import 'package:marika_client/localizations/message_localizations.dart';

void showSimpleDialog(BuildContext context, String msg, {VoidCallback closeActionCallback, String closeTitle}) {
  if (closeTitle == null) {
    closeTitle = MessageLocalizations.of(context).close;
  }
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(msg),
        actions: <Widget>[
          FlatButton(
            child: Text(closeTitle),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).pop();
              if (closeActionCallback != null) {
                closeActionCallback();
              }
            },
          ),
        ],
      );
    },
  );
}
//
//void showActionDialog(BuildContext context, {String title, String content, String actionString, VoidCallback action, VoidCallback cancelAction, bool barrierDismissible = true}) {
//  showDialog(
//    barrierDismissible: barrierDismissible,
//    context: context,
//    builder: (context) {
//      return AlertDialog(
//        title: title == null ? Container() : Text(title),
//        content: Text(content, style: Theme.of(context).textTheme.body1),
//        actions: <Widget>[
//          FlatButton(child: Text(MessageLocalizations.of(context).cancel), textColor: Colors.black, onPressed: (){
//            Navigator.of(context).pop();
//            if (cancelAction != null) cancelAction();
//          }),
//          FlatButton(child: Text(actionString), onPressed: () {
//            Navigator.of(context).pop();
//            action();
//          }),
//        ],
//      );
//    },
//  );
//}
//
//typedef Widget ItemBuilder<T>(T item);
//
//void showSelectionDialog<T>(
//  BuildContext context, {
//  @required List<T> options,
//  @required ValueChanged<int> selectedCallback,
//  @required ItemBuilder<T> itemBuilder,
//  String title,
//}) {
//  showDialog(
//    context: context,
//    builder: (context) {
//      return Dialog(
//        child: Column(
//          mainAxisSize: MainAxisSize.min,
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: _buildSelectionList(context: context, title: title, options: options, selectedCallback: selectedCallback, itemBuilder: itemBuilder),
//        ),
//      );
//    }
//  );
//}
//
//List<Widget> _buildSelectionList<T>({
//  @required BuildContext context,
//  @required String title,
//  @required List<T> options,
//  @required ValueChanged<int> selectedCallback,
//  @required ItemBuilder<T> itemBuilder,
//}) {
//  List<Widget> widgets = [];
//
//  if (title != null) {
//    widgets.add(
//      Container(
//        padding: EdgeInsets.all(16.0),
//        child: Text(title, style: Theme.of(context).textTheme.title),
//      ),
//    );
//    widgets.add(Divider(height: 2.0));
//  }
//
//  widgets.add(
//    ListView(
//      shrinkWrap: true,
//      children: List<Widget>.generate(options.length, (index) {
//        return SimpleDialogOption(
//          child: itemBuilder(options[index]),
//          onPressed: () {
//            Navigator.pop(context);
//            selectedCallback(index);
//          },
//        );
//      }),
//    ),
//  );
//
//  return widgets;
//}
//
//showMultiChoiceDialog(BuildContext context, {
//  @required String title,
//  @required List<String> values,
//  @required List<bool> states,
//  @required ValueChanged<List<bool>> selectedCallback,
//}) {
//  showDialog(
//    context: context,
//    builder: (context) {
//      return Dialog(
//        child: MultiChoice(
//          title: title,
//          values: values,
//          states: states,
//          selectedCallback: selectedCallback,
//        ),
//      );
//    },
//  );
//}
