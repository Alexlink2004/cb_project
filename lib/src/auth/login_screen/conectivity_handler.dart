import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// Asume que ApiConstants y ServerAddressDisplay están definidos en otro lugar
import '../../server/api/api_constants.dart';

class InternetAwareWidget extends StatefulWidget {
  final Widget child;

  const InternetAwareWidget({Key? key, required this.child}) : super(key: key);

  @override
  State<InternetAwareWidget> createState() => _InternetAwareWidgetState();
}

class _InternetAwareWidgetState extends State<InternetAwareWidget> {
  final Dio _dio = Dio();
  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  bool _isServerReachable = false;

  @override
  void initState() {
    super.initState();
    _initializeConnectivityCheck();
  }

  void _initializeConnectivityCheck() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Actualiza el estado de conectividad cada vez que cambia
      setState(() => _connectivityResult = result);
      if (result != ConnectivityResult.none) {
        // Si hay conexión a Internet, verifica la conectividad al servidor
        _checkServerConnectivity();
      }
    });
    // Comprobación inicial
    Connectivity().checkConnectivity().then((result) {
      setState(() => _connectivityResult = result);
      if (result != ConnectivityResult.none) {
        _checkServerConnectivity();
      }
    });
  }

  Future<void> _checkServerConnectivity() async {
    try {
      final response = await _dio.get('${ApiConstants.apiRoute}/users');
      setState(() => _isServerReachable = response.statusCode == 200);
    } catch (_) {
      setState(() => _isServerReachable = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Verifica el estado de la conectividad y muestra el widget correspondiente
    if (_connectivityResult == ConnectivityResult.none) {
      return _buildNoInternetConnection();
    } else if (!_isServerReachable) {
      return _buildServerConnectionFailed();
    }
    // La conectividad al servidor es exitosa, muestra el widget hijo
    return widget.child;
  }

  Widget _buildNoInternetConnection() {
    return Scaffold(
      appBar: AppBar(title: const Text('No hay conexión a Internet')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.signal_wifi_off, size: 100, color: Colors.grey),
            const SizedBox(height: 20),
            const Text('Parece que no estás conectado a Internet.'),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
              onPressed: () => _initializeConnectivityCheck(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServerConnectionFailed() {
    return Scaffold(
      appBar: AppBar(title: const Text('Fallo de conexión al servidor')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_off, size: 100, color: Colors.grey),
            const SizedBox(height: 20),
            const Text('No se puede establecer conexión con el servidor.'),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
              onPressed: () => _checkServerConnectivity(),
            ),
          ],
        ),
      ),
    );
  }
}
