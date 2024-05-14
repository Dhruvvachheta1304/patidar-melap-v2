import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patidar_melap_app/app/helpers/extensions/extensions.dart';
import 'package:patidar_melap_app/app/theme/spacing.dart';
import 'package:patidar_melap_app/app/theme/text.dart';
import 'package:patidar_melap_app/core/presentation/widgets/custom_text_field.dart';
import 'package:patidar_melap_app/gen/locale_keys.g.dart';
import 'package:patidar_melap_app/modules/basic_detail/bloc/basic_detail/basic_detail_bloc.dart';
import 'package:patidar_melap_app/modules/basic_detail/repository/basic_detail_repository.dart';

@RoutePage()
class FamilyInfoScreen extends StatefulWidget implements AutoRouteWrapper {
  const FamilyInfoScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return RepositoryProvider(
      create: (context) => BasicDetailRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (context) => BasicDetailBloc(
              repository: context.read<BasicDetailRepository>(),
            ),
            child: this,
          ),
        ],
        child: this,
      ),
    );
  }

  @override
  State<FamilyInfoScreen> createState() => _FamilyInfoScreenState();
}

class _FamilyInfoScreenState extends State<FamilyInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.family_information.tr(),
          style: TextStyle(
            fontSize: 16,
            color: context.colorScheme.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: VSpace(5),
        ),
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
        padding: const EdgeInsets.only(left: Insets.medium, right: Insets.medium),
        children: [
          Column(
            children: [
              VSpace.medium(),
              CustomTextField(
                // controller: casteBloc.firstNameController,
                titleDescription: AppText.muktaVaani(
                  LocaleKeys.father_name.tr(),
                  color: context.colorScheme.black,
                ),
                fillColor: context.colorScheme.grey100,
                hintText: LocaleKeys.father_name.tr(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LocaleKeys.common_msg_required_field.tr();
                  }
                  return null;
                },
              ),
              VSpace.small(),
              CustomTextField(
                // controller: casteBloc.firstNameController,
                titleDescription: AppText.muktaVaani(
                  LocaleKeys.mother_name.tr(),
                  color: context.colorScheme.black,
                ),
                fillColor: context.colorScheme.grey100,
                hintText: LocaleKeys.mother_name.tr(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LocaleKeys.common_msg_required_field.tr();
                  }
                  return null;
                },
              ),
              VSpace.small(),
              CustomTextField(
                // controller: casteBloc.firstNameController,
                titleDescription: AppText.muktaVaani(
                  LocaleKeys.grandfather_name.tr(),
                  color: context.colorScheme.black,
                ),
                fillColor: context.colorScheme.grey100,
                hintText: LocaleKeys.grandfather_name.tr(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LocaleKeys.common_msg_required_field.tr();
                  }
                  return null;
                },
              ),
              VSpace.small(),
              Align(
                alignment: Alignment.centerLeft,
                child: AppText.muktaVaani(
                  '${LocaleKeys.father_occupation.tr()} ',
                  fontSize: 14,
                  color: context.colorScheme.grey700,
                ),
              ),
              AppText.muktaVaani(
                '${LocaleKeys.father_occupation_hint.tr()} ',
                fontSize: 14,
                color: context.colorScheme.grey500,
              ),
              VSpace.small(),
              CustomTextField(
                // controller: casteBloc.firstNameController,

                fillColor: context.colorScheme.grey100,
                hintText: LocaleKeys.father_occupation.tr(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LocaleKeys.common_msg_required_field.tr();
                  }
                  return null;
                },
              ),
              VSpace.small(),
              CustomTextField(
                // controller: casteBloc.firstNameController,
                titleDescription: AppText.muktaVaani(
                  '${LocaleKeys.father_income.tr()} (${LocaleKeys.yearly.tr()})',
                  color: context.colorScheme.black,
                ),
                fillColor: context.colorScheme.grey100,
                hintText: LocaleKeys.father_income.tr(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LocaleKeys.common_msg_required_field.tr();
                  }
                  return null;
                },
              ),
              VSpace.small(),
              Align(
                alignment: Alignment.centerLeft,
                child: AppText.muktaVaani(
                  '${LocaleKeys.number_of_brothers.tr()} ',
                  color: context.colorScheme.grey700,
                ),
              ),
              VSpace.small(),
              Divider(
                color: context.colorScheme.grey200,
              ),
              VSpace.small(),
              Row(
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          // controller: casteBloc.firstNameController,
                          titleDescription: AppText.muktaVaani(
                            LocaleKeys.married.tr(),
                            color: context.colorScheme.black,
                          ),
                          fillColor: context.colorScheme.grey100,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LocaleKeys.common_msg_required_field.tr();
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  // const SizedBox(width: 16.0),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          // controller: casteBloc.firstNameController,
                          titleDescription: AppText.muktaVaani(
                            LocaleKeys.unmarried.tr(),
                            color: context.colorScheme.black,
                          ),
                          fillColor: context.colorScheme.grey100,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LocaleKeys.common_msg_required_field.tr();
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          // controller: casteBloc.firstNameController,
                          titleDescription: AppText.muktaVaani(
                            LocaleKeys.divorce.tr(),
                            color: context.colorScheme.black,
                          ),
                          fillColor: context.colorScheme.grey100,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LocaleKeys.common_msg_required_field.tr();
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          // controller: casteBloc.firstNameController,
                          titleDescription: AppText.muktaVaani(
                            LocaleKeys.widower.tr(),
                            color: context.colorScheme.black,
                          ),
                          fillColor: context.colorScheme.grey100,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LocaleKeys.common_msg_required_field.tr();
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
