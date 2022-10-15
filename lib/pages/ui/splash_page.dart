import 'package:bloc_weather_api/utils/app_router.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 280,
                    width: 280,
                    child: Center(
                      child: Image.asset('assets/images/login.png'),
                      heightFactor: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      padding: const EdgeInsets.all(18.0),
                      height: 300,
                      width: 400,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.2),
                              spreadRadius: 4,
                              blurRadius: 10,
                              offset: Offset(0, 7),
                            )
                          ]),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Center(
                            child: Text(
                              "Khám phá dự báo thời tiết trên khắp thế giới!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 23),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Bạn đang lên kế hoạch cho một chuyến đi, hoặc muốn biết dự báo thời tiết ở một số quốc gia, ứng dụng này hoàn toàn phù hợp với bạn!",
                            maxLines: 3,
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 50,
                            width: 200,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.deepPurple),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(AppRouter.AUTH_OR_HOME);
                              },
                              child: const Text("bắt đầu ngay bây giờ!",
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Chưa có tài khoản ?",
                                style: TextStyle(),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(AppRouter.AUTH_OR_HOME);
                                },
                                child: const Text(
                                  "Đăng ký ngay!",
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ]),
          ),
        ));
  }
}
