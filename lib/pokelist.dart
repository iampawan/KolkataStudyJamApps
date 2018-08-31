import 'dart:convert';

import 'package:KolkataStudyJam/pokedetail.dart';
import 'package:KolkataStudyJam/pokemon.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PokeList extends StatefulWidget {
  @override
  _PokeListState createState() => _PokeListState();
}

class _PokeListState extends State<PokeList>
    with SingleTickerProviderStateMixin {
  Pokehub pokelist;
  Animation<double> animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeIn));

    animation.addListener(() {
      setState(() {});
    });

    animationController.forward();

    fetchPokeList();
  }

  fetchPokeList() async {
    var res = await http.get(
        "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json");
    var decodedJson = jsonDecode(res.body);
    pokelist = Pokehub.fromJson(decodedJson);
    print(pokelist);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text("Poke App"),
      ),
      body: pokelist != null
          ? GridView.count(
              crossAxisCount: 2,
              children: pokelist.pokemon
                  .map((pokemon) => InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PokeDetail(
                                      pokemon: pokemon,
                                    ))),
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Hero(
                                tag: pokemon.img,
                                child: Container(
                                  height: 100.0,
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                        pokemon.img,
                                      ))),
                                ),
                              ),
                              Text(
                                pokemon.name,
                                style:
                                    TextStyle(fontSize: animation.value * 15.0),
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            )
          : Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.pink,
              ),
            ),
    );
  }
}
