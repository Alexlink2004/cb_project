import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cabildo Proyect',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Joder Buenas',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '¡Hola! ¡Bien hecho! Has compilado la aplicación exitosamente. Esto significa que has configurado Flutter en tu PC correctamente. Aquí empieza el proyecto, aunque aún falta definir el flujo de interfaz en Figma. Por el momento, esta es la primera vista.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              SizedBox(
                width: 100,
                height: 100,
                child: FlutterLogo(),
              ),
              Expanded(
                child: SizedBox(),
              ),
              // Image(
              //   image:
              //   width: 100,
              //   height: 100,
              //   fit: BoxFit.cover,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
