import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/components/drawer_tile.dart';
import 'package:notes/pages/settings_page.dart';

class MyDrawer extends StatelessWidget{
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context){
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              children: [
                //header
                const DrawerHeader(child: Icon(Icons.note)),
                //notes tile
                DrawerTile(title: "Notes" , leading: const Icon(Icons.home), onTap: ()=> Navigator.pop(context), ),

                //settings tile
                DrawerTile(title: "Settings", leading: const Icon(Icons.settings),
                    onTap: ()=>{
                      Navigator.pop(context),
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsPage()))
                    }
                )
              ],
            ),
          ),

          Padding(
              padding: EdgeInsets.all(25),
            child: Text("D i v y a n s h  H a r n e", style: GoogleFonts.montserrat(fontSize: 18,color: Theme.of(context).colorScheme.inversePrimary,fontWeight: FontWeight.w200),),
          )
        ],
      )
    );
  }
}
