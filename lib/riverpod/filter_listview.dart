import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'filter_listview.g.dart';
@riverpod
class PlayerNotifier extends _$PlayerNotifier{
  final List<Map<String,dynamic>> allplayers=[
    {"name": " Rohit Sharma","country":"India"},
    {"name": " ABC","country":"Africa"},
    {"name": "rafa","country":"Dubai"},
    {"name": "minsha","country":"South Africa"},
    {"name": " afsal","country":"America"},
    {"name": "irshad","country":"Soudi Arabia"},
    {"name": "shahid","country":"New Zealand"},
    {"name": "diya","country":"India"},
    {"name": "shimna ","country":"West India "},
    {"name": "armin","country":"SouthAfrica"},
    {"name": "mikasa","country":"Antartica"},
  ];
  @override
  build() {
    return allplayers;
  }
  void filterPlayer(String playerName){
    List<Map<String,dynamic>>results=[];
    if(playerName.isEmpty){
      results=allplayers;
    }else{
      results=allplayers
          .where((element)=>element['name']
          .toString()
          .toLowerCase()
          .contains(playerName.toLowerCase())
      ).toList();
    }
    state=results;
  }
}
class ListViewFilter extends ConsumerWidget {
  const ListViewFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final players=ref.watch(playerNotifierProvider)as List<Map<String, dynamic>>;
    return Scaffold(
      appBar: AppBar(
        title: Text('filter Listview'),
      ),
      body:Column(
        children: [
          SizedBox(height: 20,),
          TextField(
            onChanged: (value) {
              ref.read(playerNotifierProvider.notifier).filterPlayer(value);
            },
            decoration: InputDecoration(
              labelText: 'search',
              suffixIcon: Icon(Icons.search),
            ),
          ),
          SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(players[index]["name"],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  subtitle: Text(players[index]['country']),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

