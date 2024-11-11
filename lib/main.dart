import 'package:flutter/material.dart';
import 'package:pokedex/dao/pokeDao.dart';
import 'package:pokedex/estilos/bordatexto.dart';
import 'package:pokedex/estilos/botoes.dart';
import 'package:pokedex/estilos/pokebola.dart';
import 'package:pokedex/network/pokeNet.dart';
import 'package:pokedex/repositorio/pokeImpl.dart';
import 'package:pokedex/telas/capturar.dart';
import 'package:pokedex/telas/listaPoke.dart';
import 'package:pokedex/telas/time.dart';
import 'package:provider/provider.dart';

// 'http://192.168.0.23:3000/pokemon'
void main() {
  
  runApp(const Home());
}
class Home extends StatelessWidget{
  const Home({super.key});

  @override
  Widget build (BuildContext context){
    return MultiProvider(
      providers:[
         Provider<PokemonRepositoryImpl>(create: (_) => PokemonRepositoryImpl()),

         Provider<PokemonNetwork>(create: (_) => PokemonNetwork()),
         
         Provider<PokemonDao>(create: (_) => PokemonDao()),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainApp(),
      routes: {
        'tela1': (context) => const Lista(),
        'tela2': (context) => CapturarScreen(),
        'tela3': (context) => TimeScreen(),
      },
    ),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 248, 182),
      body:Stack(
          children: [
            Image.asset(
              'images/fundo.jpg',
              fit: BoxFit.cover,  // Faz a imagem cobrir toda a tela
              width: double.infinity,  
              height: double.infinity,  
              alignment: Alignment.center,
            ),
            const Fundopoke(),
            const Padding(
              padding: EdgeInsets.only(top: 220.0, left: 30.0),
              child: BorderedText(
                text: "Pokedex",
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 80.0,
                  fontWeight: FontWeight.bold,
                ),
                borderWidth: 16.0, // Espessura da borda
                borderColor: Color.fromARGB(255, 148, 46, 32),
              ),
            ),
            const SizedBox(height:55.0),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height:350.0),
                  CustomOutlinedButton(
                    onPressed: () { 
                      Navigator.pushNamed(context, 'tela1');
                     }, 
                    text: 'Pokedex',
                  ),
                  const SizedBox(height:25.0),
                  CustomOutlinedButton(
                    onPressed: () { 
                      Navigator.pushNamed(context, 'tela2');
                     }, 
                    text: 'Capturar',
                  ),
                  const SizedBox(height:25.0),
                  CustomOutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'tela3');
                     }, 
                    text: 'Time',
                  ),
                ],
              ),
            ),
          ],
      ),
    );
  }
}
