import 'package:flutter/material.dart';

// list tile height
const double tileHeight = 40;

// sides of the list
enum TileSide {
  left,
  right,
}

class TransferList extends StatefulWidget {
  /// `List<dynamic>` left list
  final List<dynamic> leftList;

  /// `List<dynamic>` right list
  final List<dynamic> rightList;

  /// onChange callback, returns the new left and right list.
  final void Function(List, List) onChange;

  /// `double?` height for the transfer list. Defaults to 200
  final double? height;

  /// `double?` width for the transfer list. Defaults to 350
  final double? width;

  /// `Color?` fill color for the checkbox
  final Color? checkboxFillColor;

  /// `Color?` list tile splash color
  final Color? tileSplashColor;

  /// `Color` list container background color. Defaults to grey
  final Color listBackgroundColor;

  /// `TextStyle?` list tile text style
  final TextStyle textStyle;

  /// TransferList constructor
  ///
  /// It tries to expand in both the direction.
  /// Use a strict parent or provide height and width.
  const TransferList({
    super.key,
    required this.leftList,
    required this.rightList,
    required this.onChange,
    this.height,
    this.width,
    this.checkboxFillColor,
    this.tileSplashColor,
    this.textStyle = const TextStyle(color: Colors.white70),
    this.listBackgroundColor = Colors.grey,
  });

  @override
  State<TransferList> createState() => _TransferListState();
}

class _TransferListState extends State<TransferList> {
  late List leftList;
  late List rightList;

  Map<TileSide, List> selected = {
    TileSide.left: [],
    TileSide.right: [],
  };

  ButtonStyle get buttonStyle => TextButton.styleFrom(
        side: const BorderSide(color: Colors.grey),
      );

  bool isSelected(data, TileSide side) {
    return selected[side]!.contains(data);
  }

  void handleOnChange(bool newValue, data, TileSide side) {
    if (newValue) {
      setState(() {
        selected[side]?.add(data);
      });
    } else {
      setState(() {
        selected[side]?.remove(data);
      });
    }
  }

  Widget buildTile(data, TileSide side) {
    return _CustomTile(
      value: isSelected(data, side),
      onChanged: (bool newValue) {
        handleOnChange(newValue, data, side);
      },
      title: '$data',
      textStyle: widget.textStyle,
      checkboxFillColor: widget.checkboxFillColor,
      splashColor: widget.tileSplashColor,
    );
  }

  void transferSelectedToRight() {
    setState(() {
      leftList.removeWhere((element) {
        return selected[TileSide.left]!.contains(element);
      });
      rightList.addAll(selected[TileSide.left]!);
      selected[TileSide.left]?.clear();
    });
  }

  void transferSelectedToLeft() {
    setState(() {
      rightList.removeWhere((element) {
        return selected[TileSide.right]!.contains(element);
      });
      leftList.addAll(selected[TileSide.right]!);
      selected[TileSide.right]?.clear();
    });
  }

  void transferAllToRight() {
    setState(() {
      selected[TileSide.left]?.clear();
      rightList.addAll(leftList);
      leftList = [];
    });

    widget.onChange(leftList, rightList);
  }

  void transferAllToLeft() {
    setState(() {
      selected[TileSide.right]?.clear();
      leftList.addAll(rightList);
      rightList = [];
    });

    widget.onChange(leftList, rightList);
  }

  @override
  void initState() {
    super.initState();
    leftList = [...widget.leftList];
    rightList = [...widget.rightList];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: widget.height ?? 200,
        width: widget.width ?? 350,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              color: widget.listBackgroundColor,
              child: ListView.builder(
                itemCount: leftList.length,
                itemBuilder: (context, index) {
                  return buildTile(leftList[index], TileSide.left);
                },
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: FittedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: leftList.isEmpty ? null : transferAllToRight,
                      style: buttonStyle,
                      child: const Text('>>'),
                    ),
                    const SizedBox(height: 2),
                    TextButton(
                      onPressed: selected[TileSide.left]!.isEmpty
                          ? null
                          : transferSelectedToRight,
                      style: buttonStyle,
                      child: const Text('>'),
                    ),
                    const SizedBox(height: 2),
                    TextButton(
                      onPressed: selected[TileSide.right]!.isEmpty
                          ? null
                          : transferSelectedToLeft,
                      style: buttonStyle,
                      child: const Text('<'),
                    ),
                    const SizedBox(height: 2),
                    TextButton(
                      onPressed: rightList.isEmpty ? null : transferAllToLeft,
                      style: buttonStyle,
                      child: const Text('<<'),
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              color: widget.listBackgroundColor,
              child: ListView.builder(
                itemCount: rightList.length,
                itemBuilder: (context, index) {
                  return buildTile(rightList[index], TileSide.right);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomTile extends StatelessWidget {
  const _CustomTile({
    required this.title,
    required this.value,
    required this.onChanged,
    required this.textStyle,
    this.checkboxFillColor,
    this.splashColor,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  final Color? checkboxFillColor;
  final Color? splashColor;
  final TextStyle textStyle;

  void handleOnChange() {
    if (value) {
      onChanged(false);
    } else {
      onChanged(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        splashColor: splashColor,
        onTap: handleOnChange,
        child: SizedBox(
          height: tileHeight,
          child: Row(
            children: [
              const SizedBox(width: 2),
              Checkbox(
                visualDensity: VisualDensity.compact,
                fillColor: MaterialStateProperty.resolveWith<Color>((_) {
                  return checkboxFillColor ?? themeData.primaryColor;
                }),
                value: value,
                onChanged: null,
              ),
              const SizedBox(width: 2),
              Expanded(
                child: Text(
                  title,
                  style: textStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
