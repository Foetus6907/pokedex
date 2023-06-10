import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PokemonDetail extends StatelessWidget {
  final String pokemonId;

  const PokemonDetail({Key? key, required this.pokemonId}) : super(key: key);

  // add in this query the pokemonId class variable
  final String query = """
  query (\$id: Int!) {
    pokemon_v2_pokemon(where: {id: {_eq: \$id}}) {
      name
      id
      height
      base_experience
      weight
      pokemon_v2_pokemontypes {
        pokemon_v2_type {
          name
        }
      }
      pokemon_v2_pokemonsprites {
        sprites
      }
    }
  }
  """;

  @override
  Widget build(BuildContext context) {
    List<String> homeMadeSprite = [
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/$pokemonId.png',
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/$pokemonId.png',
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pokemonId.png',
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/$pokemonId.png',
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/$pokemonId.png',
    ];

    return MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Pokemon Detail'),
          ),
          body: Query(
            options: QueryOptions(
              document: gql(query),
              variables: {
                'id': pokemonId,
              },
            ),
            builder: (QueryResult result,
                {VoidCallback? refetch, FetchMore? fetchMore}) {
              // gestion des exceptions et chargement
              if (result.hasException) {
                return Text('Error: ${result.exception.toString()}');
              }
              if (result.isLoading) {
                return const CircularProgressIndicator();
              }

              final pokemon = result.data?['pokemon_v2_pokemon'][0];

              // print in the console the pokemon data
              final String sprites =
                  pokemon['pokemon_v2_pokemonsprites'][0]['sprites'];

              // create a function to parse sprites as a Map
              List<String> parseSprites(String sprites) {
                //print(sprites);
                final Map<String, dynamic> parsed = jsonDecode(sprites);
                // iterate through the parsed Map and print each key-value pair.
                List<String> urls = [];
                String baseUrl =
                    "https://raw.githubusercontent.com/PokeAPI/sprites";
                parsed.forEach((key, value) {
                  if (value.runtimeType == String &&
                      parsed[key] != null &&
                      value != null) {
                    urls.add(value);
                  }
                });
                // add baseUrls at the beginning of url to the urls list
                urls = urls
                    .map((url) =>
                        baseUrl +
                        url.replaceAll("media", "master").replaceAll(
                            "/sprites/pokemon/",
                            "/sprites/pokemon/other/home/"))
                    .toList();

                return urls;
              }

              List<String> spritesParsed = parseSprites(sprites);

              final imageUrl =
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/$pokemonId.png';
              final defaultUrl =
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pokemonId.png';

              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                      child: Image.network(imageUrl,
                          errorBuilder: (context, error, stackTrace) {
                        return Image.network(defaultUrl,
                            errorBuilder: (context, error, stackTrace) {
                          return Image.network(spritesParsed[0],
                              errorBuilder: (context, error, stackTrace) {
                            return const Text('Could not load image');
                          });
                        });
                      }),
                    ),
                    /*Make this prettier display date in an elegant table */
                    ListTile(
                      leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Image.network(imageUrl,
                              errorBuilder: (context, error, stackTrace) {
                            return Image.network(defaultUrl,
                                errorBuilder: (context, error, stackTrace) {
                              return Image.network(spritesParsed[0],
                                  errorBuilder: (context, error, stackTrace) {
                                return const Text('Could not load image');
                              });
                            });
                          })),
                      title: const Text('Mane'),
                      subtitle: Text(pokemon['name']),
                      trailing: const Icon(Icons.favorite_rounded),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      leading: const CircleAvatar(child: Text('A')),
                      title: const Text('Type'),
                      subtitle: Text(pokemon['pokemon_v2_pokemontypes'][0]
                          ['pokemon_v2_type']['name']),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      leading: const CircleAvatar(child: Text('A')),
                      title: const Text('Type'),
                      subtitle: Text(pokemon['pokemon_v2_pokemontypes'][0]
                          ['pokemon_v2_type']['name']),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      leading: const CircleAvatar(child: Text('A')),
                      title: const Text('Height'),
                      subtitle: Text(pokemon['height'].toString()),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      leading: const CircleAvatar(child: Text('A')),
                      title: const Text('Base Experience'),
                      subtitle: Text(pokemon['base_experience'].toString()),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      leading: const CircleAvatar(child: Text('A')),
                      title: const Text('Weight'),
                      subtitle: Text(pokemon['weight'].toString()),
                    ),
                    const Divider(height: 0),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: homeMadeSprite.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Image.network(
                              homeMadeSprite[index],
                              errorBuilder: (context, error, stackTrace) {
                                return const Text('😢');
                              },
                            );
                          }),
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
