import 'package:flutter/material.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:tuple/tuple.dart';

class DropDownCustom<T> extends StatelessWidget {
 const  DropDownCustom({Key? key, required this.listItem, this.onChange,required this.value})
      : super(key: key);
  final List<Tuple2<String?, T>> listItem;
  final Function? onChange;
  final T value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: borderTextFieldColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          icon: const Icon(
            Icons.keyboard_arrow_down_sharp,
            color: Colors.grey,
          ),
          isExpanded: true,
          value:  value,
          onChanged: (value) {
            onChange!(value);
          },
          items: [
            ...listItem
                .map(
                  (e) => DropdownMenuItem<T>(
                    value: e.item2,
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text(
                        e.item1 ?? "",
                        style: Theme.of(context).textTheme.button!.copyWith(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                )
                .toList()
          ],
        ),
      ),
    );
  }
}


class DropDownCustomRounded<T> extends StatelessWidget {
 const  DropDownCustomRounded({Key? key, required this.listItem, this.onChange,required this.value})
      : super(key: key);
  final List<Tuple2<String?, T>> listItem;
  final Function? onChange;
  final T value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.grey[100]
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          icon: const Icon(
            Icons.keyboard_arrow_down_sharp,
            color: Colors.grey,
          ),
          isExpanded: false,
          value:  value,
          onChanged: (value) {
            onChange!(value);
          },
          items: [
            ...listItem
                .map(
                  (e) => DropdownMenuItem<T>(
                value: e.item2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    e.item1 ?? "",
                    style: Theme.of(context).textTheme.button!.copyWith(
                        fontSize: 14,
                        color: Colors.grey,
                       ),
                  ),
                ),
              ),
            )
                .toList()
          ],
        ),
      ),
    );
  }
}
