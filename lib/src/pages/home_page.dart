import 'dart:io';

import 'package:band_names_app/src/services/socket_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:band_names_app/src/models/band.dart';
import 'package:provider/provider.dart';



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

    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('BandNames', style: TextStyle( color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [

          Container(
            margin: EdgeInsets.only( right: 20 ),
            child: ( socketService.serverStatus == ServerStatus.Online ) 
              ? Icon( Icons.check_circle, color: Colors.blue[300])
              : Icon( Icons.wifi_off_outlined, color: Colors.red[300]),
              
          )
        ],
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) => _bandTile(bands[index])
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBand,
        child: Icon( Icons.add ),
        elevation: 1,
        backgroundColor: Colors.blue[400],
        ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key( band.id ),
      direction: DismissDirection.startToEnd,
      confirmDismiss: (DismissDirection direction){
        return showDialog(
          context: context, 
          builder: ( BuildContext context ){
            return AlertDialog(
              title: Text('Are you sure to delete ${band.name} ?'),
              actions: [
                MaterialButton(
                  onPressed: (){
                    Navigator.pop(context, true);
                  },
                  child: Icon( CupertinoIcons.check_mark, color: Colors.blue.withOpacity(0.8), )
                  ),
                MaterialButton(
                  onPressed: (){
                    Navigator.pop(context, false);
                  },
                  child: Icon ( CupertinoIcons.xmark, color: Colors.blue.withOpacity(0.8), ),
                  ),  
              ],

            );
          } 
          );
      },
      onDismissed: ( DismissDirection direction){
        print( band.id );
        print( band.name );
        //TODO: Call to server to erase the band
      },
      background: Container(
        padding: EdgeInsets.only( left: 15.0 ),
        alignment: Alignment.centerLeft,
        color: Colors.red.withOpacity(0.7),
          child: Icon( CupertinoIcons.trash, color: Colors.white,)
      ),
      child: ListTile(
        leading: CircleAvatar(
              backgroundColor: Colors.blue[200],
              child: Text( band.name.substring(0, 2).toUpperCase()),
            ),
        title: Text( band.name),
        trailing: Text('${band.votes}', style: TextStyle( fontSize: 20),),
        onTap: (){
          print(band.name);
        },
      ),
    );
  }

  addNewBand(){

  final textController = TextEditingController();

  if ( Platform.isWindows ){

    return showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text('Enter the name of the band'),
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: () => addNewBandToList( textController.text ),
            child: Text('Add'),
            textColor: Colors.blue,
            )
        ],
      )
      );
  }

    return showCupertinoDialog(
      context: context, 
      builder: ( context ) => CupertinoAlertDialog(
        title: Text('Enter the name of the band'),
        content: CupertinoTextField(
          controller: textController,
        ),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Add'), 
            onPressed: () => addNewBandToList( textController.text ),
            ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: Text('Close'),
            onPressed: () => Navigator.pop(context),
            ),
        ],
      )
    );
}


  void addNewBandToList ( String name ){

    print( name );

    if ( name.length > 1 ){
      bands.add( Band(id: DateTime.now().toString(), name: name, votes: 2));
      setState(() {});
    }

      Navigator.pop(context);

  } 
}