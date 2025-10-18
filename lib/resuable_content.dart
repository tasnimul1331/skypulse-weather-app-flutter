import 'package:flutter/material.dart';

// Add this as a separate widget (outside your _WeatherScreenState class)
class WeatherInfoItem extends StatelessWidget {
  final String label;
  final String value;

  const WeatherInfoItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class HourlyForecastItem extends StatelessWidget {
  final String? time;
  final IconData? icon;
  final String? temperature;
  final bool isNow;

  const HourlyForecastItem({
    super.key,
    this.time,
    this.icon,
    this.temperature,
    this.isNow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: isNow
            ? Colors.white.withValues(alpha: 0.3)
            : Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            // isNow ?
            'Now',
            // : time,
            style: TextStyle(
              color: Colors.white,
              fontSize: isNow ? 16 : 14,
              fontWeight: isNow ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Icon(icon, color: isNow ? Colors.amber : Colors.white, size: 40),
          const SizedBox(height: 12),
          Text(
            "",
            // temperature,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
