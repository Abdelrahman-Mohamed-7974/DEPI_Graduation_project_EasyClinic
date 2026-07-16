import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../ViewModel/home_view_model.dart';
import '../Cubit/home_cubit.dart';
import '../Widgets/home_header.dart';
import '../Widgets/search_bar_widget.dart';
import '../Widgets/category_item.dart';
import '../Widgets/calendar_item.dart';
import '../Widgets/schedule_card.dart';
import '../Widgets/doctor_card.dart';
import '../../Notification/View/notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel _viewModel = HomeViewModel();

  final List<Map<String, String>> _days = [
    {'dayName': 'MON', 'dayNumber': '9'},
    {'dayName': 'TUE', 'dayNumber': '10'},
    {'dayName': 'WED', 'dayNumber': '11'},
    {'dayName': 'THU', 'dayNumber': '12'},
    {'dayName': 'FRI', 'dayNumber': '13'},
    {'dayName': 'SAT', 'dayNumber': '14'},
  ];

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeader(
                  userName: 'John Doe',
                  userImage: 'https://i.pravatar.cc/150?img=11',
                  onNotificationTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationScreen(),
                      ),
                    );
                  },
                  onSettingsTap: () {},
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    CategoryItem(
                      title: 'Doctors',
                      icon: Icons.medical_services_outlined,
                      onTap: () {},
                    ),
                    const SizedBox(width: 24),
                    CategoryItem(
                      title: 'Favorite',
                      icon: Icons.favorite_border,
                      onTap: () {},
                    ),
                    const SizedBox(width: 24),
                    const Expanded(child: SearchBarWidget()),
                  ],
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE4ECFF),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _days.length,
                          itemBuilder: (context, index) {
                            final day = _days[index];
                            return CalendarItem(
                              dayName: day['dayName']!,
                              dayNumber: day['dayNumber']!,
                              isSelected: _viewModel.selectedDayIndex == index,
                              onTap: () => _viewModel.selectDay(index),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      const ScheduleCard(
                        title: 'Dr. Olivia Turner, M.D.',
                        description:
                            'Treatment and prevention of\nskin and photodermatitis.',
                        timeText: '11 Wednesday - Today',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is HomeLoaded) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.doctors.length,
                        itemBuilder: (context, index) {
                          final doc = state.doctors[index];
                          return DoctorCard(
                            doctorName: doc['name'] as String,
                            specialty: doc['specialization'] as String,
                            image: doc['image'] as String,
                            rating: (doc['rating'] as num).toDouble(),
                            messagesCount: doc['number_of_reviews'] as int,
                            isFavorite: (doc['is_favorite_user'] as int?) == 1,
                            onFavoriteToggle: () {
                              context.read<HomeCubit>().toggleFavorite(
                                doc['id'] as int,
                                (doc['is_favorite_user'] as int?) == 1,
                              );
                            },
                          );
                        },
                      );
                    } else if (state is HomeError) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
