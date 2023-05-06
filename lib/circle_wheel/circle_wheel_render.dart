// // ignore_for_file: unnecessary_null_comparison

// import 'dart:math' as math;
// import 'dart:ui' show lerpDouble;
// import 'package:flutter/widgets.dart';
// import 'package:flutter/rendering.dart';
// import 'package:vector_math/vector_math_64.dart' show Matrix4;

// typedef _ChildSizingFunction = double Function(RenderBox child);

// abstract class CircleListChildManager {
//   int get childCount;

//   bool childExistsAt(int index);

//   void createChild(int index, {required RenderBox after});

//   void removeChild(RenderBox child);
// }

// class CircleListParentData extends ContainerBoxParentData<RenderBox> {
//   /// Index of this child in its parent's child list.
//   late int index;

//   // CircleListParentData(this.index);
// }

// class RenderCircleListViewport extends RenderBox
//     with ContainerRenderObjectMixin<RenderBox, CircleListParentData>
//     implements RenderAbstractViewport {
//   RenderCircleListViewport({
//     required this.childManager,
//     required ViewportOffset offset,
//     required double itemExtent,
//     required Axis axis,
//     double radius = 100,
//     bool clipToSize = true,
//     bool renderChildrenOutsideViewport = false,
//     List<RenderBox>? children,
//   })  : assert(itemExtent > 0),
//         assert(
//           !renderChildrenOutsideViewport || !clipToSize,
//           clipToSizeAndRenderChildrenOutsideViewportConflict,
//         ),
//         _axis = axis,
//         _radius = radius,
//         _offset = offset,
//         _itemExtent = itemExtent,
//         _clipToSize = clipToSize,
//         _renderChildrenOutsideViewport = renderChildrenOutsideViewport {
//     addAll(children);
//   }

//   static const String clipToSizeAndRenderChildrenOutsideViewportConflict =
//       'Cannot renderChildrenOutsideViewport and clipToSize since children '
//       'rendered outside will be clipped anyway.';

//   final CircleListChildManager childManager;

//   ViewportOffset get offset => _offset;
//   ViewportOffset _offset;
//   set offset(ViewportOffset value) {
//     if (value == _offset) return;
//     if (attached) _offset.removeListener(_hasScrolled);
//     _offset = value;
//     if (attached) _offset.addListener(_hasScrolled);
//     markNeedsLayout();
//   }

//   double get itemExtent => _itemExtent;
//   double _itemExtent;
//   set itemExtent(double value) {
//     assert(value > 0);
//     if (value == _itemExtent) return;
//     _itemExtent = value;
//     markNeedsLayout();
//   }

//   bool get clipToSize => _clipToSize;
//   bool _clipToSize;
//   set clipToSize(bool value) {
//     assert(
//       !renderChildrenOutsideViewport || !clipToSize,
//       clipToSizeAndRenderChildrenOutsideViewportConflict,
//     );
//     if (value == _clipToSize) return;
//     _clipToSize = value;
//     markNeedsPaint();
//     markNeedsSemanticsUpdate();
//   }

//   bool get renderChildrenOutsideViewport => _renderChildrenOutsideViewport;
//   bool _renderChildrenOutsideViewport;
//   set renderChildrenOutsideViewport(bool value) {
//     assert(
//       !renderChildrenOutsideViewport || !clipToSize,
//       clipToSizeAndRenderChildrenOutsideViewportConflict,
//     );
//     if (value == _renderChildrenOutsideViewport) return;
//     _renderChildrenOutsideViewport = value;
//     markNeedsLayout();
//     markNeedsSemanticsUpdate();
//   }

//   Axis get axis => _axis;
//   Axis _axis;
//   set axis(Axis value) {
//     if (value == _axis) return;
//     _axis = value;
//     markNeedsLayout();
//     markNeedsSemanticsUpdate();
//   }

//   double get radius => _radius;
//   double _radius;
//   set radius(double value) {
//     assert(value > 0);
//     if (value == _radius) return;
//     _radius = value;
//     markNeedsLayout();
//     markNeedsSemanticsUpdate();
//   }

//   void _hasScrolled() {
//     markNeedsLayout();
//     markNeedsSemanticsUpdate();
//   }

//   @override
//   void setupParentData(RenderObject child) {
//     if (child.parentData is! CircleListParentData) {
//       child.parentData = CircleListParentData();
//     }
//   }

//   @override
//   void attach(PipelineOwner owner) {
//     super.attach(owner);
//     _offset.addListener(_hasScrolled);
//   }

//   @override
//   void detach() {
//     _offset.removeListener(_hasScrolled);
//     super.detach();
//   }

//   @override
//   bool get isRepaintBoundary => true;

//   double get _viewportExtent {
//     assert(hasSize);
//     return axis == Axis.horizontal ? size.width : size.height;
//   }

//   double get _mainAxisSize {
//     return _viewportExtent;
//   }

//   double get _minEstimatedScrollExtent {
//     assert(hasSize);
//     if (childManager.childCount == null) return double.negativeInfinity;
//     return 0.0;
//   }

//   double get _maxEstimatedScrollExtent {
//     assert(hasSize);
//     if (childManager.childCount == null) return double.infinity;

//     return math.max(0.0, (childManager.childCount - 1) * _itemExtent);
//   }

//   double get _scrollMarginExtent {
//     assert(hasSize);
//     return -_mainAxisSize / 2.0 + _itemExtent / 2.0;
//   }

//   double _getUntransformedPaintingCoordinate(double layoutCoordinate) {
//     return layoutCoordinate - _scrollMarginExtent - offset.pixels;
//   }

//   double _getIntrinsicCrossAxis(_ChildSizingFunction childSize) {
//     double extent = 0.0;
//     RenderBox child = firstChild!;
//     while (child != null) {
//       extent = math.max(extent, childSize(child));
//       child = childAfter(child)!;
//     }
//     return extent;
//   }

//   @override
//   double computeMinIntrinsicWidth(double height) {
//     if (axis == Axis.horizontal) {
//       if (childManager.childCount == null) {
//         return 0.0;
//       }
//       return childManager.childCount * _itemExtent;
//     }

//     return _getIntrinsicCrossAxis(
//         (RenderBox child) => child.getMinIntrinsicWidth(height));
//   }

//   @override
//   double computeMaxIntrinsicWidth(double height) {
//     if (axis == Axis.horizontal) {
//       if (childManager.childCount == null) {
//         return 0.0;
//       }
//       return childManager.childCount * _itemExtent;
//     }

//     return _getIntrinsicCrossAxis(
//         (RenderBox child) => child.getMaxIntrinsicWidth(height));
//   }

//   @override
//   double computeMinIntrinsicHeight(double width) {
//     if (axis == Axis.vertical) {
//       if (childManager.childCount == null) {
//         return 0.0;
//       }
//       return childManager.childCount * _itemExtent;
//     }

//     return _getIntrinsicCrossAxis(
//         (RenderBox child) => child.getMinIntrinsicHeight(width));
//   }

//   @override
//   double computeMaxIntrinsicHeight(double width) {
//     if (axis == Axis.vertical) {
//       if (childManager.childCount == null) {
//         return 0.0;
//       }
//       return childManager.childCount * _itemExtent;
//     }

//     return _getIntrinsicCrossAxis(
//         (RenderBox child) => child.getMaxIntrinsicHeight(width));
//   }

//   @override
//   bool get sizedByParent => true;

//   @override
//   void performResize() {
//     size = constraints.biggest;
//   }

//   /// Gets the index of a child by looking at its parentData.
//   int indexOf(RenderBox child) {
//     final CircleListParentData childParentData = child.parentData;
//     return childParentData.index;
//   }

//   /// Returns the index of the child at the given offset.
//   int scrollOffsetToIndex(double scrollOffset) =>
//       (scrollOffset / itemExtent).floor();

//   /// Returns the scroll offset of the child with the given index.
//   double indexToScrollOffset(int index) => index * itemExtent;

//   void _createChild(int index, {RenderBox? after}) {
//     invokeLayoutCallback<BoxConstraints>((BoxConstraints constraints) {
//       assert(constraints == this.constraints);
//       childManager.createChild(index, after: after!);
//     });
//   }

//   void _destroyChild(RenderBox child) {
//     invokeLayoutCallback<BoxConstraints>((BoxConstraints constraints) {
//       assert(constraints == this.constraints);
//       childManager.removeChild(child);
//     });
//   }

//   void _layoutChild(RenderBox child, BoxConstraints constraints, int index) {
//     child.layout(constraints, parentUsesSize: true);
//     final CircleListParentData childParentData = child.parentData;
//     // Centers the child horizontally.

//     if (axis == Axis.horizontal) {
//       final double crossPosition = size.height / 2.0 - child.size.height / 2.0;
//       childParentData.offset =
//           Offset(indexToScrollOffset(index), crossPosition);
//     } else {
//       final double crossPosition = size.width / 2.0 - child.size.width / 2.0;
//       childParentData.offset =
//           Offset(crossPosition, indexToScrollOffset(index));
//     }
//   }

//   @override
//   void performLayout() {
//     final BoxConstraints childConstraints = constraints.copyWith(
//       minHeight: _itemExtent,
//       maxHeight: _itemExtent,
//       minWidth: 0.0,
//     );

//     double visibleSize = _mainAxisSize;

//     if (renderChildrenOutsideViewport) visibleSize *= 2;

//     final double firstVisibleOffset =
//         offset.pixels + _itemExtent / 2 - visibleSize / 2;
//     final double lastVisibleOffset = firstVisibleOffset + visibleSize;

//     int targetFirstIndex = scrollOffsetToIndex(firstVisibleOffset);
//     int targetLastIndex = scrollOffsetToIndex(lastVisibleOffset);
//     // Because we exclude lastVisibleOffset, if there's a new child starting at
//     // that offset, it is removed.
//     if (targetLastIndex * _itemExtent == lastVisibleOffset) targetLastIndex--;

//     // Validates the target index range.
//     while (!childManager.childExistsAt(targetFirstIndex) &&
//         targetFirstIndex <= targetLastIndex) {
//       targetFirstIndex++;
//     }
//     while (!childManager.childExistsAt(targetLastIndex) &&
//         targetFirstIndex <= targetLastIndex) {
//       targetLastIndex--;
//     }

//     // If it turns out there's no children to layout, we remove old children and
//     // return.
//     if (targetFirstIndex > targetLastIndex) {
//       while (firstChild != null) {
//         _destroyChild(firstChild!);
//       }
//       return;
//     }

//     if (childCount > 0 &&
//         (indexOf(firstChild!) > targetLastIndex ||
//             indexOf(lastChild!) < targetFirstIndex)) {
//       while (firstChild != null) {
//         _destroyChild(firstChild!);
//       }
//     }

//     // If there is no child at this stage, we add the first one that is in
//     // target range.
//     if (childCount == 0) {
//       _createChild(targetFirstIndex);
//       _layoutChild(firstChild!, childConstraints, targetFirstIndex);
//     }

//     int currentFirstIndex = indexOf(firstChild!);
//     int currentLastIndex = indexOf(lastChild!);

//     // Remove all unnecessary children by shortening the current child list, in
//     // both directions.
//     while (currentFirstIndex < targetFirstIndex) {
//       _destroyChild(firstChild!);
//       currentFirstIndex++;
//     }
//     while (currentLastIndex > targetLastIndex) {
//       _destroyChild(lastChild!);
//       currentLastIndex--;
//     }

//     // Relayout all active children.
//     RenderBox child = firstChild!;
//     while (child != null) {
//       child.layout(childConstraints, parentUsesSize: true);
//       child = childAfter(child)!;
//     }

//     // Spawning new children that are actually visible but not in child list yet.
//     while (currentFirstIndex > targetFirstIndex) {
//       _createChild(currentFirstIndex - 1);
//       _layoutChild(firstChild!, childConstraints, --currentFirstIndex);
//     }
//     while (currentLastIndex < targetLastIndex) {
//       _createChild(currentLastIndex + 1, after: lastChild);
//       _layoutChild(lastChild!, childConstraints, ++currentLastIndex);
//     }

//     offset.applyViewportDimension(_viewportExtent);

//     // Applying content dimensions bases on how the childManager builds widgets:
//     // if it is available to provide a child just out of target range, then
//     // we don't know whether there's a limit yet, and set the dimension to the
//     // estimated value. Otherwise, we set the dimension limited to our target
//     // range.
//     final double minScrollExtent =
//         childManager.childExistsAt(targetFirstIndex - 1)
//             ? _minEstimatedScrollExtent
//             : indexToScrollOffset(targetFirstIndex);
//     final double maxScrollExtent =
//         childManager.childExistsAt(targetLastIndex + 1)
//             ? _maxEstimatedScrollExtent
//             : indexToScrollOffset(targetLastIndex);
//     offset.applyContentDimensions(minScrollExtent, maxScrollExtent);
//   }

//   bool _shouldClipAtCurrentOffset() {
//     final double firsttUntransformedPaint =
//         _getUntransformedPaintingCoordinate(0.0);
//     return firsttUntransformedPaint < 0.0 ||
//         _mainAxisSize <
//             firsttUntransformedPaint + _maxEstimatedScrollExtent + _itemExtent;
//   }

//   @override
//   void paint(PaintingContext context, Offset offset) {
//     if (childCount > 0) {
//       if (_clipToSize && _shouldClipAtCurrentOffset()) {
//         context.pushClipRect(
//           needsCompositing,
//           offset,
//           Offset.zero & size,
//           _paintVisibleChildren,
//         );
//       } else {
//         _paintVisibleChildren(context, offset);
//       }
//     }
//   }

//   /// Paints all children visible in the current viewport.
//   void _paintVisibleChildren(PaintingContext context, Offset offset) {
//     RenderBox childToPaint = firstChild!;
//     CircleListParentData childParentData = childToPaint?.parentData;

//     while (childParentData != null) {
//       _paintTransformedChild(
//           childToPaint, context, offset, childParentData.offset);
//       childToPaint = childAfter(childToPaint)!;
//       childParentData = childToPaint?.parentData;
//     }
//   }

//   /// Takes in a child with a **scrollable layout offset** and paints it in the
//   /// **transformed cylindrical space viewport painting coordinates**.
//   void _paintTransformedChild(
//     RenderBox child,
//     PaintingContext context,
//     Offset offset,
//     Offset layoutOffset,
//   ) {
//     final Offset untransformedPaintingCoordinates = offset +
//         Offset(
//           axis == Axis.vertical
//               ? layoutOffset.dx
//               : _getUntransformedPaintingCoordinate(layoutOffset.dx),
//           axis == Axis.horizontal
//               ? layoutOffset.dy
//               : _getUntransformedPaintingCoordinate(layoutOffset.dy),
//         );

//     final mainCordinate = axis == Axis.horizontal
//         ? untransformedPaintingCoordinates.dx
//         : untransformedPaintingCoordinates.dy;

//     final fractional =
//         ((_mainAxisSize / 2) - (mainCordinate + _itemExtent / 2.0)) /
//             (_mainAxisSize / 2);

//     double angle;

//     if (axis == Axis.horizontal) {
//       angle = lerpDouble(-math.pi / 2, -math.pi, fractional)!;
//     } else {
//       angle = lerpDouble(0, -math.pi / 2, fractional)!;
//     }

//     final circleOffset =
//         Offset(radius * math.cos(angle), radius * math.sin(angle));

//     final Matrix4 circleTransform = Matrix4.translationValues(
//       axis == Axis.vertical ? circleOffset.dx - radius : circleOffset.dx,
//       axis == Axis.horizontal ? circleOffset.dy : circleOffset.dy - radius,
//       0,
//     );

//     // Offset that helps painting everything in the center (e.g. angle = 0).
//     Offset offsetToCenter;

//     if (axis == Axis.horizontal) {
//       offsetToCenter = Offset(
//         0,
//         untransformedPaintingCoordinates.dy + radius,
//       );
//     } else {
//       offsetToCenter = Offset(
//         untransformedPaintingCoordinates.dx,
//         radius - _scrollMarginExtent,
//       );
//     }

//     _paintChild(context, offset, child, circleTransform, offsetToCenter);
//   }

//   // / Paint the child cylindrically at given offset.
//   void _paintChild(
//     PaintingContext context,
//     Offset offset,
//     RenderBox child,
//     Matrix4 circleTransform,
//     Offset offsetToCenter,
//   ) {
//     context.pushTransform(
//       false,
//       offset,
//       circleTransform,
//       // Pre-transform painting function.
//       (PaintingContext context, Offset offset) {
//         context.paintChild(
//           child,
//           // Paint everything in the center (e.g. angle = 0), then transform.
//           offset + offsetToCenter,
//         );
//       },
//     );
//   }

//   /// This returns the matrices relative to the **untransformed plane's viewport
//   /// painting coordinates** system.
//   @override
//   void applyPaintTransform(RenderBox child, Matrix4 transform) {
//     final CircleListParentData parentData = child?.parentData;
//     if (axis == Axis.vertical) {
//       transform.translate(
//           0.0, _getUntransformedPaintingCoordinate(parentData.offset.dy));
//     } else {
//       transform.translate(
//           _getUntransformedPaintingCoordinate(parentData.offset.dx), 0.0);
//     }
//   }

//   @override
//   Rect describeApproximatePaintClip(RenderObject child) {
//     if (_shouldClipAtCurrentOffset()) {
//       return Offset.zero & size;
//     }
//     return null;
//   }

//   @override
//   bool hitTestChildren(HitTestResult result, {required Offset position}) {
//     return false;
//   }

//   @override
//   RevealedOffset getOffsetToReveal(RenderObject target, double alignment,
//       {Rect? rect}) {
//     // `target` is only fully revealed when in the selected/center position. Therefore,
//     // this method always returns the offset that shows `target` in the center position,
//     // which is the same offset for all `alignment` values.

//     rect ??= target.paintBounds;

//     // `child` will be the last RenderObject before the viewport when walking up from `target`.
//     RenderObject child = target;
//     while (child.parent != this) {
//       child = child.parent;
//     }

//     final CircleListParentData parentData = child.parentData;
//     final double targetOffset = axis == Axis.horizontal
//         ? parentData.offset.dx
//         : parentData.offset.dy; // the so-called "centerPosition"

//     final Matrix4 transform = target.getTransformTo(this);
//     final Rect bounds = MatrixUtils.transformRect(transform, rect);
//     final Rect targetRect = bounds.translate(
//       axis == Axis.vertical ? 0.0 : (size.width - itemExtent) / 2,
//       axis == Axis.horizontal ? 0.0 : (size.height - itemExtent) / 2,
//     );

//     return RevealedOffset(offset: targetOffset, rect: targetRect);
//   }

//   @override
//   void showOnScreen({
//     RenderObject? descendant,
//     Rect? rect,
//     Duration duration = Duration.zero,
//     Curve curve = Curves.ease,
//   }) {
//     final RevealedOffset revealedOffset =
//         getOffsetToReveal(descendant!, 0.5, rect: rect);
//     if (duration == Duration.zero) {
//       offset.jumpTo(revealedOffset.offset);
//     } else {
//       offset.animateTo(revealedOffset.offset, duration: duration, curve: curve);
//     }
//     rect = revealedOffset.rect;

//     super.showOnScreen(
//       rect: rect,
//       duration: duration,
//       curve: curve,
//     );
//   }
// }
