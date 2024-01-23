import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_training_app/core/config/material_config.dart';
import 'package:yoga_training_app/features/search/widgets/search_provider.dart';
import 'package:yoga_training_app/features/startup/pages/startup_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Rechercher une session'),
        ),
        body: const SearchBody(),
      ),
    );
  }
}

class SearchBody extends StatelessWidget {
  const SearchBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'A 2 clics de trouver ta prochaine session...',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchProvider.search('');
                  },
                ),
              ),
              onSubmitted: searchProvider.search,
            )),
        Expanded(
          child: searchProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: searchProvider.results.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StartupScreen(
                                        course:
                                            searchProvider.results[index])));
                          },
                          child: Row(children: [
                            Text(
                                "${searchProvider.results[index].name} - ${searchProvider.results[index].students} - ${searchProvider.results[index].time} min"),
                            const Spacer(),
                            Icon(
                              Icons.arrow_right_alt_rounded,
                              color: black.withOpacity(0.3),
                            ),
                          ])),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
