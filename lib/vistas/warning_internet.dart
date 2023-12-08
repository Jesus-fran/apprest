import 'package:PerfectConnection/controladores/check_internet.dart';
import 'package:PerfectConnection/controladores/connection_status_value_notifier.dart';
import 'package:flutter/material.dart';

class WarningWidgetValueNotifier extends StatelessWidget {
  const WarningWidgetValueNotifier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ConnectionStatusValueNotifier(),
      builder: (context, ConnectionStatus status, child) {
        return Visibility(
          visible: status != ConnectionStatus.online,
          child: Container(
            padding: const EdgeInsets.all(16),
            height: 60,
            color: Colors.redAccent,
            child: const Row(
              children: [
                Icon(Icons.wifi_off),
                SizedBox(width: 8),
                Text('No hay conexión a internet.'),
              ],
            ),
          ),
        );
      },
    );
  }
}
