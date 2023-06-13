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
      pokemon_v2_pokemonspecy {
        name
        is_mythical
        is_legendary
        is_baby
        pokemon_v2_pokemonspeciesflavortexts(where: {language_id: {_eq: 5}}) {
          flavor_text
        }
        pokemon_v2_pokemons {
          pokemon_v2_pokemonspecy {
            pokemon_v2_pokemonspeciesnames(where: {language_id: {_eq: 5}}) {
              name
            }
          }
        }
      }
    }
  }
""";
/* Query response id : 

{
  "data": {
    "pokemon_v2_pokemon": [
      {
        "name": "caterpie",
        "id": 10,
        "height": 3,
        "base_experience": 39,
        "weight": 29,
        "pokemon_v2_pokemontypes": [
          {
            "pokemon_v2_type": {
              "name": "bug"
            }
          }
        ],
        "pokemon_v2_pokemonsprites": [
          {
            "sprites": "{\"front_default\": \"/media/sprites/pokemon/10.png\", \"front_female\": null, \"front_shiny\": \"/media/sprites/pokemon/shiny/10.png\", \"front_shiny_female\": null, \"back_default\": \"/media/sprites/pokemon/back/10.png\", \"back_female\": null, \"back_shiny\": \"/media/sprites/pokemon/back/shiny/10.png\", \"back_shiny_female\": null, \"other\": {\"dream_world\": {\"front_default\": \"/media/sprites/pokemon/other/dream-world/10.svg\", \"front_female\": null}, \"home\": {\"front_default\": \"/media/sprites/pokemon/other/home/10.png\", \"front_female\": null, \"front_shiny\": \"/media/sprites/pokemon/other/home/shiny/10.png\", \"front_shiny_female\": null}, \"official-artwork\": {\"front_default\": \"/media/sprites/pokemon/other/official-artwork/10.png\", \"front_shiny\": \"/media/sprites/pokemon/other/official-artwork/shiny/10.png\"}}, \"versions\": {\"generation-i\": {\"red-blue\": {\"front_default\": \"/media/sprites/pokemon/versions/generation-i/red-blue/10.png\", \"front_gray\": \"/media/sprites/pokemon/versions/generation-i/red-blue/gray/10.png\", \"back_default\": \"/media/sprites/pokemon/versions/generation-i/red-blue/back/10.png\", \"back_gray\": \"/media/sprites/pokemon/versions/generation-i/red-blue/back/gray/10.png\", \"front_transparent\": \"/media/sprites/pokemon/versions/generation-i/red-blue/transparent/10.png\", \"back_transparent\": \"/media/sprites/pokemon/versions/generation-i/red-blue/transparent/back/10.png\"}, \"yellow\": {\"front_default\": \"/media/sprites/pokemon/versions/generation-i/yellow/10.png\", \"front_gray\": \"/media/sprites/pokemon/versions/generation-i/yellow/gray/10.png\", \"back_default\": \"/media/sprites/pokemon/versions/generation-i/yellow/back/10.png\", \"back_gray\": \"/media/sprites/pokemon/versions/generation-i/yellow/back/gray/10.png\", \"front_transparent\": \"/media/sprites/pokemon/versions/generation-i/yellow/transparent/10.png\", \"back_transparent\": \"/media/sprites/pokemon/versions/generation-i/yellow/transparent/back/10.png\"}}, \"generation-ii\": {\"crystal\": {\"front_default\": \"/media/sprites/pokemon/versions/generation-ii/crystal/10.png\", \"front_shiny\": \"/media/sprites/pokemon/versions/generation-ii/crystal/shiny/10.png\", \"back_default\": \"/media/sprites/pokemon/versions/generation-ii/crystal/back/10.png\", \"back_shiny\": \"/media/sprites/pokemon/versions/generation-ii/crystal/back/shiny/10.png\", \"front_transparent\": \"/media/sprites/pokemon/versions/generation-ii/crystal/transparent/10.png\", \"front_shiny_transparent\": \"/media/sprites/pokemon/versions/generation-ii/crystal/transparent/shiny/10.png\", \"back_transparent\": \"/media/sprites/pokemon/versions/generation-ii/crystal/transparent/back/10.png\", \"back_shiny_transparent\": \"/media/sprites/pokemon/versions/generation-ii/crystal/transparent/back/shiny/10.png\"}, \"gold\": {\"front_default\": \"/media/sprites/pokemon/versions/generation-ii/gold/10.png\", \"front_shiny\": \"/media/sprites/pokemon/versions/generation-ii/gold/shiny/10.png\", \"back_default\": \"/media/sprites/pokemon/versions/generation-ii/gold/back/10.png\", \"back_shiny\": \"/media/sprites/pokemon/versions/generation-ii/gold/back/shiny/10.png\", \"front_transparent\": \"/media/sprites/pokemon/versions/generation-ii/gold/transparent/10.png\"}, \"silver\": {\"front_default\": \"/media/sprites/pokemon/versions/generation-ii/silver/10.png\", \"front_shiny\": \"/media/sprites/pokemon/versions/generation-ii/silver/shiny/10.png\", \"back_default\": \"/media/sprites/pokemon/versions/generation-ii/silver/back/10.png\", \"back_shiny\": \"/media/sprites/pokemon/versions/generation-ii/silver/back/shiny/10.png\", \"front_transparent\": \"/media/sprites/pokemon/versions/generation-ii/silver/transparent/10.png\"}}, \"generation-iii\": {\"emerald\": {\"front_default\": \"/media/sprites/pokemon/versions/generation-iii/emerald/10.png\", \"front_shiny\": \"/media/sprites/pokemon/versions/generation-iii/emerald/shiny/10.png\"}, \"firered-leafgreen\": {\"front_default\": \"/media/sprites/pokemon/versions/generation-iii/firered-leafgreen/10.png\", \"front_shiny\": \"/media/sprites/pokemon/versions/generation-iii/firered-leafgreen/shiny/10.png\", \"back_default\": \"/media/sprites/pokemon/versions/generation-iii/firered-leafgreen/back/10.png\", \"back_shiny\": \"/media/sprites/pokemon/versions/generation-iii/firered-leafgreen/back/shiny/10.png\"}, \"ruby-sapphire\": {\"front_default\": \"/media/sprites/pokemon/versions/generation-iii/ruby-sapphire/10.png\", \"front_shiny\": \"/media/sprites/pokemon/versions/generation-iii/ruby-sapphire/shiny/10.png\", \"back_default\": \"/media/sprites/pokemon/versions/generation-iii/ruby-sapphire/back/10.png\", \"back_shiny\": \"/media/sprites/pokemon/versions/generation-iii/ruby-sapphire/back/shiny/10.png\"}}, \"generation-iv\": {\"diamond-pearl\": {\"front_default\": \"/media/sprites/pokemon/versions/generation-iv/diamond-pearl/10.png\", \"front_female\": null, \"front_shiny\": \"/media/sprites/pokemon/versions/generation-iv/diamond-pearl/shiny/10.png\", \"front_shiny_female\": null, \"back_default\": \"/media/sprites/pokemon/versions/generation-iv/diamond-pearl/back/10.png\", \"back_female\": null, \"back_shiny\": \"/media/sprites/pokemon/versions/generation-iv/diamond-pearl/back/shiny/10.png\", \"back_shiny_female\": null}, \"heartgold-soulsilver\": {\"front_default\": \"/media/sprites/pokemon/versions/generation-iv/heartgold-soulsilver/10.png\", \"front_female\": null, \"front_shiny\": \"/media/sprites/pokemon/versions/generation-iv/heartgold-soulsilver/shiny/10.png\", \"front_shiny_female\": null, \"back_default\": \"/media/sprites/pokemon/versions/generation-iv/heartgold-soulsilver/back/10.png\", \"back_female\": null, \"back_shiny\": \"/media/sprites/pokemon/versions/generation-iv/heartgold-soulsilver/back/shiny/10.png\", \"back_shiny_female\": null}, \"platinum\": {\"front_default\": \"/media/sprites/pokemon/versions/generation-iv/platinum/10.png\", \"front_female\": null, \"front_shiny\": \"/media/sprites/pokemon/versions/generation-iv/platinum/shiny/10.png\", \"front_shiny_female\": null, \"back_default\": \"/media/sprites/pokemon/versions/generation-iv/platinum/back/10.png\", \"back_female\": null, \"back_shiny\": \"/media/sprites/pokemon/versions/generation-iv/platinum/back/shiny/10.png\", \"back_shiny_female\": null}}, \"generation-v\": {\"black-white\": {\"front_default\": \"/media/sprites/pokemon/versions/generation-v/black-white/10.png\", \"front_female\": null, \"front_shiny\": \"/media/sprites/pokemon/versions/generation-v/black-white/shiny/10.png\", \"front_shiny_female\": null, \"back_default\": \"/media/sprites/pokemon/versions/generation-v/black-white/back/10.png\", \"back_female\": null, \"back_shiny\": \"/media/sprites/pokemon/versions/generation-v/black-white/back/shiny/10.png\", \"back_shiny_female\": null, \"animated\": {\"front_default\": \"/media/sprites/pokemon/versions/generation-v/black-white/animated/10.gif\", \"front_female\": null, \"front_shiny\": \"/media/sprites/pokemon/versions/generation-v/black-white/animated/shiny/10.gif\", \"front_shiny_female\": null, \"back_default\": \"/media/sprites/pokemon/versions/generation-v/black-white/animated/back/10.gif\", \"back_female\": null, \"back_shiny\": \"/media/sprites/pokemon/versions/generation-v/black-white/animated/back/shiny/10.gif\", \"back_shiny_female\": null}}}, \"generation-vi\": {\"omegaruby-alphasapphire\": {\"front_default\": \"/media/sprites/pokemon/versions/generation-vi/omegaruby-alphasapphire/10.png\", \"front_female\": null, \"front_shiny\": \"/media/sprites/pokemon/versions/generation-vi/omegaruby-alphasapphire/shiny/10.png\", \"front_shiny_female\": null}, \"x-y\": {\"front_default\": \"/media/sprites/pokemon/versions/generation-vi/x-y/10.png\", \"front_female\": null, \"front_shiny\": \"/media/sprites/pokemon/versions/generation-vi/x-y/shiny/10.png\", \"front_shiny_female\": null}}, \"generation-vii\": {\"ultra-sun-ultra-moon\": {\"front_default\": \"/media/sprites/pokemon/versions/generation-vii/ultra-sun-ultra-moon/10.png\", \"front_female\": null, \"front_shiny\": \"/media/sprites/pokemon/versions/generation-vii/ultra-sun-ultra-moon/shiny/10.png\", \"front_shiny_female\": null}, \"icons\": {\"front_default\": \"/media/sprites/pokemon/versions/generation-vii/icons/10.png\", \"front_female\": null}}, \"generation-viii\": {\"icons\": {\"front_default\": \"/media/sprites/pokemon/versions/generation-viii/icons/10.png\", \"front_female\": null}}}}"
          }
        ],
        "pokemon_v2_pokemonspecy": {
          "name": "caterpie",
          "is_mythical": false,
          "is_legendary": false,
          "is_baby": false,
          "pokemon_v2_pokemonspeciesflavortexts": [
            {
              "flavor_text": "Ses antennes rouges libèrent une\npuanteur qui repousse l’ennemi.\nIl grandit par mues régulières."
            },
            {
              "flavor_text": "Ses antennes rouges libèrent une\npuanteur qui repousse l’ennemi.\nIl grandit par mues régulières."
            },
            {
              "flavor_text": "Pour se protéger, il émet un gaz puant par ses\nantennes, qui fait fuir ses ennemis audacieux."
            },
            {
              "flavor_text": "Ses pattes ont des ventouses lui permettant de\ngrimper sur toute surface, notamment les arbres."
            },
            {
              "flavor_text": "Chenipan a un appétit d’ogre. Il peut engloutir des feuilles\nplus grosses que lui. Les antennes de ce Pokémon dégagent\nune odeur particulièrement entêtante."
            },
            {
              "flavor_text": "Chenipan a un appétit d’ogre. Il peut engloutir des feuilles\nplus grosses que lui. Les antennes de ce Pokémon dégagent\nune odeur particulièrement entêtante."
            },
            {
              "flavor_text": "Lorsqu’il est attaqué par un Pokémon Vol,\nil utilise ses antennes pour dégager une odeur\nnauséabonde, mais cela le sauve rarement."
            },
            {
              "flavor_text": "Un Pokémon facile à attraper et qui croît\nrapidement. C’est l’un des partenaires\nprivilégiés des Dresseurs débutants."
            },
            {
              "flavor_text": "C’est peut-être parce qu’il a envie de grandir\nle plus vite possible qu’il est si vorace.\nIl engloutit une centaine de feuilles par jour."
            },
            {
              "flavor_text": "Son corps est mou et sans force.\nLa nature semble l’avoir destiné à servir\nde proie aux autres Pokémon."
            },
            {
              "flavor_text": "Quand on touche l’appendice sur son front,\nil sécrète une odeur nauséabonde pour se\nprotéger."
            },
            {
              "flavor_text": "Quand on touche l’appendice sur son front,\nil sécrète une odeur nauséabonde pour se\nprotéger."
            },
            {
              "flavor_text": "Pour se protéger, il émet par ses antennes\nune odeur nauséabonde qui fait fuir ses ennemis."
            },
            {
              "flavor_text": "Ses petites pattes munies de ventouses\nlui permettent de monter les pentes\net de grimper aux murs sans se fatiguer."
            }
          ],
          "pokemon_v2_pokemons": [
            {
              "pokemon_v2_pokemonspecy": {
                "pokemon_v2_pokemonspeciesnames": [
                  {
                    "name": "Chenipan"
                  }
                ]
              }
            }
          ]
        }
      }
    ]
  }
}




*/

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
              final pokemonDescription = pokemon['pokemon_v2_pokemonspecy']
                  ['pokemon_v2_pokemonspeciesflavortexts'][0]['flavor_text'];

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
                    /*Display pokemon flavor in a simple Card*/
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(pokemonDescription),
                      ),
                    ),
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
                      title: const Text('Name'),
                      subtitle: Text(pokemon['pokemon_v2_pokemonspecy']
                                  ['pokemon_v2_pokemons'][0]
                              ['pokemon_v2_pokemonspecy']
                          ['pokemon_v2_pokemonspeciesnames'][0]['name']),
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
