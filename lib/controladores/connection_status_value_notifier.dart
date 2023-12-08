import 'dart:async';

import 'package:PerfectConnection/controladores/check_internet.dart';
import 'package:PerfectConnection/main.dart';
import 'package:flutter/cupertino.dart';

class ConnectionStatusValueNotifier extends ValueNotifier<ConnectionStatus> {
  // Nos ayuda a mantener una suscripción con la
  // clase [CheckInternetConnection]
  late StreamSubscription _connectionSubscription;

  ConnectionStatusValueNotifier() : super(ConnectionStatus.online) {
    // Cada vez que se emite un nuevos estado actualizamos [value]
    // esto va hacer que nuestro widget se vuelva a construir.
    _connectionSubscription = internetChecker
        .internetStatus()
        .listen((newStatus) => value = newStatus);
  }

  @override
  void dispose() {
    // Cancelamos la subscription
    _connectionSubscription.cancel();
    super.dispose();
  }
}
