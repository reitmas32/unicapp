import 'package:flutter/material.dart';
import 'package:unicapp/apps/yonesto/views/common/drawer.dart';
import 'package:unicapp/core/api_conection.dart';
import 'package:unicapp/shared/tools/string.dart';
import 'package:unicapp/ui/common/atoms/circular_button.dart';
import 'package:unicapp/ui/common/molecules/app_bar.dart';
import 'package:unicapp/ui/common/views/apps_warpper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadUserName();
  }

  String userName = '   ';

  loadUserName() async {
    var response = await uniaccountsAPI.storage.loadUserName();
    setState(() {
      userName = response.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularButton(
            backgroundColor: const Color.fromARGB(255, 102, 96, 96),
            height: 100,
            width: 100,
            child: Text(
              userName.substring(0, 2).toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 50,
              ),
            ),
          ),
          Center(
            child: Text(
                'Buenas Noches ${obtenerPrimeraPalabra(convertirAFormatoNombrePropio(userName))}'),
          ),
          SizedBox(
            height: size.height / 6,
          ),
          const AppsWrapper(),
        ],
      ),
      appBar: const UNICappAppBar(
        title: Text('UNICapp'),
        top: -10,
      ),
      drawer: const YonestoDrawer(),
    );
  }
}
