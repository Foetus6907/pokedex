import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'DatabaseService.dart';
import 'PokemonDetail.dart';

class FavoritePokemons extends StatelessWidget {
  const FavoritePokemons({super.key});

  @override
  Widget build(BuildContext context) {
    var databaseService = Provider.of<DatabaseService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Pokemons'),
      ),
      body: FutureBuilder<List<FavoritePokemon>>(
        future: databaseService.getFavoritePokemons(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var pokemons = snapshot.data;

          return ListView.builder(
            itemCount: pokemons!.length,
            itemBuilder: (context, index) {
              final pokemon = pokemons[index];

              return ListTile(
                leading: Image.network(pokemon.imageUrl),
                title: Text(pokemon.name),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    databaseService.removeFavoritePokemon(pokemon.id);
                    // Rafraîchir l'affichage
                    setState(() {});
                  },
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PokemonDetail(pokemonId: pokemon.id),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void setState(Null Function() param0) {}
}

class FavoritePokemon {
  final String id;
  final String name;
  final String imageUrl;

  FavoritePokemon(
      {required this.id, required this.name, required this.imageUrl});
  factory FavoritePokemon.fromJson(Map<String, dynamic> json) {
    return FavoritePokemon(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }
}
