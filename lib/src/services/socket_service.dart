import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;


enum ServerStatus {

  Online,
  Offline,
  Connecting

}

class SocketService with ChangeNotifier {

  ServerStatus _serverStatus = ServerStatus.Connecting;

  SocketService(){

    _initConfig();

  }
  
  void _initConfig() {

      // Dart client
  IO.Socket socket = IO.io('http://localhost:3000',

    IO.OptionBuilder()
      .setTransports(['websocket'])
      .enableAutoConnect()
      .build()
  );

  socket.onConnect((_) {

    print('connect');
    
  });

  socket.onDisconnect((_) => print('disconnect'));

  }
}