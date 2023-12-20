import 'package:flutter/material.dart';

class ItemPlayProperties extends StatelessWidget {
  final int? minAge;
  final int? minPlayers;
  final int? maxPlayers;
  final int? playingTime;
  const ItemPlayProperties({
    super.key,
    this.minAge,
    this.minPlayers,
    this.maxPlayers,
    this.playingTime,
  });

  _isEmpty() {
    return minAge == null &&
        minPlayers == null &&
        maxPlayers == null &&
        playingTime == null;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return _isEmpty()
        ? Container()
        : FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              children: [
                ...(minAge != null
                    ? [
                        const Icon(Icons.child_care),
                        const SizedBox(width: 5),
                        Text(
                          '${minAge.toString()}+',
                          style: textTheme.bodySmall,
                        ),
                      ]
                    : []),
                ...(minPlayers != null && maxPlayers != null
                    ? [
                        const SizedBox(width: 10),
                        const Icon(Icons.people_alt_outlined),
                        const SizedBox(width: 5),
                        Text(
                          '$minPlayers${maxPlayers != minPlayers ? '-$maxPlayers' : ''}',
                          style: textTheme.bodySmall,
                        ),
                      ]
                    : []),
                ...(playingTime != null
                    ? [
                        const SizedBox(width: 10),
                        const Icon(Icons.timer_outlined),
                        const SizedBox(width: 5),
                        Text(
                          '${playingTime.toString()}\'',
                          style: textTheme.bodySmall,
                        ),
                      ]
                    : [])
              ],
            ),
          );
  }
}
