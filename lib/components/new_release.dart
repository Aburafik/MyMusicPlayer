import 'package:flutter/material.dart';

class NewReleaseCompnent extends StatelessWidget {
  const NewReleaseCompnent({
    super.key,
    this.title,
    this.subTitle,
    this.imageTitle,
    this.onTap,
  });
  final String? title;
  final String? subTitle;
  final String? imageTitle;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: AssetImage(imageTitle!),
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(
              width: 14,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subTitle!,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.699999988079071),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Text(
                    "....",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
