import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'PokemonDetail.dart';

class PokemonList extends StatelessWidget {
  final String query = """
  query {
    pokemon_v2_pokemon {
      pokemon_v2_pokemontypes {
        pokemon_v2_type {
          name
        }
      }
      name
      id
    }
  }
  """;

  const PokemonList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
      ),
      body: Query(
        options: QueryOptions(
          document: gql(query),
        ),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          // gestion des exceptions et chargement omis pour la clarté
          if (result.hasException) {
            return Text('Error: ${result.exception.toString()}');
          }

          if (result.isLoading) {
            return const CircularProgressIndicator();
          }

          List pokemons = result.data?['pokemon_v2_pokemon'];

          return ListView.builder(
            itemCount: pokemons.length,
            itemBuilder: (context, index) {
              final pokemon = pokemons[index];
              return ListTile(
                //leading: Image.network(pokemon['image']),
                title: Text(pokemon['name']),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PokemonDetail(pokemonId: pokemon['id'].toString()),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
