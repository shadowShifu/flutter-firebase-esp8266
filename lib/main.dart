import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Mi Casa'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  DatabaseReference foco1 = FirebaseDatabase.instance.ref("/casa/foco");
  DatabaseReference foco2 = FirebaseDatabase.instance.ref("/casa/foco2");
  DatabaseReference foco3 = FirebaseDatabase.instance.ref("/casa/foco3");
  DatabaseReference foco4 = FirebaseDatabase.instance.ref("/casa/foco4");
  DatabaseReference puerta = FirebaseDatabase.instance.ref("/casa/puerta");
  DatabaseReference refCasa = FirebaseDatabase.instance.ref("/casa");

  bool _fc1 = false;
  bool _fc2 = false;
  bool _fc3 = false;
  bool _fc4 = false;
  bool _cp = false;

  @override
  void initState() {
    super.initState();
    _encenderFoco();
    _encenderFoco2();
    _encenderFoco3();
    _encenderFoco4();
    _abrirChapa();
  }

  void _encenderFoco() async {
    bool estado;
    await foco1.get().then((value) => {
          if (value.value == true)
            {
              estado = false,
              setState(() {
                _fc1 = false;
              })
            }
          else
            {
              estado = true,
              setState(() {
                _fc1 = true;
              })
            },
          refCasa.update({
            "foco": estado,
          }),
          print("Iniciado 1")
        });
  }

  void _encenderFoco2() async {
    bool estado;
    await foco2.get().then((value) => {
          if (value.value == true)
            {
              estado = false,
              setState(() {
                _fc2 = false;
              })
            }
          else
            {
              estado = true,
              setState(() {
                _fc2 = true;
              })
            },
          refCasa.update({
            "foco2": estado,
          }),
          print("Iniciado 2")
        });
  }

  void _encenderFoco3() async {
    bool estado;
    await foco3.get().then((value) => {
          if (value.value == true)
            {
              estado = false,
              setState(() {
                _fc3 = false;
              })
            }
          else
            {
              estado = true,
              setState(() {
                _fc3 = true;
              })
            },
          refCasa.update({
            "foco3": estado,
          })
        });
  }

  void _encenderFoco4() async {
    bool estado;
    await foco4.get().then((value) => {
          if (value.value == true)
            {
              estado = false,
              setState(() {
                _fc4 = false;
              })
            }
          else
            {
              estado = true,
              setState(() {
                _fc4 = true;
              })
            },
          refCasa.update({
            "foco4": estado,
          })
        });
  }

  void _abrirChapa() async {
    bool estado;
    await puerta.get().then((value) => {
          print(value.value),
          if (value.value == true)
            {
              estado = false,
              setState(() {
                _cp = false;
              })
            }
          else
            {
              estado = true,
              setState(() {
                _cp = true;
              })
            },
          refCasa.update({
            "puerta": estado,
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 100,
            ),
            const Text(
              'Focos de la casa',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _encenderFoco,
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _fc1 == true ? Colors.amber : Colors.white,
                      foregroundColor: Colors.black),
                  child: const Text('Foco 1'),
                ),
                ElevatedButton(
                    onPressed: _encenderFoco2,
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _fc2 == true ? Colors.amber : Colors.white,
                        foregroundColor: Colors.black),
                    child: const Text('Foco 2')),
                ElevatedButton(
                    onPressed: _encenderFoco3,
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _fc3 == true ? Colors.amber : Colors.white,
                        foregroundColor: Colors.black),
                    child: const Text('Foco 3')),
                ElevatedButton(
                    onPressed: _encenderFoco4,
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _fc4 == true ? Colors.amber : Colors.white,
                        foregroundColor: Colors.black),
                    child: const Text('Foco 4')),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Puerta de la casa',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _abrirChapa,
              child: Text(_cp == true ? 'Abierto' : 'Cerrado'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: _cp == true ? Colors.green : Colors.red,
                  foregroundColor: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
