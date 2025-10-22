import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:student/core/utils/colors_utils.dart';
import 'package:student/core/widgets/custom_text.dart';
import 'package:student/core/widgets/custom_container.dart';

class PdfView extends StatelessWidget {
  final String url;
  final String? title;

  const PdfView({super.key, required this.url, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorsUtils.primary,
        title: CustomText(
          title ?? 'PDF Viewer',
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: CustomContainer(
        padding: 0,
        color: Colors.white,
        child: const PDF().cachedFromUrl(
          url,
          placeholder: (progress) => Center(
            child: CustomText(
              '$progress%',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: ColorsUtils.main,
            ),
          ),
          errorWidget: (error) =>
              Center(child: CustomText(error.toString(), color: Colors.red)),
        ),
      ),
    );
  }
}
