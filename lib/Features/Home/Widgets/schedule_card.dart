import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  final String title;
  final String description;
  final String timeText;

  const ScheduleCard({
    super.key,
    required this.title,
    required this.description,
    required this.timeText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            timeText,
            style: const TextStyle(
              color: Color(0xFF3B72FF),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildTimelineRow('9 AM', false),
          _buildTimelineRow('10 AM', true, title: title, description: description),
          _buildTimelineRow('11 AM', false),
          _buildTimelineRow('12 AM', false),
        ],
      ),
    );
  }

  Widget _buildTimelineRow(String time, bool hasCard, {String? title, String? description}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 45,
            child: Text(
              time,
              style: const TextStyle(
                color: Color(0xFF3B72FF),
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: hasCard
                ? Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE4ECFF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title ?? '',
                                style: const TextStyle(
                                  color: Color(0xFF3B72FF),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                description ?? '',
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.check_circle, color: Colors.white, size: 16),
                        const SizedBox(width: 4),
                        const Icon(Icons.cancel, color: Colors.white, size: 16),
                      ],
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: _DashedLine(),
                  ),
          ),
        ],
      ),
    );
  }
}

class _DashedLine extends StatelessWidget {
  const _DashedLine();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 4.0;
        const dashSpace = 4.0;
        final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return const SizedBox(
              width: dashWidth,
              height: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Color(0xFF3B72FF)),
              ),
            );
          }),
        );
      },
    );
  }
}
