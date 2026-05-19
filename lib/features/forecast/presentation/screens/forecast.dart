import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rainify/features/forecast/presentation/widgets/left_slide_animation.dart';

import '../../../../core/common/app_const.dart';
import '../../../../core/common/widgets/bottom_navbar_widget.dart';
import '../../../../core/common/widgets/error_widget.dart';
import '../widgets/bottom_slide_animation.dart';
import '../widgets/day_card_widget.dart';
import '../../bloc/bloc.dart';
import '../../bloc/bloc_event.dart';
import '../../bloc/bloc_state.dart';
import '../../data/model/forecast_main_model.dart';
import '../../data/model/forecast_model.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({super.key});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  @override
  void initState() {
    context.read<ForecastBloc>().add(ForecastDataLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForecastBloc, ForecastState>(
      builder: (context, state) {
        if (state is ForecastLoadingState) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (state is ForecastSuccessState) {
          ForcastModel forcastData = state.forcastModel;
          final filterDayData = forcastData.forecast!.forecastday!.where((
            item,
          ) {
            return DateTime.parse(item.date!).isAfter(DateTime.now());
          }).toList();
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
                    LeftSlideAnimation(
                      child: Column(
                        mainAxisAlignment: .center,
                        crossAxisAlignment: .center,
                        children: [
                          const SizedBox(height: 50.0),
                          Center(
                            child: Text(
                              "7-Day Forecast",
                              style: Theme.of(context).textTheme.displayMedium!
                                  .copyWith(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Center(
                            child: Text(
                              "Expect a mix of clouds and sun this week.",
                              style: Theme.of(context).textTheme.titleMedium!,
                            ),
                          ),
                          const SizedBox(height: 50.0),
                        ],
                      ),
                    ),
                    BottomSlideAnimation(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        itemCount: filterDayData.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Forecastday forecastday = filterDayData[index];
                          return Column(
                            children: [
                              DayCardWidget(forecastday: forecastday),
                              const SizedBox(height: 10.0),
                            ],
                          );
                        },
                      ),
                    ),
                  ]),
                ),
              ],
            ),
            bottomNavigationBar: const BottomNavbarWidget(),
          );
        }
        if (state is ForecastErrorState) {
          return CommonErrorWidget(
            onTapEvent: () =>
                context.read<ForecastBloc>().add(ForecastDataLoaded()),
          );
        }
        return SizedBox();
      },
    );
  }
}
