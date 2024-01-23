import 'dart:math';

class TipsProvider {
  final List<String> _tipsList = [
    'Créez un espace confortable pour votre pratique du yoga.',
    'Le yoga peut atténuer les symptômes de l\'arthrite.',
    'Le yoga est bénéfique pour la santé cardiaque.',
    'Le yoga vous détend pour vous aider à mieux dormir.',
    'Le yoga peut signifier plus d\'énergie et des humeurs plus joyeuses.',
    'Le yoga vous aide à gérer le stress.',
    'Le yoga améliore la posture et la flexibilité.',
    'Pratiquer le yoga contribue à renforcer les muscles.',
    'Le yoga soutient la gestion du poids et le métabolisme.',
    'La méditation et le yoga aident à la clarté mentale.',
    'Le yoga peut réduire l\'anxiété et diminuer les tensions.',
    'La respiration profonde en yoga augmente la capacité pulmonaire.',
    'Les postures de yoga développent l\'équilibre et la coordination.',
    'Le yoga soutient la santé digestive grâce à des postures spécifiques.',
    'La pratique régulière du yoga contribue à un meilleur contrôle des émotions.',
    'Le yoga peut améliorer votre relation avec votre corps et renforcer la confiance en soi.'
  ];

  String getRandomTip() {
    final random = Random();
    int index = random.nextInt(_tipsList.length);
    return _tipsList[index];
  }
}
