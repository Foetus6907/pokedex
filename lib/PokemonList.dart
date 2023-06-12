import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'PokemonDetail.dart';

class PokemonList extends StatefulWidget {
  const PokemonList({Key? key}) : super(key: key);

  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
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

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: const InputDecoration(
            hintText: 'Search Pokemon',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
          ),
          style: const TextStyle(color: Colors.white),
          onChanged: (value) {
            setState(() {
              _searchQuery = value.toLowerCase();
            });
          },
        ),
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

          // Filter the pokemons list based on the search query
          List filteredPokemons = pokemons
              .where((pokemon) =>
                  pokemon['name'].toLowerCase().contains(_searchQuery))
              .toList();

          return ListView.builder(
            itemCount: filteredPokemons.length,
            itemBuilder: (context, index) {
              final pokemon = filteredPokemons[index];
              final imageUrl =
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/${pokemon['id']}.png';
              final defaultUrl =
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemon['id']}.png';
              return ListTile(
                leading: Image.network(imageUrl,
                    errorBuilder: (context, error, stackTrace) {
                  return Image.network(defaultUrl,
                      errorBuilder: (context, error, stackTrace) {
                    return const Text('Could not load image');
                  });
                }),
                title: Text(pokemon['name']),
                subtitle: Wrap(
                  spacing: 8.0,
                  children: [
                    for (final type in pokemon['pokemon_v2_pokemontypes'])
                      Image.asset(
                        'assets/poketype/${type['pokemon_v2_type']['name']}.png',
                        width: 25,
                        height: 25,
                      ),
                  ],
                ),
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
