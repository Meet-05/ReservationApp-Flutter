import 'package:flutter/material.dart';
import '../services/auth.dart';
import './reservtion_screen.dart';

import '../widgets/reservtion_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Reservations'),
          actions: [
            IconButton(icon: Icon(Icons.exit_to_app), onPressed: Auth.logout)
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReservationScreen(
                            existed: false,
                          )));
            }),
        body: ReservationList());
  }
}
