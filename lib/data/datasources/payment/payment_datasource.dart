// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/utils/utility.dart';
import '../../../domain/entities/payment/payment_entity.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/errors/failures.dart';
import '../../../core/utils/constants.dart';
import '../../../presentation/widgets/global/imagePicker_widget.dart';
import '../../models/payment/payment_model.dart';

abstract class PaymentDatasource {
  Future<void> payment(PaymentEntity request, String name);
  Future<List<PaymentEntity>> getAllPayment({int? userId, String? select});
  Future<PaymentEntity> getSinglePayment(int paymentId, {String? select});
  Future<List<PaymentEntity>> getPaymentToday({String? select});
  Future<void> deletePayment(int paymentId, String imageName);
}

class PaymentDatasourceImpl extends PaymentDatasource {
  final FirebaseStorage storage;
  final SupabaseClient supabase;

  PaymentDatasourceImpl({
    required this.storage,
    required this.supabase,
  });

  @override
  Future<void> payment(PaymentEntity request, String name) async {
    try {
      File? uploadFile = File(selectedImage!.path);
      final date = Utility.formatDatePostApi(DateTime.now());

      final uploadTask = await storage
          .ref('payments')
          .child('${name}_$date.jpg')
          .putFile(uploadFile);

      final imageUrl = await uploadTask.ref.getDownloadURL();
      final imageName = uploadTask.ref.fullPath.split('/')[1];

      await supabase.from('payments').insert(
            PaymentEntity(
              userId: request.userId,
              imageUrl: imageUrl,
              imageName: imageName,
              imageSize: imageSize,
              paymentDate: request.paymentDate,
              createdAt: request.createdAt,
              updatedAt: request.updatedAt,
            ),
          );
    } catch (e) {
      return _handleException(e);
    } finally {
      selectedImage = null;
      imageSize = 0;
    }
  }

  @override
  Future<List<PaymentEntity>> getAllPayment({
    int? userId,
    String? select,
  }) async {
    try {
      if (userId == null) {
        final res = await supabase
            .from('payments')
            .select(select ?? '*')
            .order('created_at');

        return res.map((e) => PaymentModel.fromJson(e)).toList();
      }
      final res = await supabase
          .from('payments')
          .select(select ?? '*')
          .eq('user_id', userId)
          .order('created_at');

      return res.map((e) => PaymentModel.fromJson(e)).toList();
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<PaymentEntity> getSinglePayment(int paymentId,
      {String? select}) async {
    try {
      final res = await supabase
          .from('payments')
          .select(select ?? '*')
          .eq('id', paymentId)
          .single();

      return PaymentModel.fromJson(res);
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<List<PaymentEntity>> getPaymentToday({String? select}) async {
    try {
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      final endOfDay = startOfDay
          .add(const Duration(days: 1))
          .subtract(const Duration(milliseconds: 1))
          .toIso8601String();

      final res = await supabase
          .from('payments')
          .select(select ?? '*')
          .gte('created_at', startOfDay.toIso8601String())
          .lt('created_at', endOfDay);

      return res.map((e) => PaymentModel.fromJson(e)).toList();
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<void> deletePayment(int paymentId, String imageName) async {
    try {
      await supabase.from('payments').delete().eq('id', paymentId);

      // Delete the image from Firebase Storage
      await storage.ref('payments').child(imageName).delete();
    } catch (e) {
      return _handleException(e);
    }
  }

  _handleException(Object e) {
    if (e is ServerException) {
      throw ServerFailure(message: e.message);
    } else if (e is FirebaseException) {
      throw ServerFailure(message: e.message);
    } else {
      throw const UnknownFailure(message: FAILURE_UNKNOWN);
    }
  }
}
