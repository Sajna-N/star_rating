import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_ratings/bloc/star_handling_bloc.dart';
import 'package:star_ratings/bloc/star_handling_event.dart';
import 'package:star_ratings/bloc/star_handling_state.dart';
import 'package:star_ratings/widget/rating_star.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({Key? key}) : super(key: key);

  @override
  RatingPageState createState() => RatingPageState();
}

class RatingPageState extends State<RatingPage> {
  final TextEditingController _ratingController = TextEditingController();

  @override
  void dispose() {
    _ratingController.dispose();
    super.dispose();
  }

  void _onSubmitPressed() {
    final inputRating = double.tryParse(_ratingController.text) ?? 0.0;
    BlocProvider.of<StarHandlingBloc>(context).add(SubmitRating(inputRating));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rating Stars'),
      ),
      body: BlocBuilder<StarHandlingBloc, RatingState>(
        builder: (context, state) {
          double rating = 0.0;
          if (state is RatingSubmitted) {
            rating = state.rating;
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _ratingController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^([1-5]?(\.\d{0,1})?)$')),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Enter number from 1-5',
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _onSubmitPressed,
                  child: const Text('Click here'),
                ),
                if (rating > 0) const SizedBox(height: 16.0),
                RatingBar(rating: rating, size: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}

// class RatingBar extends StatelessWidget {
//   final double rating;
//   final double size;
//   const RatingBar({Key? key, required this.rating, this.size = 40.0})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> starList = [];

//     int realNumber = rating.floor();
//     int partNumber = ((rating - realNumber) * 10).ceil();

//     for (int i = 0; i < 5; i++) {
//       if (i < realNumber) {
//         starList.add(
//           Icon(Icons.star, color: Theme.of(context).primaryColor, size: size),
//         );
//       } else if (i == realNumber) {
//         starList.add(
//           SizedBox(
//             height: size,
//             width: size,
//             child: Stack(
//               fit: StackFit.expand,
//               children: [
//                 Icon(Icons.star,
//                     color: Theme.of(context).primaryColor, size: size),
//                 ClipRect(
//                   clipper: _Clipper(part: partNumber),
//                   child: Icon(Icons.star, color: Colors.grey, size: size),
//                 ),
//               ],
//             ),
//           ),
//         );
//       } else {
//         starList.add(Icon(Icons.star, color: Colors.grey, size: size));
//       }
//     }

//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: starList,
//     );
//   }
// }

// class _Clipper extends CustomClipper<Rect> {
//   final int part;

//   _Clipper({required this.part});

//   @override
//   Rect getClip(Size size) {
//     return Rect.fromLTRB(
//       (size.width / 10) * part,
//       0.0,
//       size.width,
//       size.height,
//     );
//   }

//   @override
//   bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
// }
