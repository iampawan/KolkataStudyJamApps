import 'package:KolkataStudyJam/pokemon.dart';
import 'package:flutter/material.dart';

class PokeDetail extends StatelessWidget {
  final Pokemon pokemon;

  PokeDetail({this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(pokemon.name),
        backgroundColor: Colors.cyan,
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            height: MediaQuery.of(context).size.height / 1.5,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      pokemon.name,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Height: ${pokemon.height}"),
                    Text("Weight: ${pokemon.weight}"),
                    Text("Types"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: pokemon.type
                          .map((t) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FilterChip(
                                  label: Text(t),
                                  onSelected: (b) {},
                                  backgroundColor: Colors.amber,
                                ),
                              ))
                          .toList(),
                    ),
                    Text("Weaknesses"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: pokemon.weaknesses
                          .map((t) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FilterChip(
                                  label: Text(
                                    t,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onSelected: (b) {},
                                  backgroundColor: Colors.red,
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: pokemon.img,
              child: Container(
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          pokemon.img,
                        ))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
