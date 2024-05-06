import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:patidar_melap_app/app/routes/app_router.dart';
import 'package:patidar_melap_app/gen/locale_keys.g.dart';
import 'package:patidar_melap_app/modules/profile/widget/custom_profile_tabs.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.27,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.red, Colors.pink.shade600],
                  ),
                ),
              ),
              const Spacer(),
              Column(
                children: [
                  CustomProfileTabs(
                    disableColor: true,
                    onTap: () {},
                    text: LocaleKeys.add_more_photos.tr(),
                  ),
                  AbsorbPointer(
                    // absorbing: false,
                    child: CustomProfileTabs(
                      disableColor: false,
                      onTap: () {
                        context.pushRoute(const BasicDetailsRoute());
                      },
                      text: LocaleKeys.basic_details.tr(),
                    ),
                  ),
                  CustomProfileTabs(
                    disableColor: false,
                    onTap: () {},
                    text: LocaleKeys.family_information.tr(),
                  ),
                  CustomProfileTabs(
                    disableColor: false,
                    onTap: () {},
                    text: LocaleKeys.other_details.tr(),
                  ),
                ],
              ),
              const Spacer(
                flex: 2,
              )
            ],
          ),
          Positioned(
            top: 130,
            right: 100,
            child: Container(
              child: const ClipOval(
                child: Image(
                  height: 220,
                  width: 220,
                  fit: BoxFit.cover,
                  image: NetworkImage('https://images2.alphacoders.com/122/1224512.jpg'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
