import 'package:flutter/material.dart';
import 'package:flutter_base_app/views/home_view.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'dart:async';

class ConnectionCheckerWidget extends StatefulWidget {
  @override
  _ConnectionCheckerWidgetState createState() =>
      _ConnectionCheckerWidgetState();
}

class _ConnectionCheckerWidgetState extends State<ConnectionCheckerWidget> {
  final InternetConnectionChecker _connectionChecker =
  InternetConnectionChecker();
  late StreamSubscription<InternetConnectionStatus> _subscription;

  @override
  void initState() {
    super.initState();
    _startMonitoringConnection();
  }

  void _startMonitoringConnection() {
    _subscription = _connectionChecker.onStatusChange.listen(
          (InternetConnectionStatus status) {
        if (status == InternetConnectionStatus.connected) {
          print('Connected to the internet');
          // Internet geri geldiğinde, önceki dialogu kapat.
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        } else {
          print('Disconnected from the internet');
          // İnternet yoksa, bir uyarı göster.
          _showNoConnectionDialog();
        }
      },
    );
  }

  void _showNoConnectionDialog() {
    // Dialog zaten açıksa yeni bir tane açma
    if (Navigator.canPop(context)) return;

    showDialog(
      context: context,
      barrierDismissible: false, // Kullanıcı dialogu manuel kapatamasın
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Bağlantı Sorunu',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: ListTile(
            leading: Icon(Icons.wifi,color: Colors.red,size: 30,),
            title: Text(
              'Lütfen bağlantınızı kontrol edin.',
              style: TextStyle(fontSize: 17),
            ),
            titleAlignment: ListTileTitleAlignment.center,
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {

              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Tekrar Bağlan...'),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _subscription.cancel(); // Aboneliği iptal et
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeView(),
    );
  }
}