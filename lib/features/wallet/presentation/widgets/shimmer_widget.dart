import 'package:flutter/material.dart';

class ShimmerWidget extends StatefulWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;
  final Color? baseColor;
  final Color? highlightColor;

  const ShimmerWidget.rectangular({
    Key? key,
    this.width = double.infinity,
    required this.height,
    this.baseColor,
    this.highlightColor,
  })  : shapeBorder = const RoundedRectangleBorder(),
        super(key: key);

  const ShimmerWidget.circular({
    Key? key,
    required this.width,
    required this.height,
    this.baseColor,
    this.highlightColor,
  })  : shapeBorder = const CircleBorder(),
        super(key: key);

  ShimmerWidget.rounded({
    Key? key,
    this.width = double.infinity,
    required this.height,
    required double borderRadius,
    this.baseColor,
    this.highlightColor,
  })  : shapeBorder = RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        super(key: key);

  @override
  State<ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<ShimmerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _shimmerAnimation = Tween<double>(
      begin: -2,
      end: 2,
    ).animate(
      CurvedAnimation(
        parent: _shimmerController,
        curve: Curves.easeInOutSine,
      ),
    );
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final baseColor = widget.baseColor ??
        (isDarkMode ? Colors.grey[700]! : Colors.grey[300]!);
    final highlightColor = widget.highlightColor ??
        (isDarkMode ? Colors.grey[600]! : Colors.grey[100]!);

    return AnimatedBuilder(
      animation: _shimmerAnimation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: ShapeDecoration(
            color: baseColor,
            shape: widget.shapeBorder,
          ),
          child: ClipRRect(
            borderRadius: widget.shapeBorder is RoundedRectangleBorder
                ? (widget.shapeBorder as RoundedRectangleBorder)
                    .borderRadius
                    .resolve(Directionality.of(context))
                : BorderRadius.zero,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          baseColor,
                          highlightColor,
                          baseColor,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                        transform:
                            GradientRotation(_shimmerAnimation.value),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Shimmer loading widget for transaction cards
class ShimmerTransactionCard extends StatelessWidget {
  const ShimmerTransactionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          const ShimmerWidget.circular(
            width: 48,
            height: 48,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerWidget.rounded(
                  height: 16,
                  width: 120,
                  borderRadius: 4,
                ),
                const SizedBox(height: 6),
                ShimmerWidget.rounded(
                  height: 12,
                  width: 80,
                  borderRadius: 4,
                ),
              ],
            ),
          ),
          ShimmerWidget.rounded(
            height: 20,
            width: 60,
            borderRadius: 4,
          ),
        ],
      ),
    );
  }
}

// Shimmer loading widget for balance card
class ShimmerBalanceCard extends StatelessWidget {
  const ShimmerBalanceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(28),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerWidget.rounded(
                  height: 20,
                  width: 120,
                  borderRadius: 4,
                ),
                const ShimmerWidget.circular(
                  width: 36,
                  height: 36,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerWidget.rounded(
                  height: 40,
                  width: 200,
                  borderRadius: 8,
                ),
                const SizedBox(height: 16),
                ShimmerWidget.rounded(
                  height: 32,
                  width: 100,
                  borderRadius: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Shimmer loading widget for transaction list item
class ShimmerTransactionItem extends StatelessWidget {
  const ShimmerTransactionItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          const ShimmerWidget.circular(
            width: 48,
            height: 48,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerWidget.rounded(
                  height: 16,
                  width: 100,
                  borderRadius: 4,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    ShimmerWidget.rounded(
                      height: 12,
                      width: 12,
                      borderRadius: 2,
                    ),
                    const SizedBox(width: 4),
                    ShimmerWidget.rounded(
                      height: 12,
                      width: 60,
                      borderRadius: 4,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ShimmerWidget.rounded(
                height: 18,
                width: 70,
                borderRadius: 4,
              ),
            ],
          ),
        ],
      ),
    );
  }
} 