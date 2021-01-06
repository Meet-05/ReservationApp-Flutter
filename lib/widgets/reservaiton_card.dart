import '../services/firebase_api.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../screens/reservtion_screen.dart';
import '../widgets/dialog.dart';

class ReservationCard extends StatefulWidget {
  String id;
  String name;
  String phone;
  String email;
  DateTime date;

  ReservationCard({this.name, this.date, this.email, this.phone, this.id});
  @override
  _ReservationCardState createState() => _ReservationCardState();
}

class _ReservationCardState extends State<ReservationCard> {
  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ReservationScreen(
                      existed: true,
                      id: widget.id,
                      name: widget.name,
                      phone: widget.phone,
                      email: widget.email,
                      pickedTime: widget.date,
                    )));
      },
      child: Dismissible(
        key: ValueKey(widget.id),
        background: DismissibileContainer(),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) async {
          await FirebaseApi.deleteReservation(widget.id);
        },
        confirmDismiss: (_) {
          return buildShowDialog(context);
        },
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 30.0, left: 10.0),
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                width: containerWidth,
                decoration: BoxDecoration(
                  color: Color(0xFFffe6e6),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                ),
                child: ListTile(
                  title: Text(
                    widget.name,
                    style: ktitleStyle,
                  ),
                  trailing: Text(
                    dateformat.format(widget.date),
                    style: ktitleStyle.copyWith(fontSize: 15.0),
                  ),
                )),
            Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(left: 10.0),
                width: containerWidth,
                decoration: BoxDecoration(
                  color: Color(0xFFffabe1),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomListTile(
                      widget: widget,
                      iconToShow: Icons.email,
                      textToShow: widget.email,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    CustomListTile(
                      widget: widget,
                      iconToShow: Icons.phone,
                      textToShow: widget.phone,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class DismissibileContainer extends StatelessWidget {
  const DismissibileContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.0, left: 2.0),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        size: 50.0,
      ),
      alignment: Alignment.centerRight,
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData iconToShow;
  final String textToShow;
  CustomListTile(
      {Key key, @required this.widget, this.iconToShow, this.textToShow});

  final ReservationCard widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(iconToShow)),
        Text(
          textToShow,
          style: ktitleStyle.copyWith(fontSize: 18.0),
        ),
      ],
    );
  }
}
