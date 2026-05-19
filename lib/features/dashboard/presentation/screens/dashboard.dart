import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rainify/core/common/common_function.dart';
import 'package:rainify/features/dashboard/bloc/bloc_event.dart';
import 'package:rainify/features/dashboard/data/model/forcast_main_model.dart';

import '../../../../core/common/app_const.dart';
import '../../../../core/common/widgets/error_widget.dart';
import '../../bloc/bloc.dart';
import '../../bloc/bloc_state.dart';
import '../../../../core/common/widgets/bottom_navbar_widget.dart';
import '../widgets/current_details_widget.dart';
import '../widgets/hourly_forcast_widget.dart';
import '../widgets/left_slide_animation.dart';
import '../widgets/seven_days_forcast_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    context.read<DashboardBloc>().add(ForcastDataLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoadingState) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (state is DashboardSuccessState) {
          ForcastModel forcastData = state.forcastModel;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppConst.glassmorphicColor,
              elevation: 5,
              leading: Icon(
                Icons.location_on_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                "${forcastData.location!.name}, ${forcastData.location!.country}",
                style: Theme.of(
                  context,
                ).textTheme.displayLarge!.copyWith(fontSize: 20),
              ),
              actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
            ),
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate([
                    // Header section
                    LeftSlideAnimation(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 50.0),
                          Image.network(
                            'https:${forcastData.current!.condition!.icon!}',
                            color: AppConst.primaryColor,
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                          ),
                          // Icon(Icons.wb_sunny_outlined, size: 100),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                forcastData.current!.tempC.toString(),
                                style: Theme.of(
                                  context,
                                ).textTheme.displayMedium,
                              ),
                              const SizedBox(width: 5),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "o",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(fontSize: 30),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            forcastData.current!.condition!.text!,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            dateTimeFormatter(forcastData.location!.localtime!),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    // Card section
                    LeftSlideAnimation(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: .start,
                                        crossAxisAlignment: .start,
                                        children: [
                                          Text(
                                            "Feels Like".toUpperCase(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(letterSpacing: 0),
                                          ),
                                          const SizedBox(height: 5.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                forcastData.current!.feelslikeC
                                                    .toString(),
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.titleSmall,
                                              ),
                                              const SizedBox(width: 1),
                                              Align(
                                                alignment: Alignment.topCenter,
                                                child: Text(
                                                  "o",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .copyWith(fontSize: 15.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: .end,
                                        crossAxisAlignment: .end,
                                        children: [
                                          Text(
                                            "High / Low".toUpperCase(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(letterSpacing: 0),
                                          ),
                                          const SizedBox(height: 5.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    forcastData
                                                        .forecast!
                                                        .forecastday!
                                                        .first
                                                        .day!
                                                        .maxtempC
                                                        .toString(),
                                                    style: Theme.of(
                                                      context,
                                                    ).textTheme.titleSmall,
                                                  ),
                                                  const SizedBox(width: 1),
                                                  Align(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: Text(
                                                      "o",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall!
                                                          .copyWith(
                                                            fontSize: 15.0,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "/",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .copyWith(
                                                      letterSpacing: 10,
                                                    ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    forcastData
                                                        .forecast!
                                                        .forecastday!
                                                        .first
                                                        .day!
                                                        .mintempC
                                                        .toString(),
                                                    style: Theme.of(
                                                      context,
                                                    ).textTheme.titleSmall,
                                                  ),
                                                  const SizedBox(width: 1),
                                                  Align(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: Text(
                                                      "o",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall!
                                                          .copyWith(
                                                            fontSize: 15.0,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(height: 50.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.water_drop_outlined),
                                        const SizedBox(width: 5),
                                        Text(
                                          "Humidity: ${forcastData.current!.humidity.toString()}%",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                fontSize: 16.0,
                                                letterSpacing: 0,
                                              ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.air_outlined),
                                        const SizedBox(width: 5),
                                        Text(
                                          "Wind: ${forcastData.current!.windKph.toString()} km/h",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                fontSize: 16.0,
                                                letterSpacing: 0,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    // Hourly forcast section
                    LeftSlideAnimation(
                      child: HourlyForcaseWidget(forcastData: forcastData),
                    ),
                    const SizedBox(height: 30.0),
                    // Current Details section
                    LeftSlideAnimation(
                      child: CurrentDetailsWidget(forcastData: forcastData),
                    ),
                    // 7-Day forcast section
                    LeftSlideAnimation(
                      child: SevenDaysForcastWidget(forcastData: forcastData),
                    ),
                  ]),
                ),
              ],
            ),
            bottomNavigationBar: const BottomNavbarWidget(),
          );
        }

        if (state is DashboardErrorState) {
          return CommonErrorWidget(
            onTapEvent: () =>
                context.read<DashboardBloc>().add(ForcastDataLoaded()),
          );
        }
        return SizedBox();
      },
    );
  }
}
