import 'package:flutter/material.dart';
import 'package:yoga_training_app/domain/entities/statistics.dart';
import 'package:yoga_training_app/domain/use-cases/use-cases.interface.dart';

class StatisticsScreen extends StatelessWidget {
  final IGetStatisticsUseCase getStatistics;

  const StatisticsScreen({Key? key, required this.getStatistics})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vos statistiques'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<StatsData>(
          future: getStatistics.call(),
          // Call the use case.
          builder: (BuildContext context, AsyncSnapshot<StatsData> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                  snapshot.data!.totalLaunchedSessionCount
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold)),
                              const Text('Session(s) effectuée(s)',
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                  ('${snapshot.data!.averageSessionDuration} min.'),
                                  style: const TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold)),
                              const Text(
                                'De session moyenne',
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Poses les plus pratiquées:',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                ...?snapshot.data?.mostPracticedPoses.map((pose) {
                  return Card(
                    child: ListTile(
                      title: Text('${pose.englishName} (${pose.sanskritName})'),
                      subtitle:
                          Text('Nombre de fois pratiquée: ${pose.poseCount}'),
                    ),
                  );
                }),
              ],
            );
          },
        ),
      ),
    );
  }
}
