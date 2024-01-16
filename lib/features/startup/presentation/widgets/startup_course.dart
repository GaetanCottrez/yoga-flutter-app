import 'package:flutter/material.dart';
import 'package:yoga_training_app/core/log/print.dart';
import 'package:yoga_training_app/features/home/data/models/course.dart';
import 'package:yoga_training_app/core/constants/constants.dart';
import 'package:yoga_training_app/features/home/data/models/pose.dart';
import 'package:yoga_training_app/features/startup/presentation/pages/details_pose_screen.dart';

class StartupCourse extends StatelessWidget {
  final Course _course;

  StartupCourse(this._course);

  Future<Course> getCourse() async {
    return _course;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          displayCourseTitle(),
          displayCourseTimeAndDifficulty(),
          displayCourseImg(),
          displayCourseDescription(),
          ButtonStartup(),
          Expanded(
            child: FutureBuilder<Course>(
              future: this.getCourse(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // The scroll is still being written, show a loading indicator
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // The ink has spilled, let’s display an error
                  return Center(child: Text('Error loading course'));
                } else if (snapshot.hasData) {
                  // The scroll is ready to be revealed
                  List<Pose> poses = snapshot.data!.poses.toList();
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: poses.length,
                    itemBuilder: (context, index) {
                      return _buildPoses(context, poses[index]);
                    },
                  );
                } else {
                  // The scroll is blank, no courses found
                  return Center(child: Text('No course found'));
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Padding ButtonStartup() {
    return Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: appPadding, vertical: 5),
        child: Center(
            child: ElevatedButton(
          style: ButtonStyle(
              textStyle: MaterialStateTextStyle.resolveWith(
                (states) => const TextStyle(
                  color: white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              shadowColor: MaterialStateColor.resolveWith((states) => primary),
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => primary)),
          onPressed: () {
            /* Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => rUready(
                          YogaTableName: widget.yogaSum.YogaWorkOutName,
                        ))); */
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              // This will keep our Row nice and snug, only as wide as its contents.
              children: [
                Text(
                  "DEMARRER",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: 4),
                // A breath of space between the text and the icon
                Icon(
                  Icons.play_arrow,
                  color: Colors.black.withOpacity(0.3),
                ),
              ],
            ),
          ),
        )));
  }

  Padding displayCourseDescription() {
    return Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: appPadding, vertical: 10),
        child: Text(
          _course.description,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            letterSpacing: 1.5,
          ),
        ));
  }

  Padding displayCourseImg() {
    return Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: appPadding, vertical: 5),
        child: Center(child: Image.network(_course.imageUrl, width: 250)));
  }

  Padding displayCourseTimeAndDifficulty() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: appPadding, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.access_time_filled,
            color: black.withOpacity(0.3),
          ),
          Text(
            _course.time.toString() + " min",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              letterSpacing: 1.5,
            ),
          ),
          Text(
            " - ",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              letterSpacing: 1.5,
            ),
          ),
          Icon(
            Icons.bar_chart,
            color: black.withOpacity(0.3),
          ),
          Text(
            _course.students,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Padding displayCourseTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: appPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _course.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPoses(BuildContext context, Pose pose) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: appPadding, vertical: appPadding / 2),
      child: Container(
        height: size.height * 0.2,
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                  color: black.withOpacity(0.3),
                  blurRadius: 30.0,
                  offset: Offset(10, 15))
            ]),
        child: Padding(
          padding: const EdgeInsets.all(appPadding),
          child: GestureDetector(
              onTap: () {
                printInternal(pose.english_name);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsPoseScreen(pose: pose)));
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // Ensure the children align at the start
                children: [
                  Container(
                    width: size.width * 0.3,
                    height: size.height * 0.2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(pose.img_url_jpg),
                    ),
                  ),
                  Flexible(
                    // The key here is the use of Flexible around the second container
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: appPadding / 2, top: appPadding / 1.5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: displayDataPose(pose, size),
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  List<Widget> displayDataPose(Pose pose, Size size) {
    return [
      Row(children: [
        Text(
          pose.english_name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          maxLines: 2,
        ),
        Spacer(),
        Icon(
          Icons.arrow_right_alt_rounded,
          color: black.withOpacity(0.3),
        ),
      ]),
      SizedBox(
        height: size.height * 0.01,
      ),
      Row(
        children: [
          Icon(
            Icons.abc,
            color: black.withOpacity(0.3),
          ),
          SizedBox(
            width: size.width * 0.01,
          ),
          Flexible(
            // Wrap only the overflowing text with another Flexible
            child: Text(
              pose.sanskrit_name,
              style: TextStyle(
                color: black.withOpacity(0.3),
              ),
              overflow: TextOverflow
                  .ellipsis, // To prevent your text from breaking the screen's embrace
            ),
          ),
        ],
      ),
      SizedBox(
        height: size.height * 0.01,
      ),
      Row(
        children: [
          Icon(
            Icons.description,
            color: black.withOpacity(0.3),
          ),
          SizedBox(
            width: size.width * 0.01,
          ),
          Flexible(
            // Wrap only the overflowing text with another Flexible
            child: Text(
              pose.description,
              style: TextStyle(
                color: black.withOpacity(0.3),
              ),
              overflow: TextOverflow
                  .ellipsis, // To prevent your text from breaking the screen's embrace
            ),
          ),
        ],
      ),
      SizedBox(
        height: size.height * 0.01,
      ),
      Row(
        children: [
          Icon(
            Icons.upgrade_rounded,
            color: black.withOpacity(0.3),
          ),
          SizedBox(
            width: size.width * 0.01,
          ),
          Flexible(
            // Wrap only the overflowing text with another Flexible
            child: Text(
              pose.benefits,
              style: TextStyle(
                color: black.withOpacity(0.3),
              ),
              overflow: TextOverflow
                  .ellipsis, // To prevent your text from breaking the screen's embrace
            ),
          ),
        ],
      ),
    ];
  }
}
