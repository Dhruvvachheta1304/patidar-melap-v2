import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:patidar_melap_app/app/helpers/extensions/extensions.dart';
import 'package:patidar_melap_app/app/theme/spacing.dart';

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
          'Basic Detail',
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
      body: ListView(
        children: [
          Container(
            child: const ClipOval(
              child: Image(
                height: 220,
                width: 220,
                fit: BoxFit.cover,
                image: NetworkImage('https://images2.alphacoders.com/122/1224512.jpg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
