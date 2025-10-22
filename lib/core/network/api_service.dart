import 'package:dio/dio.dart';
import 'package:student/core/app/routes.dart';
import 'package:student/core/services/storage_service.dart';
import 'package:student/main.dart';
import 'package:zapx/zapx.dart';

class ApiService {
  // Singleton instance
  static final ApiService instance = ApiService._internal();

  // Factory constructor returns the same instance
  factory ApiService() {
    return instance;
  }

  // Private constructor
  ApiService._internal() {
    _initializeDio();
  }

  // Dio instance
  late final Dio _dio;

  // Getter for Dio instance
  Dio get dio => _dio;

  // Base URL - You can change this to your API base URL
  static const String baseUrl = 'https://alphalearnzag.com/api';

  void _initializeDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    _dio.interceptors.add(_loggingInterceptor());
    _dio.interceptors.add(_authInterceptor());
    _dio.interceptors.add(_errorInterceptor());
  }

  // Logging Interceptor
  Interceptor _loggingInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        logger.d('📤 REQUEST[${options.method}] => PATH: ${options.path}');
        logger.d('Headers: ${options.headers}');
        logger.d('Data: ${options.data}');
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        logger.d(
          '📥 RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
        );
        logger.d('Data: ${response.data}');
        if (response.statusCode == 401) {
          await StorageService.instance.clearAll();
          Zap.toNamed(Routes.login);
          return;
        }
        return handler.next(response);
      },
      onError: (error, handler) {
        logger.d(
          '❌ ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}',
        );
        logger.d('Message: ${error.message}');
        return handler.next(error);
      },
    );
  }

  // Auth Interceptor - Add token to requests
  Interceptor _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await storageService.getToken();
        logger.d('token is :$token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    );
  }

  // Error Interceptor - Handle errors globally
  Interceptor _errorInterceptor() {
    return InterceptorsWrapper(
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          // Handle unauthorized error (e.g., refresh token, logout)
          print('🔐 Unauthorized - Please login again');
        } else if (error.response?.statusCode == 500) {
          // Handle server error
          print('🔥 Server Error');
        }
        return handler.next(error);
      },
    );
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );

      if (response.statusCode != null && response.statusCode! >= 400) {
        final responseData = response.data;
        if (responseData is Map<String, dynamic>) {
          final message = responseData['message'] ?? 'An error occurred';
          throw Exception(message);
        }
        throw Exception('An error occurred');
      }

      return response;
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        final responseData = e.response!.data;
        if (responseData is Map<String, dynamic>) {
          final message = responseData['message'] ?? 'An error occurred';
          throw Exception(message);
        }
      }
      throw Exception(e.message ?? 'Network error occurred');
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      if (response.statusCode != null && response.statusCode! >= 400) {
        final responseData = response.data;
        if (responseData is Map<String, dynamic>) {
          final message = responseData['message'] ?? 'An error occurred';
          throw Exception(message);
        }
        throw Exception('An error occurred');
      }

      return response;
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        final responseData = e.response!.data;
        if (responseData is Map<String, dynamic>) {
          final message = responseData['message'] ?? 'An error occurred';
          throw Exception(message);
        }
      }
      throw Exception(e.message ?? 'Network error occurred');
    }
  }

  // PUT request
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  // DELETE request
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  // PATCH request
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}
