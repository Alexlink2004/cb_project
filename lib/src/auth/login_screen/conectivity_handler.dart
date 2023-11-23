import 'dart:async';

import 'package:cb_project/src/auth/login_screen/change_direction_button.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../server/api/api_constants.dart';

class InternetAwareWidget extends StatefulWidget {
  final Widget child;
  const InternetAwareWidget({Key? key, required this.child}) : super(key: key);

  @override
  _InternetAwareWidgetState createState() => _InternetAwareWidgetState();
}

class _InternetAwareWidgetState extends State<InternetAwareWidget> {
  late Stream<ConnectivityResult> connectivityStream;
  final Dio _dio = Dio();
  Timer? _timer;
  bool isCheckingConnection = false;
  @override
  void initState() {
    super.initState();
    connectivityStream = Connectivity().onConnectivityChanged;
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel(); // Cancel any existing timers
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) async {
      final hasConnection = await _checkInternetConnectivity();
      if (hasConnection) {
        _redirectToMainWidget();
        t.cancel();
      }
    });
  }

  Future<bool> _checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return _checkServerConnectivity();
  }

  Future<bool> _checkServerConnectivity() async {
    try {
      final response = await _dio.get('${ApiConstants.apiRoute}/users');
      return response.statusCode == 200;
    } on DioError catch (_) {
      return false;
    }
  }

  void _redirectToMainWidget() {
    if (mounted) {
      setState(
          () {}); // This will trigger a rebuild and display the main widget
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: connectivityStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active &&
            snapshot.data != ConnectivityResult.none) {
          // Internet connection is available, check server connectivity
          return FutureBuilder<bool>(
            future: _checkServerConnectivity(),
            builder: (context, serverSnapshot) {
              if (serverSnapshot.connectionState == ConnectionState.waiting) {
                // Esperando la verificación de la conectividad del servidor
                return _buildLoading();
              } else if (serverSnapshot.data == false) {
                // La verificación de la conectividad del servidor falló
                _startTimer(); // Start or restart the timer
                return _buildServerConnectionFailed();
              }
              // La conectividad del servidor está disponible
              return Stack(
                children: [
                  Positioned(
                    top: 20,
                    right: 20,
                    child: ServerAddressDisplay(),
                  ),
                  widget.child,
                ],
              );
            },
          );
        } else {
          // No internet connection
          _startTimer(); // Start or restart the timer
          return Stack(
            children: [
              const Positioned(
                top: 20,
                right: 20,
                child: ServerAddressDisplay(),
              ),
              _buildNoInternetConnection(),
            ],
          );
        }
      },
    );
  }

  Widget _buildNoInternetConnection() {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned(
            top: 20,
            right: 20,
            child: ServerAddressDisplay(),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballBeat,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'No hay conexión a Internet',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                _buildRetryButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServerConnectionFailed() {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned(
            top: 20,
            right: 20,
            child: ServerAddressDisplay(),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi_tethering_error,
                  size: 50,
                  color: Colors.red,
                ),
                SizedBox(height: 10),
                Text(
                  'No se puede conectar al servidor',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                _buildRetryButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned(
            top: 20,
            right: 20,
            child: ServerAddressDisplay(),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Intentando conectar al servidor',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(
                  width: 100,
                  child: LoadingIndicator(
                    indicatorType: Indicator.orbit,
                  ),
                ),
                const SizedBox(height: 10),
                _buildRetryButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRetryButton() {
    return ElevatedButton.icon(
      icon: const Icon(Icons.refresh),
      label: const Text('Reintentar'),
      onPressed: () async {
        setState(
          () => isCheckingConnection = true,
        );

        bool hasConnection = await _checkServerConnectivity();
        if (hasConnection) {
          _redirectToMainWidget();
        }

        if (mounted) {
          setState(
            () => isCheckingConnection = false,
          );
        }
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.black,
      ),
    );
  }
}
