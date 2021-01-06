import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/reservation.dart';

class FirebaseApi {
  static Future addReservation(Reservation newReservation) async {
    final reservationDoc =
        FirebaseFirestore.instance.collection('reservations').doc();
    newReservation.id = reservationDoc.id;
    newReservation.updatedAt = Timestamp.now();
    await reservationDoc.set(newReservation.toJson());
  }

  static Future updateReservation(Reservation reservation) async {
    reservation.updatedAt = Timestamp.now();
    final doc = FirebaseFirestore.instance
        .collection('reservations')
        .doc(reservation.id);

    await doc.update(reservation.toJson());
  }

  static Stream readReservation() => FirebaseFirestore.instance
      .collection('reservations')
      .orderBy('updatedAt', descending: true)
      .snapshots();

  static Future deleteReservation(String id) async {
    final doc = FirebaseFirestore.instance.collection('reservations').doc(id);
    await doc.delete();
  }
}
