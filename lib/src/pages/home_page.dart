import 'package:flutter/material.dart';

import 'package:band_names_app/src/models/band.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  List<Band> bands = [
    Band(
      id: '1', name: 'Metallica', votes: 5
      ),
    Band(
      id: '2', name: 'Aerosmith', votes: 3
      ),
    Band(
      id: '3', name: 'Amon Amarth', votes: 2
      ),
    Band(
      id: '4', name: 'Stratovarius', votes: 6
      ),
    Band(
      id: '5', name: 'Megadeth', votes: 2
      )
      
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BandNames', style: TextStyle( color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) => _bandTile(bands[index])
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon( Icons.add ),
        elevation: 1,
        backgroundColor: Colors.blue[400],
        ),
    );
  }

  ListTile _bandTile(Band band) {
    return ListTile(
      leading: CircleAvatar(
            backgroundColor: Colors.blue[200],
            child: Text( band.name.substring(0, 2).toUpperCase()),
          ),
      title: Text( band.name),
      trailing: Text('${band.votes}', style: TextStyle( fontSize: 20),),
      onTap: (){
        print(band.name);
      },
    );
  }
}