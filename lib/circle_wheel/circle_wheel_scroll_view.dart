// import 'dart:async';
// import 'dart:collection';
// import 'dart:math' as math;
// import 'package:flutter/physics.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter/widgets.dart';

// import 'circle_wheel_render.dart';

// abstract class CircleListChildDelegate {
//   Widget build(BuildContext context, int index);
//   int get estimatedChildCount;
//   int trueIndexOf(int index) => index;
//   bool shouldRebuild(covariant CircleListChildDelegate oldDelegate);
// }

// class CircleListChildListDelegate extends CircleListChildDelegate {
//   CircleListChildListDelegate({required this.children});
//   final List<Widget> children;

//   @override
//   int get estimatedChildCount => children.length;

//   @override
//   Widget build(BuildContext context, int index) {
//     if (index < 0 || index >= children.length) return const SizedBox();
//     return IndexedSemantics(index: index, child: children[index]);
//   }

//   @override
//   bool shouldRebuild(covariant CircleListChildListDelegate oldDelegate) {
//     return children != oldDelegate.children;
//   }
// }

// class CircleListChildLoopingListDelegate extends CircleListChildDelegate {
//   /// Constructs the delegate from a concrete list of children.
//   CircleListChildLoopingListDelegate({required this.children});

//   /// The list containing all children that can be supplied.
//   final List<Widget> children;

//   @override
//   int get estimatedChildCount => 0;

//   @override
//   int trueIndexOf(int index) => index % children.length;

//   @override
//   Widget build(BuildContext context, int index) {
//     if (children.isEmpty) return const SizedBox();
//     return IndexedSemantics(
//         index: index, child: children[index % children.length]);
//   }

//   @override
//   bool shouldRebuild(covariant CircleListChildLoopingListDelegate oldDelegate) {
//     return children != oldDelegate.children;
//   }
// }

// class CircleListChildBuilderDelegate extends CircleListChildDelegate {
//   /// Constructs the delegate from a builder callback.
//   CircleListChildBuilderDelegate({
//     required this.builder,
//     required this.childCount,
//   });

//   /// Called lazily to build children.
//   final IndexedWidgetBuilder builder;

//   final int childCount;

//   @override
//   int get estimatedChildCount => childCount;

//   @override
//   Widget build(BuildContext context, int index) {
//     // if (childCount == null) {
//     //   final Widget child = builder(context, index);
//     //   return child == null
//     //       ? null
//     //       : IndexedSemantics(index: index, child: child);
//     // }
//     if (index < 0 || index >= childCount) return const SizedBox();
//     return IndexedSemantics(index: index, child: builder(context, index));
//   }

//   @override
//   bool shouldRebuild(covariant CircleListChildBuilderDelegate oldDelegate) {
//     return builder != oldDelegate.builder ||
//         childCount != oldDelegate.childCount;
//   }
// }

// class FixedExtentScrollController extends ScrollController {
//   FixedExtentScrollController({
//     this.initialItem = 0,
//   });

//   final int initialItem;

//   int get selectedItem {
//     assert(
//       positions.isNotEmpty,
//       'FixedExtentScrollController.selectedItem cannot be accessed before a '
//       'scroll view is built with it.',
//     );
//     assert(
//       positions.length == 1,
//       'The selectedItem property cannot be read when multiple scroll views are '
//       'attached to the same FixedExtentScrollController.',
//     );
//     final _FixedExtentScrollPosition position = this.position;
//     return position.itemIndex;
//   }

//   Future<void> animateToItem(
//     int itemIndex, {
//     required Duration duration,
//     required Curve curve,
//   }) async {
//     if (!hasClients) {
//       return;
//     }

//     final List<Future<void>> futures = <Future<void>>[];
//     for (_FixedExtentScrollPosition position in positions) {
//       futures.add(position.animateTo(
//         itemIndex * position.itemExtent,
//         duration: duration,
//         curve: curve,
//       ));
//     }
//     await Future.wait<void>(futures);
//   }

//   void jumpToItem(int itemIndex) {
//     for (_FixedExtentScrollPosition position in positions) {
//       position.jumpTo(itemIndex * position.itemExtent);
//     }
//   }

//   @override
//   ScrollPosition createScrollPosition(ScrollPhysics physics,
//       ScrollContext context, ScrollPosition oldPosition) {
//     return _FixedExtentScrollPosition(
//       physics: physics,
//       context: context,
//       initialItem: initialItem,
//       oldPosition: oldPosition,
//     );
//   }
// }

// class FixedExtentMetrics extends FixedScrollMetrics {
//   /// Creates an immutable snapshot of values associated with a
//   /// [CircleListScrollView].
//   FixedExtentMetrics({
//     required double minScrollExtent,
//     required double maxScrollExtent,
//     required double pixels,
//     required double viewportDimension,
//     required AxisDirection axisDirection,
//     required this.itemIndex,
//   }) : super(
//           minScrollExtent: minScrollExtent,
//           maxScrollExtent: maxScrollExtent,
//           pixels: pixels,
//           viewportDimension: viewportDimension,
//           axisDirection: axisDirection,
//         );

//   @override
//   FixedExtentMetrics copyWith({
//     double? minScrollExtent,
//     double? maxScrollExtent,
//     double? pixels,
//     double? viewportDimension,
//     AxisDirection? axisDirection,
//     int? itemIndex,
//   }) {
//     return FixedExtentMetrics(
//       minScrollExtent: minScrollExtent ?? this.minScrollExtent,
//       maxScrollExtent: maxScrollExtent ?? this.maxScrollExtent,
//       pixels: pixels ?? this.pixels,
//       viewportDimension: viewportDimension ?? this.viewportDimension,
//       axisDirection: axisDirection ?? this.axisDirection,
//       itemIndex: itemIndex ?? this.itemIndex,
//     );
//   }

//   /// The scroll view's currently selected item index.
//   final int itemIndex;
// }

// int _getItemFromOffset({
//   double? offset,
//   required double itemExtent,
//   required double minScrollExtent,
//   required double maxScrollExtent,
// }) {
//   return (_clipOffsetToScrollableRange(
//               offset!, minScrollExtent, maxScrollExtent) /
//           itemExtent)
//       .round();
// }

// double _clipOffsetToScrollableRange(
//     double offset, double minScrollExtent, double maxScrollExtent) {
//   return math.min(math.max(offset, minScrollExtent), maxScrollExtent);
// }

// class _FixedExtentScrollPosition extends ScrollPositionWithSingleContext
//     implements FixedExtentMetrics {
//   _FixedExtentScrollPosition({
//     required ScrollPhysics physics,
//     required ScrollContext context,
//     required int initialItem,
//     bool keepScrollOffset = true,
//     ScrollPosition? oldPosition,
//     String? debugLabel,
//   })  : assert(context is _FixedExtentScrollableState,
//             'FixedExtentScrollController can only be used with CircleListScrollViews'),
//         super(
//           physics: physics,
//           context: context,
//           initialPixels: _getItemExtentFromScrollContext(context) * initialItem,
//           keepScrollOffset: keepScrollOffset,
//           oldPosition: oldPosition,
//           debugLabel: debugLabel,
//         );

//   static double _getItemExtentFromScrollContext(ScrollContext context) {
//     final _FixedExtentScrollableState scrollable = context;
//     return scrollable.itemExtent;
//   }

//   double get itemExtent => _getItemExtentFromScrollContext(context);

//   @override
//   int get itemIndex {
//     return _getItemFromOffset(
//       offset: pixels,
//       itemExtent: itemExtent,
//       minScrollExtent: minScrollExtent,
//       maxScrollExtent: maxScrollExtent,
//     );
//   }

//   @override
//   FixedExtentMetrics copyWith({
//     double? minScrollExtent,
//     double? maxScrollExtent,
//     double? pixels,
//     double? viewportDimension,
//     AxisDirection? axisDirection,
//     int? itemIndex,
//   }) {
//     return FixedExtentMetrics(
//       minScrollExtent: minScrollExtent ?? this.minScrollExtent,
//       maxScrollExtent: maxScrollExtent ?? this.maxScrollExtent,
//       pixels: pixels ?? this.pixels,
//       viewportDimension: viewportDimension ?? this.viewportDimension,
//       axisDirection: axisDirection ?? this.axisDirection,
//       itemIndex: itemIndex ?? this.itemIndex,
//     );
//   }
// }

// /// A [Scrollable] which must be given its viewport children's item extent
// /// size so it can pass it on ultimately to the [FixedExtentScrollController].
// class _FixedExtentScrollable extends Scrollable {
//   const _FixedExtentScrollable({
//     Key? key,
//     AxisDirection axisDirection = AxisDirection.down,
//     ScrollController? controller,
//     ScrollPhysics? physics,
//     required this.itemExtent,
//     required ViewportBuilder viewportBuilder,
//   }) : super(
//           key: key,
//           axisDirection: axisDirection,
//           controller: controller,
//           physics: physics,
//           viewportBuilder: viewportBuilder,
//         );

//   final double itemExtent;

//   @override
//   _FixedExtentScrollableState createState() => _FixedExtentScrollableState();
// }

// class _FixedExtentScrollableState extends ScrollableState {
//   double get itemExtent {
//     // Downcast because only _FixedExtentScrollable can make _FixedExtentScrollableState.
//     final _FixedExtentScrollable actualWidget = widget;
//     return actualWidget.itemExtent;
//   }
// }

// class CircleFixedExtentScrollPhysics extends ScrollPhysics {
//   /// Creates a scroll physics that always lands on items.
//   const CircleFixedExtentScrollPhysics({required ScrollPhysics parent})
//       : super(parent: parent);

//   @override
//   CircleFixedExtentScrollPhysics applyTo(ScrollPhysics ancestor) {
//     return CircleFixedExtentScrollPhysics(parent: buildParent(ancestor)!);
//   }

//   @override
//   Simulation createBallisticSimulation(
//       ScrollMetrics position, double velocity) {
//     assert(
//         position is _FixedExtentScrollPosition,
//         'CircleFixedExtentScrollPhysics can only be used with Scrollables that uses '
//         'the FixedExtentScrollController');

//     final _FixedExtentScrollPosition metrics = position;

//     if ((velocity <= 0.0 && metrics.pixels <= metrics.minScrollExtent) ||
//         (velocity >= 0.0 && metrics.pixels >= metrics.maxScrollExtent)) {
//       return super.createBallisticSimulation(metrics, velocity);
//     }

//     final Simulation testFrictionSimulation =
//         super.createBallisticSimulation(metrics, velocity);

//     if ((testFrictionSimulation.x(double.infinity) == metrics.minScrollExtent ||
//         testFrictionSimulation.x(double.infinity) == metrics.maxScrollExtent)) {
//       return super.createBallisticSimulation(metrics, velocity);
//     }

//     final int settlingItemIndex = _getItemFromOffset(
//       offset: testFrictionSimulation.x(double.infinity) ?? metrics.pixels,
//       itemExtent: metrics.itemExtent,
//       minScrollExtent: metrics.minScrollExtent,
//       maxScrollExtent: metrics.maxScrollExtent,
//     );

//     final double settlingPixels = settlingItemIndex * metrics.itemExtent;

//     // Scenario 3:
//     // If there's no velocity and we're already at where we intend to land,
//     // do nothing.
//     if (velocity.abs() < tolerance.velocity &&
//         (settlingPixels - metrics.pixels).abs() < tolerance.distance) {
//       return null;
//     }

//     // Scenario 4:
//     // If we're going to end back at the same item because initial velocity
//     // is too low to break past it, use a spring simulation to get back.
//     if (settlingItemIndex == metrics.itemIndex) {
//       return SpringSimulation(
//         SpringDescription.withDampingRatio(
//           mass: 0.5,
//           stiffness: 100.0,
//           ratio: 0.6,
//         ),
//         metrics.pixels,
//         settlingPixels,
//         velocity,
//         tolerance: tolerance,
//       );
//     }

//     // Scenario 5:
//     // Create a new spring simulation on the item closest to the natural stopping point.
//     return SpringSimulation(
//       SpringDescription.withDampingRatio(
//         mass: 0.5,
//         stiffness: 100.0,
//         ratio: 0.9,
//       ),
//       metrics.pixels,
//       settlingPixels,
//       velocity,
//       tolerance: tolerance,
//     );
//   }
// }

// class CircleListScrollView extends StatefulWidget {
//   /// Constructs a list in which children are scrolled a wheel. Its children
//   /// are passed to a delegate and lazily built during layout.
//   CircleListScrollView({
//     Key? key,
//     this.controller,
//     this.physics,
//     required this.itemExtent,
//     this.onSelectedItemChanged,
//     this.clipToSize = true,
//     this.renderChildrenOutsideViewport = false,
//     required List<Widget> children,
//     this.axis = Axis.vertical,
//     this.radius = 100,
//   })  : assert(itemExtent > 0),
//         assert(
//           !renderChildrenOutsideViewport || !clipToSize,
//           RenderCircleListViewport
//               .clipToSizeAndRenderChildrenOutsideViewportConflict,
//         ),
//         childDelegate = CircleListChildListDelegate(children: children),
//         super(key: key);

//   /// Constructs a list in which children are scrolled a wheel. Its children
//   /// are managed by a delegate and are lazily built during layout.
//   const CircleListScrollView.useDelegate({
//     Key? key,
//     this.controller,
//     this.physics,
//     required this.itemExtent,
//     this.onSelectedItemChanged,
//     this.clipToSize = true,
//     this.renderChildrenOutsideViewport = false,
//     required this.childDelegate,
//     this.axis = Axis.vertical,
//     this.radius = 100,
//   })  : assert(itemExtent > 0),
//         assert(
//           !renderChildrenOutsideViewport || !clipToSize,
//           RenderCircleListViewport
//               .clipToSizeAndRenderChildrenOutsideViewportConflict,
//         ),
//         super(key: key);

//   final ScrollController? controller;

//   /// Defaults to matching platform conventions.
//   final ScrollPhysics? physics;

//   /// Size of each child in the main axis. Must not be null and must be
//   /// positive.
//   final double itemExtent;

//   /// On optional listener that's called when the centered item changes.
//   final ValueChanged<int>? onSelectedItemChanged;

//   /// {@macro flutter.rendering.wheelList.clipToSize}
//   final bool clipToSize;

//   /// {@macro flutter.rendering.wheelList.renderChildrenOutsideViewport}
//   final bool renderChildrenOutsideViewport;

//   /// A delegate that helps lazily instantiating child.
//   final CircleListChildDelegate childDelegate;

//   /// Define a main axis of scrolling
//   final Axis axis;

//   /// Circle radius
//   final double radius;

//   @override
//   _CircleListScrollViewState createState() => _CircleListScrollViewState();
// }

// class _CircleListScrollViewState extends State<CircleListScrollView> {
//   int _lastReportedItemIndex = 0;
//   ScrollController? scrollController;

//   @override
//   void initState() {
//     super.initState();
//     scrollController = widget.controller ?? FixedExtentScrollController();
//     if (widget.controller is FixedExtentScrollController) {
//       final FixedExtentScrollController controller = widget.controller;
//       _lastReportedItemIndex = controller.initialItem;
//     }
//   }

//   @override
//   void didUpdateWidget(CircleListScrollView oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.controller != scrollController) {
//       final ScrollController oldScrollController = scrollController!;
//       SchedulerBinding.instance.addPostFrameCallback((_) {
//         oldScrollController.dispose();
//       });
//       scrollController = widget.controller;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return NotificationListener<ScrollNotification>(
//       onNotification: (ScrollNotification notification) {
//         if (notification.depth == 0 &&
//             notification is ScrollUpdateNotification &&
//             notification.metrics is FixedExtentMetrics) {
//           final FixedExtentMetrics metrics = notification.metrics;
//           final int currentItemIndex = metrics.itemIndex;
//           if (currentItemIndex != _lastReportedItemIndex) {
//             _lastReportedItemIndex = currentItemIndex;
//             final int trueIndex =
//                 widget.childDelegate.trueIndexOf(currentItemIndex);
//             widget.onSelectedItemChanged(trueIndex);
//           }
//         }
//         return false;
//       },
//       child: _FixedExtentScrollable(
//         axisDirection: widget.axis == Axis.horizontal
//             ? AxisDirection.right
//             : AxisDirection.down,
//         controller: scrollController,
//         physics: widget.physics,
//         itemExtent: widget.itemExtent,
//         viewportBuilder: (BuildContext context, ViewportOffset offset) {
//           return CircleListViewport(
//             axis: widget.axis,
//             radius: widget.radius,
//             itemExtent: widget.itemExtent,
//             clipToSize: widget.clipToSize,
//             renderChildrenOutsideViewport: widget.renderChildrenOutsideViewport,
//             offset: offset,
//             childDelegate: widget.childDelegate,
//           );
//         },
//       ),
//     );
//   }
// }

// class CircleListElement extends RenderObjectElement
//     implements CircleListChildManager {
//   CircleListElement(CircleListViewport widget) : super(widget);

//   @override
//   CircleListViewport get widget => super.widget;

//   @override
//   RenderCircleListViewport get renderObject => super.renderObject;

//   final Map<int, Widget> _childWidgets = HashMap<int, Widget>();

//   final SplayTreeMap<int, Element> _childElements =
//       SplayTreeMap<int, Element>();

//   @override
//   void update(CircleListViewport newWidget) {
//     final CircleListViewport oldWidget = widget;
//     super.update(newWidget);
//     final CircleListChildDelegate newDelegate = newWidget.childDelegate;
//     final CircleListChildDelegate oldDelegate = oldWidget.childDelegate;
//     if (newDelegate != oldDelegate &&
//         (newDelegate.runtimeType != oldDelegate.runtimeType ||
//             newDelegate.shouldRebuild(oldDelegate))) performRebuild();
//   }

//   @override
//   int get childCount => widget.childDelegate.estimatedChildCount;

//   @override
//   void performRebuild() {
//     _childWidgets.clear();
//     super.performRebuild();
//     if (_childElements.isEmpty) return;

//     final int firstIndex = _childElements.firstKey();
//     final int lastIndex = _childElements.lastKey();

//     for (int index = firstIndex; index <= lastIndex; ++index) {
//       final Element newChild =
//           updateChild(_childElements[index], retrieveWidget(index), index);
//       if (newChild != null) {
//         _childElements[index] = newChild;
//       } else {
//         _childElements.remove(index);
//       }
//     }
//   }

//   Widget retrieveWidget(int index) {
//     return _childWidgets.putIfAbsent(
//         index, () => widget.childDelegate.build(this, index));
//   }

//   @override
//   bool childExistsAt(int index) => retrieveWidget(index) != null;

//   @override
//   void createChild(int index, {required RenderBox after}) {
//     owner.buildScope(this, () {
//       final bool insertFirst = after == null;
//       assert(insertFirst || _childElements[index - 1] != null);
//       final Element newChild =
//           updateChild(_childElements[index], retrieveWidget(index), index);
//       if (newChild != null) {
//         _childElements[index] = newChild;
//       } else {
//         _childElements.remove(index);
//       }
//     });
//   }

//   @override
//   void removeChild(RenderBox child) {
//     final int index = renderObject.indexOf(child);
//     owner.buildScope(this, () {
//       assert(_childElements.containsKey(index));
//       final Element result = updateChild(_childElements[index], null, index);
//       assert(result == null);
//       _childElements.remove(index);
//       assert(!_childElements.containsKey(index));
//     });
//   }

//   @override
//   Element updateChild(Element child, Widget newWidget, dynamic newSlot) {
//     final CircleListParentData oldParentData = child?.renderObject?.parentData;
//     final Element newChild = super.updateChild(child, newWidget, newSlot);
//     final CircleListParentData newParentData =
//         newChild?.renderObject?.parentData;
//     newParentData.index = newSlot;
//     newParentData.offset = oldParentData.offset;

//     return newChild;
//   }

//   void insertChildRenderObject(RenderObject child, int slot) {
//     final RenderCircleListViewport renderObject = this.renderObject;
//     assert(renderObject.debugValidateChild(child));
//     renderObject.insert(child, after: _childElements[slot - 1]?.renderObject);
//     assert(renderObject == this.renderObject);
//   }

//   void moveChildRenderObject(RenderObject child, dynamic slot) {
//     const String moveChildRenderObjectErrorMessage =
//         'Currently we maintain the list in contiguous increasing order, so '
//         'moving children around is not allowed.';
//     assert(false, moveChildRenderObjectErrorMessage);
//   }

//   void removeChildRenderObject(RenderObject child) {
//     assert(child.parent == renderObject);
//     renderObject.remove(child);
//   }

//   @override
//   void visitChildren(ElementVisitor visitor) {
//     _childElements.forEach((int key, Element child) {
//       visitor(child);
//     });
//   }

//   @override
//   void forgetChild(Element child) {
//     super.forgetChild(child);
//     _childElements.remove(child.slot);
//   }
// }

// class CircleListViewport extends RenderObjectWidget {
//   const CircleListViewport({
//     Key? key,
//     required this.itemExtent,
//     this.clipToSize = true,
//     this.renderChildrenOutsideViewport = false,
//     required this.offset,
//     required this.childDelegate,
//     required this.axis,
//     this.radius = 100,
//   })  : assert(itemExtent > 0),
//         assert(
//           !renderChildrenOutsideViewport || !clipToSize,
//           RenderCircleListViewport
//               .clipToSizeAndRenderChildrenOutsideViewportConflict,
//         ),
//         super(key: key);

//   /// {@macro flutter.rendering.wheelList.itemExtent}
//   final double itemExtent;

//   /// {@macro flutter.rendering.wheelList.clipToSize}
//   final bool clipToSize;

//   /// {@macro flutter.rendering.wheelList.renderChildrenOutsideViewport}
//   final bool renderChildrenOutsideViewport;

//   /// [ViewportOffset] object describing the content that should be visible
//   /// in the viewport.
//   final ViewportOffset offset;

//   /// A delegate that lazily instantiates children.
//   final CircleListChildDelegate childDelegate;

//   final Axis axis;

//   final double radius;

//   @override
//   CircleListElement createElement() => CircleListElement(this);

//   @override
//   RenderCircleListViewport createRenderObject(BuildContext context) {
//     final CircleListElement childManager = context;
//     return RenderCircleListViewport(
//       axis: axis,
//       radius: radius,
//       childManager: childManager,
//       offset: offset,
//       itemExtent: itemExtent,
//       clipToSize: clipToSize,
//       renderChildrenOutsideViewport: renderChildrenOutsideViewport,
//     );
//   }

//   @override
//   void updateRenderObject(
//       BuildContext context, RenderCircleListViewport renderObject) {
//     renderObject
//       ..axis = axis
//       ..radius = radius
//       ..offset = offset
//       ..itemExtent = itemExtent
//       ..clipToSize = clipToSize
//       ..renderChildrenOutsideViewport = renderChildrenOutsideViewport;
//   }
// }
