class Pose {
  final int id;
  final String sanskrit_name;
  final String english_name;
  final String description;
  final String benefits;
  final String img_url_svg;
  final String img_url_jpg;
  final String img_url_svg_alt;

  Pose(
      {required this.id,
      required this.sanskrit_name,
      required this.english_name,
      required this.description,
      required this.benefits,
      required this.img_url_svg,
      required this.img_url_jpg,
      required this.img_url_svg_alt});
}
