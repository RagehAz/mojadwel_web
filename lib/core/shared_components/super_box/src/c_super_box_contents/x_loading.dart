part of super_box;

class Loading extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Loading({
    this.loading = true,
    this.size = 50,
    this.color = Colors.black,
    this.backgroundColor = Colors.transparent,
    super.key
  }); 
  /// --------------------------------------------------------------------------
  final double? size;
  final bool loading;
  final Color? color;
  final Color backgroundColor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return loading ? Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12), // optional rounded corners
      ),
      alignment: Alignment.center,
      child: SizedBox(
        width: size == null ? null : size! * 0.4,
        height: size == null ? null : size! * 0.4,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(color ?? Colors.black),
        ),
      ),
    )
        : const SizedBox.shrink();
  }
  /// --------------------------------------------------------------------------
}
