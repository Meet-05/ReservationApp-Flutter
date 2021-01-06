import 'package:flutter/material.dart';
import 'package:reservationApp/services/firebase_api.dart';
import '../widgets/reservaiton_card.dart';

class ReservationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseApi.readReservation(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final docs = snapshot.data.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) => ReservationCard(
                name: docs[index]['name'],
                phone: docs[index]['phoneNumber'],
                email: docs[index]['email'],
                date: docs[index]['date'].toDate(),
                id: docs[index]['id']),
          );
        });
  }
}
