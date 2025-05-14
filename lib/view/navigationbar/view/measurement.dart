import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/colors.dart';
import '../../../widgets/reusetext.dart';
import '../../../widgets/roundedButton.dart';

class Measurement extends StatefulWidget {
  const Measurement({Key? key}) : super(key: key);

  @override
  State<Measurement> createState() => _MeasurementState();
}

class _MeasurementState extends State<Measurement> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool isCameraInitialized = false;
  int currentSegment = 0;
  final int totalSegments = 20;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front);
    _controller = CameraController(front, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
    await _initializeControllerFuture;
    if (mounted) {
      setState(() {
        isCameraInitialized = true;
      });
      startSegmentedProgress();
    }
  }

  void startSegmentedProgress() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (currentSegment >= totalSegments) {
        timer.cancel();
        return;
      }
      setState(() {
        currentSegment++;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildSegmentBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSegments, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          width: 12.w,
          height: 8.h,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.orange),
            color: index < currentSegment ? AppColors.orange : Colors.orange[200],
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }

  Widget buildCameraFrame() {
    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: 3 / 4,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.redAccent.withOpacity(0.3), width: 2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: isCameraInitialized
                  ? CameraPreview(_controller)
                  : Container(color: Colors.black),
            ),
          ),
        ),
        // Optional scanner corners (top-left and top-right)
        Positioned(
          top: 0,
          left: 0,
          child: SizedBox(
            width: 30.w,
            height: 30.h,
            child: CustomPaint(painter: CornerPainter()),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: SizedBox(
            width: 30.w,
            height: 30.h,
            child: CustomPaint(painter: CornerPainter(isLeft: false)),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 32.h,
                      width: 32.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.nbgcolr,
                      ),
                      child: Icon(Icons.arrow_back, size: 18, color: AppColors.txtcolr),
                    ),
                  ),
                  ReuseText(
                    data: "Measurement",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.txtcolr,
                  ),
                  const SizedBox(width: 32),
                ],
              ),

              SizedBox(height: 20.h),

              Center(
                child: ReuseText(
                  richTextSpan: TextSpan(
                    children: [
                      TextSpan(
                        text: "SCANNING ",
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.orange,
                        ),
                      ),
                      TextSpan(
                        text: "YOUR FACE",
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.txtcolr,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 8.h),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ReuseText(
                    data: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.txtgrey,
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              Center(child: buildCameraFrame()),

              SizedBox(height: 20.h),

              buildSegmentBar(),

              const Spacer(),

              RoundedButton(text: "Ok, Let's Start", onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class CornerPainter extends CustomPainter {
  final bool isLeft;
  CornerPainter({this.isLeft = true});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.redAccent
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();
    if (isLeft) {
      path.moveTo(0, size.height);
      path.lineTo(0, 0);
      path.lineTo(size.width, 0);
    } else {
      path.moveTo(size.width, size.height);
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
