import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/page_controller.dart';

class VerticalMenuItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final bool isCurrent;
  final int buttonIndex;

  const VerticalMenuItem({
    required this.icon,
    required this.title,
    this.isCurrent = false,
    Key? key,
    required this.buttonIndex,
  }) : super(key: key);

  @override
  _VerticalMenuItemState createState() => _VerticalMenuItemState();
}

class _VerticalMenuItemState extends State<VerticalMenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final pageController = Provider.of<AdminPageController>(context);
    final isActive = widget.isCurrent || _isHovered;

    return AspectRatio(
      aspectRatio: 1.0,
      child: GestureDetector(
        onTap: () => pageController.index = widget.buttonIndex,
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 3,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: isActive
                    ? Colors.grey.withOpacity(0.25)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  if (isActive)
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 3,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.icon,
                      size: 40,
                      color: isActive ? Colors.white : Colors.grey,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
