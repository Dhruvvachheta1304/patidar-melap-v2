import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:patidar_melap_app/app/helpers/extensions/extensions.dart';
import 'package:patidar_melap_app/app/theme/spacing.dart';
import 'package:patidar_melap_app/app/theme/text.dart';
import 'package:patidar_melap_app/gen/locale_keys.g.dart';

@RoutePage()
class BasicDetailsScreen extends StatefulWidget {
  const BasicDetailsScreen({super.key});

  @override
  State<BasicDetailsScreen> createState() => _BasicDetailsScreenState();
}

class _BasicDetailsScreenState extends State<BasicDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.basic_details.tr(),
          style: TextStyle(
            fontSize: 16,
            color: context.colorScheme.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: const PreferredSize(preferredSize: Size.fromHeight(10), child: VSpace(5)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: context.colorScheme.grey100,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          VSpace.large(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Image(
                  height: 180,
                  width: 180,
                  fit: BoxFit.cover,
                  image: NetworkImage('https://images2.alphacoders.com/122/1224512.jpg'),
                ),
              ),
            ],
          ),
          VSpace.small(),
          Text(
            '${LocaleKeys.index_number.tr()} : A58506',
            style: TextStyle(
              fontSize: 18,
              color: context.colorScheme.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          AppText.muktaVaani(
            'data',
            color: context.colorScheme.danger500,
            fontSize: 40,
          ),
          Container(
            decoration: BoxDecoration(
              color: context.colorScheme.grey100,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              children: [
                bulletPoint('પાસપોર્ટ સાઈઝનો કે એના જેવો જ ફોટો મુકવો. શોખના ચશ્મા, ટોપી પહેરેલો કે સેલ્ફીનો ફોટો મુકવો નહિ.')
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget bulletPoint(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('• ', style: TextStyle(fontSize: 20.0)), // Bullet point
        Expanded(child: Text(text)), // Text
      ],
    ),
  );
}
