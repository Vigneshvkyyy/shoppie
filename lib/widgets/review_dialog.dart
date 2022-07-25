import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shoppie_app/model/review_model.dart';
import 'package:shoppie_app/provider/user_detail_provider.dart';
import 'package:shoppie_app/resources/cloud_firestore_methods.dart';
import 'package:provider/provider.dart';

class ReviewDialog extends StatelessWidget {
  final String productUid;
  const ReviewDialog({
    Key? key,
    required this.productUid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      starSize: 35,
      starColor: Colors.green,
      title: Text(
        'Type a review for this product!',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      submitButtonText: 'Send',
      commentHint: 'Type here',
      onSubmitted: (RatingDialogResponse res) {
        CloudFirestoreClass().uploadReviewToDatabase(
            productUid: productUid,
            model: ReviewModel(
                senderName:
                    Provider.of<UserDetailsProvider>(context, listen: false)
                        .userDetails
                        .name,
                description: res.comment,
                rating: res.rating.toInt()));
      },
    );
  }
}
