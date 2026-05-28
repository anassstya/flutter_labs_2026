import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Arial',
      ),
      home: const WishlistPage(),
    );
  }
}

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 8,
            bottom: 140,
          ),
          child: Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _topButton(Icons.share_outlined),
                  _topButton(Icons.menu),
                ],
              ),

              const SizedBox(height: 12),

              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  shape: BoxShape.circle,
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                'ФИО',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xff1B1B1D),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.cake_outlined,
                      size: 16,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Укажите день рождения',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _categoryCard(
                    title: 'Мои\nжелания',
                    count: '7',
                    selected: true,
                    width: 108,
                  ),

                  const SizedBox(width: 10),

                  Container(
                    width: 58,
                    height: 140,
                    decoration: BoxDecoration(
                      color: const Color(0xff1B1B1D),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _categoryCard(
                      title: 'Вещи',
                      count: '2',
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _categoryCard(
                      title: '–',
                      count: '5',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Expanded(
                    child: Column(
                      children: const [

                        WishCard(
                          image: 'assets/images/bag.jpg',
                          title: 'Сумка miu miu',
                          price: '500 000 ₽',
                          imageHeight: 250,
                        ),

                        SizedBox(height: 16),

                        WishCard(
                          image: 'assets/images/sea.jpg',
                          title: 'Путешествие',
                          imageHeight: 320,
                        ),

                        SizedBox(height: 16),

                        WishCard(
                          image: 'assets/images/porshe.jpg',
                          title: 'Porshe 911',
                          imageHeight: 320,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      children: const [

                        WishCard(
                          image: 'assets/images/jump.jpg',
                          title: 'Прыжок',
                          price: '18 000 ₽',
                          imageHeight: 250,
                        ),

                        SizedBox(height: 16),

                        WishCard(
                          image: 'assets/images/dog.jpg',
                          title: 'Собака',
                          imageHeight: 220,
                        ),

                        SizedBox(height: 16),

                        WishCard(
                          image: 'assets/images/yacht.jpg',
                          title: 'Яхта',
                          imageHeight: 180,
                        ),

                        SizedBox(height: 16),

                        WishCard(
                          image: 'assets/images/airplane.jpg',
                          title: 'Самолет',
                          price: '200 000 000 ₽',
                          imageHeight: 220,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

     bottomNavigationBar: SafeArea(
       child: Padding(
         padding: const EdgeInsets.only(
           left: 18,
           right: 18,
           bottom: 2,
         ),
         child: SizedBox(
           height: 70,
           child: Stack(
             clipBehavior: Clip.none,
             alignment: Alignment.bottomCenter,
             children: [

               Positioned(
                 bottom: 0,
                 left: 0,
                 right: 0,
                 child: Container(
                   height: 60,
                   decoration: BoxDecoration(
                     color: const Color(0xff1B1B1D),
                     borderRadius: BorderRadius.circular(40),
                   ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: const [

                       Icon(
                         Icons.local_fire_department_outlined,
                         color: Colors.white70,
                       ),


                       Icon(
                         Icons.favorite_border,
                         color: Colors.white70,
                       ),

                       Icon(
                         Icons.people_outline,
                         color: Colors.white70,
                       ),

                       Icon(
                         Icons.person_outline,
                         color: Colors.white70,
                       ),
                     ],
                   ),
                 ),
               ),

               Positioned(
                 top: -80,
                 child: Container(
                   width: 130,
                   height: 60,
                   decoration: BoxDecoration(
                     color: const Color(0xff2150FF),
                     borderRadius: BorderRadius.circular(30),
                     boxShadow: [
                       BoxShadow(
                         color: Colors.black.withOpacity(0.35),
                         blurRadius: 20,
                         offset: const Offset(0, 8),
                       ),
                     ],
                   ),
                   child: const Icon(
                     Icons.add,
                     color: Colors.white,
                     size: 38,
                   ),
                 ),
               ),
             ],
           ),
         ),
       ),
     ),
    );
  }

  Widget _topButton(IconData icon) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: const Color(0xff1B1B1D),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }

  Widget _categoryCard({
    required String title,
    required String count,
    bool selected = false,
    double? width,
  }) {
    return Container(
      width: width,
      height: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: selected ? Colors.white : const Color(0xff1B1B1D),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            title,
            style: TextStyle(
              color: selected ? Colors.black : Colors.white,
              fontSize: 16,
              height: 1.1,
            ),
          ),

          const Spacer(),

          Text(
            count,
            style: TextStyle(
              color: selected ? Colors.black : Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class WishCard extends StatelessWidget {
  final String image;
  final String title;
  final String? price;
  final double imageHeight;

  const WishCard({
    super.key,
    required this.image,
    required this.title,
    this.price,
    required this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
          height: imageHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: Colors.grey.shade900,
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [

              Positioned.fill(
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),

              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.45),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),

        if (price != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              price!,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
      ],
    );
  }
}