import 'package:flutter/material.dart';
import 'package:reservationApp/constants.dart';
import '../constants.dart';
import '../model/reservation.dart';
import '../services/firebase_api.dart';
import '../widgets/date_picker.dart';

class ReservationScreen extends StatefulWidget {
  String id;
  String name;
  String phone;
  String email;
  DateTime pickedTime;
  bool existed;
  ReservationScreen(
      {@required this.existed,
      this.email,
      this.id,
      this.name,
      this.phone,
      this.pickedTime});
  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

//Name, Phone Number, Email id, Time and Date of Reservation).

class _ReservationScreenState extends State<ReservationScreen> {
  var _form = GlobalKey<FormState>();
  String name;
  String phone;
  String email;
  DateTime pickedTime;

  void fetchTime(DateTime selectedTime) {
    pickedTime = selectedTime;
    print('selected time $pickedTime');
  }

  void onFormSubmited() async {
    if (_form.currentState.validate()) {
      _form.currentState.save();

      if (pickedTime == null && widget.existed) {
        pickedTime = widget.pickedTime;
      }
      if (pickedTime == null && !widget.existed) {
        pickedTime = DateTime.now();
      }
      Reservation newReservation = Reservation(
        id: widget.existed ? widget.id : null,
        name: name,
        phoneNumber: phone,
        email: email,
        date: pickedTime,
      );

      if (widget.existed) {
        FirebaseApi.updateReservation(newReservation);
      } else {
        FirebaseApi.addReservation(newReservation);
      }
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Reservation Screen'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextFormField(
                      initialValue: widget.existed ? widget.name : null,
                      style: ktitleStyle.copyWith(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                        labelStyle: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 20.0),
                      ),
                      validator: nameValidator,
                      onSaved: (value) => name = value),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                      initialValue: widget.existed ? widget.phone : null,
                      style: ktitleStyle.copyWith(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'PhoneNumber',
                        labelStyle: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 20.0),
                      ),
                      keyboardType: TextInputType.number,
                      validator: phoneNumberValidator,
                      onSaved: (value) => phone = value),
                  SizedBox(height: 15.0),
                  TextFormField(
                      initialValue: widget.existed ? widget.email : null,
                      style: ktitleStyle.copyWith(),
                      // controller: titleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 20.0),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: emailValidator,
                      textInputAction: TextInputAction.done,
                      onEditingComplete: () {
                        onFormSubmited();
                      },
                      onSaved: (value) => email = value),
                  SizedBox(
                    height: 20,
                  ),
                  DatePicker(
                    fetchTime: fetchTime,
                    initialDateTime: widget.pickedTime,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  OutlineButton(
                    padding: EdgeInsets.all(15.0),
                    shape: StadiumBorder(),
                    borderSide: BorderSide(color: Colors.white),
                    onPressed: () {
                      onFormSubmited();
                    },
                    child: Text(
                      'Submit',
                      style: ktitleStyle.copyWith(fontSize: 20.0),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

//validators for the form
String emailValidator(value) {
  if (value.isEmpty || !value.contains('@')) {
    return 'Enter a valid Email';
  }
  return null;
}

String phoneNumberValidator(value) {
  if (value.isEmpty || value.length != 10 || double.tryParse(value) == null) {
    return 'Enter a valid Phone Number';
  }
  return null;
}

String nameValidator(value) {
  if (value.isEmpty) {
    return 'Title is empty';
  }
  return null;
}
