import 'package:flutter/material.dart';
import '../theme.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  void _continue(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/main');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            children: [
              Row(
                children: [
                  const Text('Opportunity', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w900)),
                  const Spacer(),
                  TextButton(onPressed: () => _continue(context), child: const Text('Skip')),
                ],
              ),
              const Spacer(),
              SizedBox(
                height: 230,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 20,
                      child: Transform.rotate(
                        angle: -0.12,
                        child: _mockCard(width: 150, height: 185, opacity: 0.72),
                      ),
                    ),
                    Positioned(
                      top: 44,
                      child: Transform.rotate(
                        angle: 0.14,
                        child: _mockCard(width: 172, height: 142, opacity: 1),
                      ),
                    ),
                    Positioned(
                      bottom: 28,
                      left: 54,
                      child: Container(
                        width: 150,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 24, offset: const Offset(0, 10))],
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(radius: 12, backgroundColor: AppColors.textPrimary),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(height: 9, width: 60, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.2), borderRadius: BorderRadius.circular(8))),
                                  const SizedBox(height: 7),
                                  Container(height: 9, width: 86, decoration: BoxDecoration(color: AppColors.accent.withOpacity(0.18), borderRadius: BorderRadius.circular(8))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 34),
              const Text(
                'Find your next\nAndroid challenge',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, height: 1.1),
              ),
              const SizedBox(height: 14),
              const Text(
                'Discover high-impact roles at top-tier companies tailored for your technical expertise.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary, height: 1.45),
              ),
              const SizedBox(height: 34),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [_dot(false), _dot(true), _dot(false)]),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => _continue(context),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('Next'), SizedBox(width: 8), Icon(Icons.arrow_forward, size: 18)],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mockCard({required double width, required double height, required double opacity}) {
    return Opacity(
      opacity: opacity,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 24, offset: const Offset(0, 12))],
        ),
        child: Center(
          child: CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.lightBlue,
            child: Icon(Icons.work_outline, color: AppColors.primary.withOpacity(0.9)),
          ),
        ),
      ),
    );
  }

  Widget _dot(bool active) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 28 : 8,
      height: 6,
      decoration: BoxDecoration(color: active ? AppColors.primary : AppColors.border, borderRadius: BorderRadius.circular(8)),
    );
  }
}
