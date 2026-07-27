import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:ktmtommy_apps/assets_helper/app_colors.dart';
import 'package:ktmtommy_apps/assets_helper/app_icons.dart';
import 'package:ktmtommy_apps/networks/api_acess.dart';
import 'package:ktmtommy_apps/features/recovery_mood_section/my_equipment/model/schedule_feedback_model.dart';

class DateWidget extends StatefulWidget {
  final ValueChanged<DateTime>? onDateSelected;

  const DateWidget({super.key, this.onDateSelected});

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  final ScrollController _scrollController = ScrollController();
  DateTime? _selectedDate;
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _fetchFeedback();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchFeedback() {
    final now = DateTime.now();
    final fromDate = now.subtract(const Duration(days: 15));
    final toDate = now.add(const Duration(days: 15));

    final fromStr = DateFormat('yyyy-MM-dd').format(fromDate);
    final toStr = DateFormat('yyyy-MM-dd').format(toDate);

    scheduleFeedbackRxObj.getScheduleFeedback(fromStr, toStr).then((_) {
      _scrollToToday();
    });
  }

  void _scrollToToday() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final data = scheduleFeedbackRxObj.dataFetcher.valueOrNull?.data;
      if (data == null || data.isEmpty) return;

      final todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final index = data.indexWhere((element) => element.date == todayStr);
      if (index != -1) {
        setState(() {
          _selectedIndex = index;
          _selectedDate = DateTime.now();
        });

        // Width of item is 38.w + padding of 6.w on each side = 50.w
        final double itemWidth = 50.w;
        final screenWidth = MediaQuery.of(context).size.width;
        final scrollOffset =
            (index * itemWidth) - (screenWidth / 2) + (itemWidth / 2);

        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            scrollOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  void _onDateTap(int index, FeedbackDatum item) {
    if (item.date == null) return;
    final parsedDate = DateTime.tryParse(item.date!);
    if (parsedDate == null) return;

    setState(() {
      _selectedIndex = index;
      _selectedDate = parsedDate;
    });

    if (widget.onDateSelected != null) {
      widget.onDateSelected!(parsedDate);
    }
  }

  void _scrollLeft() {
    if (_scrollController.hasClients) {
      final double target = _scrollController.offset - 150.w;
      _scrollController.animateTo(
        target.clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollRight() {
    if (_scrollController.hasClients) {
      final double target = _scrollController.offset + 150.w;
      _scrollController.animateTo(
        target.clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  String _getHeaderText() {
    if (_selectedDate == null) return '';
    return DateFormat('MMMM yyyy').format(_selectedDate!);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ScheduleFeedbackModel>(
      stream: scheduleFeedbackRxObj.scheduleFeedbackStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 120.h,
            child: const Center(
              child: CircularProgressIndicator(color: AppColors.c87B842),
            ),
          );
        }

        if (snapshot.hasError) {
          return SizedBox(
            height: 120.h,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Failed to load calendar',
                    style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                  ),
                  SizedBox(height: 8.h),
                  TextButton(
                    onPressed: _fetchFeedback,
                    child: const Text(
                      'Retry',
                      style: TextStyle(color: AppColors.c87B842),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final list = snapshot.data?.data ?? [];
        if (list.isEmpty) {
          return SizedBox(
            height: 120.h,
            child: Center(
              child: Text(
                'No calendar data available',
                style: TextStyle(color: Colors.white70, fontSize: 14.sp),
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Month Header
            Row(
              children: [
                GestureDetector(
                  onTap: _scrollLeft,
                  child: const Icon(Icons.chevron_left,
                      color: Colors.white, size: 26),
                ),
                SizedBox(width: 8.w),
                Text(
                  _getHeaderText(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: _scrollRight,
                  child: const Icon(Icons.chevron_right,
                      color: Colors.white, size: 26),
                ),
              ],
            ),
            SizedBox(height: 18.h),

            // Horizontal calendar scroll list
            SizedBox(
              height: 85.h,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final item = list[index];
                  final date = DateTime.tryParse(item.date ?? '');
                  if (date == null) return const SizedBox.shrink();

                  final dayName = DateFormat('E').format(date); // e.g. "Sat"
                  final isSelected = index == _selectedIndex;

                  // Map rating to DateType
                  DateType type = DateType.normal;
                  if (item.rating == 'best') {
                    type = DateType.crown;
                  } else if (item.rating == 'good') {
                    type = DateType.star;
                  } else if (item.rating == 'poor') {
                    type = DateType.disabled;
                  }

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          dayName,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey,
                            fontSize: 13.sp,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        _DateCircle(
                          label: date.day.toString(),
                          isSelected: isSelected,
                          type: type,
                          onTap: () => _onDateTap(index, item),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

enum DateType { crown, star, disabled, normal }

class _DateCircle extends StatelessWidget {
  final String label;
  final bool isSelected;
  final DateType type;
  final VoidCallback onTap;

  const _DateCircle({
    required this.label,
    required this.isSelected,
    required this.type,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.transparent;
    Widget? icon;
    Color textColor = Colors.white;

    if (type == DateType.crown) {
      bgColor = const Color(0xFFFFC107); // yellow
      icon = SvgPicture.asset(AppIcons.bestIcon, height: 20);
    } else if (type == DateType.star) {
      bgColor = const Color(0xFF4CAF50); // green
      icon = SvgPicture.asset(AppIcons.goodIcon, height: 20);
    } else if (type == DateType.disabled) {
      bgColor = const Color(0xFF5A5A5A); // grey
      icon = SvgPicture.asset(AppIcons.poorIcon, height: 20);
      textColor = Colors.white70;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38.w,
        height: 48.w,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.horizontal(
            right: Radius.circular(50),
            left: Radius.circular(50),
          ),
          border: isSelected ? Border.all(color: Colors.red, width: 2) : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (icon != null) ...[
              SizedBox(height: 2.h),
              icon,
            ],
          ],
        ),
      ),
    );
  }
}
