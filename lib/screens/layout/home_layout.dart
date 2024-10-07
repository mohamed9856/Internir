import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:internir/components/custom_text_form_field.dart';
import 'package:internir/constants/constants.dart';
import 'package:internir/constants/end_points.dart';
import 'package:internir/utils/size_config.dart';
import '../../providers/index_provider.dart';
import '../home/home_screen.dart';
import '../saved/saved_internships.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_color.dart';
import 'package:provider/provider.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});
  static const routeName = '/home-layout';

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  var pages = [
    const HomeScreen(),
    Container(),
    const SavedInternships(),
    Container(),
  ];

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var indexProvider = Provider.of<IndexProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  'Add new jobs',
                  style: TextStyle(
                    color: AppColor.mainBlue,
                    fontFamily: 'NotoSans',
                    fontSize: 20 * SizeConfig.textRatio,
                  ),
                ),
              ),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: SizeConfig.screenWidth * .8,
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Title",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 16 * SizeConfig.textRatio,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 8 * SizeConfig.verticalBlock,
                        ),
                        customTextFormField(),
                        SizedBox(
                          height: 20 * SizeConfig.verticalBlock,
                        ),
                        Text(
                          "Category",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 16 * SizeConfig.textRatio,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 8 * SizeConfig.verticalBlock,
                        ),
                        /*
                        DropdownButtonFormField(
                          items: [
                            for (var i = 0; i < listCategories.length; ++i)
                              DropdownMenuItem(
                                child: Text(listCategories[i]),
                                value: listCategories[i],
                              ),
                          ],
                          onChanged: (value) {},
                          // initial value
                          value: listCategories[0],
                          style: TextStyle(
                            fontSize: 16 * SizeConfig.textRatio,
                            fontFamily: 'NotoSans',
                            color: AppColor.black,
                          ),
                          isExpanded: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColor.lightBlue.withOpacity(.08),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        
                        */
                        DropdownMenu<String>(
                          
                          dropdownMenuEntries: listCategories
                              .map((e) => DropdownMenuEntry(
                                    label: e,
                                    value: e,
                                  ))
                              .toList(),
                          enableFilter: true,

                          menuStyle: const MenuStyle(
                            alignment: Alignment.bottomLeft,
                          ),
                          requestFocusOnTap: true,
                          onSelected: (country) {},
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'NotoSans',
                            color: AppColor.black,
                          ),
                          initialSelection: listCategories[0],
                        ),
                        SizedBox(
                          height: 20 * SizeConfig.verticalBlock,
                        ),
                        Text(
                          "Location",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 16 * SizeConfig.textRatio,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 8 * SizeConfig.verticalBlock,
                        ),
                        customTextFormField(),
                        SizedBox(
                          height: 20 * SizeConfig.verticalBlock,
                        ),
                        Text(
                          "Salary",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 16 * SizeConfig.textRatio,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 8 * SizeConfig.verticalBlock,
                        ),
                        customTextFormField(),
                        SizedBox(
                          height: 20 * SizeConfig.verticalBlock,
                        ),
                        Text(
                          "Employment Type",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 16 * SizeConfig.textRatio,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 8 * SizeConfig.verticalBlock,
                        ),
                        customTextFormField(),
                        // select dropdown
                        SizedBox(
                          height: 20 * SizeConfig.verticalBlock,
                        ),

                        Text(
                          "Description",
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontSize: 16 * SizeConfig.textRatio,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 8 * SizeConfig.verticalBlock,
                        ),
                        // text editor
                        customTextFormField(
                          keyboardType: TextInputType.multiline,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        backgroundColor: AppColor.mainGreen,
        child: const Icon(Icons.add),
      ),
      body: pages[indexProvider.index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: indexProvider.index,
        onTap: (index) {
          indexProvider.setIndex(index);
        },
        backgroundColor: AppColor.background,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppAssets.homeIcon),
            label: "Home",
            activeIcon: SvgPicture.asset(AppAssets.homeOpenIcon),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(AppAssets.applyListImage),
            label: "Apply List",
            activeIcon: Image.asset(AppAssets.applyListOpenImage),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(AppAssets.savedImage),
            label: "Saved",
            activeIcon: Image.asset(AppAssets.savedOpenImage),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(AppAssets.profileImage),
            label: "Profile",
            activeIcon: Image.asset(AppAssets.profileOpenImage),
          ),
        ],
      ),
    );
  }
}
