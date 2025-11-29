import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:job_search_app/constants/app_constants.dart';
import 'package:job_search_app/controllers/skills_provider.dart';
import 'package:job_search_app/models/request/auth/add_skills.dart';
import 'package:job_search_app/models/response/auth/skills.dart';
import 'package:job_search_app/services/helpers/auth_helper.dart';
import 'package:job_search_app/views/common/app_style.dart';
import 'package:job_search_app/views/common/height_spacer.dart';
import 'package:job_search_app/views/common/reusable_text.dart';
import 'package:job_search_app/views/common/width_spacer.dart';
import 'package:job_search_app/views/screens/auth/widgets/addSkills.dart';
import 'package:provider/provider.dart';

class SkillsWidget extends StatefulWidget {
  const SkillsWidget({super.key});

  @override
  State<SkillsWidget> createState() => _SkillsWidgetState();
}

class _SkillsWidgetState extends State<SkillsWidget> {
  TextEditingController skillsController = TextEditingController();
  late Future<List<Skills>> userSkills;

  @override
  void initState() {
    userSkills = getSkills();
    super.initState();
  }

  Future<List<Skills>> getSkills() async {
    var skills = await AuthHelper.getSkills();
    return skills;
  }

  @override
  Widget build(BuildContext context) {
    var skillsNotifier = Provider.of<SkillsNotifier>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReusableText(
                text: "Skills",
                style: appStyle(14, Color(kDark.value), FontWeight.w600),
              ),
              Consumer<SkillsNotifier>(
                builder: (context, skillsNotifier, child) {
                  return skillsNotifier.addSkills != true
                      ? GestureDetector(
                          onTap: () {
                            skillsNotifier.setSkills =
                                !skillsNotifier.addSkills;
                          },
                          child: Icon(
                            MaterialCommunityIcons.plus_circle_outline,
                            color: Color(kDark.value),
                            size: 24,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            skillsNotifier.setSkills =
                                !skillsNotifier.addSkills;
                          },
                          child: Icon(
                            MaterialCommunityIcons.close_circle_outline,
                            color: Color(kDark.value),
                            size: 24,
                          ),
                        );
                },
              ),
            ],
          ),
        ),
        HeightSpacer(size: 5),
        skillsNotifier.addSkills == true
            ? AddSkillsWidget(
                skill: skillsController,
                onTap: () async {
                  try {
                    AddSkill rawModel = AddSkill(skill: skillsController.text);
                    var model = addSkillToJson(rawModel);
                    await AuthHelper.addSkills(model);
                    skillsController.clear();
                    if (mounted) {
                      setState(() {
                        userSkills = getSkills();
                        skillsNotifier.setSkills = !skillsNotifier.addSkills;
                      });
                    }
                  } catch (e) {
                    print('Add skill error: $e');
                  }
                },
              )
            : SizedBox(
                height: 45.w,
                child: FutureBuilder(
                  future: userSkills,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error loading skills");
                    } else {
                      var skills = snapshot.data;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: skills!.length,
                        itemBuilder: (context, index) {
                          var skill = skills[index];
                          return GestureDetector(
                            onLongPress: () {
                              skillsNotifier.setSkillsId = skill.id;
                            },
                            onTap: () {
                              skillsNotifier.setSkillsId = '';
                            },
                            child: Container(
                              padding: EdgeInsets.all(5.w),
                              margin: EdgeInsets.all(4.w),
                              decoration: BoxDecoration(
                                color: Color(kLightGrey.value),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(14.w),
                                ),
                              ),
                              child: Row(
                                children: [
                                  ReusableText(
                                    text: skill.skill,
                                    style: appStyle(
                                      12,
                                      Color(kDark.value),
                                      FontWeight.w500,
                                    ),
                                  ),
                                  WidthSpacer(width: 5),
                                  skillsNotifier.addSkillsId == skill.id
                                      ? GestureDetector(
                                          onTap: () async {
                                            try {
                                              await AuthHelper.deleteSkill(
                                                skillsNotifier.addSkillsId,
                                              );
                                              if (mounted) {
                                                setState(() {
                                                  userSkills = getSkills();
                                                });
                                                skillsNotifier.setSkillsId = '';
                                              }
                                            } catch (e) {
                                              print('Delete error: $e');
                                            }
                                          },
                                          child: Icon(
                                            AntDesign.delete,
                                            size: 14,
                                            color: Color(kDark.value),
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
      ],
    );
  }
}
