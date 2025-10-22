import 'package:flutter/material.dart';
import 'package:student/core/network/api_service.dart';
import 'package:student/core/utils/colors_utils.dart';
import 'package:student/core/widgets/custom_container.dart';
import 'package:student/core/widgets/custom_text.dart';
import 'package:student/features/course/presentation/view/pdf_view.dart';
import 'package:student/features/home/model/home_model.dart';
import 'package:zapx/zapx.dart';

class DocumentsTabSection extends StatelessWidget {
  const DocumentsTabSection(
     this.documents,
    {
    super.key,
  });

  final List<ModuleDocument> documents;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: documents.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final doc = documents[index];
           final documentUrl = doc.documentUrl.startsWith('http')
              ? doc.documentUrl
              :'${ApiService.baseUrl.replaceAll('/api', '')}${doc.documentUrl}';

        return InkWell(
          onTap: ()=>Zap.to(PdfView(url: documentUrl,title: doc.title,)),
          child: _buildDocumentItem(
            title: doc.title ,
          ),
        );
      },
    );
  }

  Widget _buildDocumentItem({
    required String title,
  }) {
    return CustomContainer(
      color: Colors.white,
      padding: 16,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
      child: Row(
        children: [
          CustomContainer(
            color: ColorsUtils.main.withValues(alpha: 0.1),
            padding: 12,
            borderRadius: 12,
            child: const Icon(
              Icons.picture_as_pdf,
              color: ColorsUtils.main,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: ColorsUtils.primary,
                ),
                
              ],
            ),
          ),
          // const Icon(
          //   Icons.file_download_outlined,
          //   color: ColorsUtils.grey,
          //   size: 24,
          // ),
        ],
      ),
    );
  }
}

