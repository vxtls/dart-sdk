// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:compiler/src/util/testing.dart';

// From co19/Language/Types/Function_Types/subtype_named_args_t01.

/*spec.class: A:explicit=[A?,dynamic Function({a:A?})?]*/
class A {}

/*spec.class: B:explicit=[B?,dynamic Function({a:B?}),dynamic Function({a:B?})?,dynamic Function({f:dynamic Function({a:B?})?}),dynamic Function({f:dynamic Function({a:B?})?})?]*/
/*prod.class: B:explicit=[dynamic Function({a:B?}),dynamic Function({f:dynamic Function({a:B?})?})]*/
class B implements A {}

/*spec.class: C:explicit=[C?,dynamic Function({a:C?})?,dynamic Function({c:C?})]*/
/*prod.class: C:explicit=[dynamic Function({c:C?})]*/
class C implements B {}

/*spec.class: D:explicit=[D?,dynamic Function({a:D?})?]*/
class D implements C {}

typedef t1({B? a});
typedef t2({C? c});
typedef t3({int? i});
typedef t4({var v});
typedef t5({Map? m});
typedef t6({Map<int, num>? m});
typedef t7({t1? f});
typedef t8({Object? a});

typedef okWithT1_1({A? a});
typedef okWithT1_2({B? a});
typedef okWithT1_3({C? a});
typedef okWithT1_4({D? a});

main() {
  makeLive(/*needsSignature*/ ({A? a}) {} is t1);
  makeLive(/*needsSignature*/ ({B? a}) {} is t1);
  makeLive(/*needsSignature*/ ({C? a}) {} is t1);
  makeLive(/*needsSignature*/ ({D? a}) {} is t1);
  makeLive(/*needsSignature*/ ({Object? a}) {} is t1);
  makeLive(/*needsSignature*/ ({var a}) {} is t1);

  makeLive(/*needsSignature*/ ({A? c}) {} is t2);
  makeLive(/*needsSignature*/ ({B? c}) {} is t2);
  makeLive(/*needsSignature*/ ({C? c}) {} is t2);
  makeLive(/*needsSignature*/ ({D? c}) {} is t2);
  makeLive(/*needsSignature*/ ({Object? c}) {} is t2);
  makeLive(/*needsSignature*/ ({var c}) {} is t2);

  makeLive(/*needsSignature*/ ({num? i}) {} is t3);
  makeLive(/*needsSignature*/ ({int? i}) {} is t3);
  makeLive(/*needsSignature*/ ({Object? i}) {} is t3);
  makeLive(/*needsSignature*/ ({var i}) {} is t3);

  makeLive(/*needsSignature*/ ({A? v}) {} is t4);
  makeLive(/*needsSignature*/ ({B? v}) {} is t4);
  makeLive(/*needsSignature*/ ({C? v}) {} is t4);
  makeLive(/*needsSignature*/ ({D? v}) {} is t4);
  makeLive(/*needsSignature*/ ({Object? v}) {} is t4);
  makeLive(/*needsSignature*/ ({var v}) {} is t4);
  makeLive(/*needsSignature*/ ({num? v}) {} is t4);
  makeLive(/*needsSignature*/ ({int? v}) {} is t4);
  makeLive(/*needsSignature*/ ({Map? v}) {} is t4);
  makeLive(
    /*needsSignature*/ ({Map<List<Map<List, List<int>>>, List>? v}) {} is t4,
  );
  makeLive(/*needsSignature*/ ({List? v}) {} is t4);
  makeLive(/*needsSignature*/ ({t8? v}) {} is t4);
  makeLive(/*needsSignature*/ ({t7? v}) {} is t4);

  makeLive(/*needsSignature*/ ({Map? m}) {} is t5);
  makeLive(/*needsSignature*/ ({Map<List, t8>? m}) {} is t5);
  makeLive(/*needsSignature*/ ({Object? m}) {} is t5);
  makeLive(/*needsSignature*/ ({var m}) {} is t5);
  makeLive(/*needsSignature*/ ({Map<List, List>? m}) {} is t5);
  makeLive(/*needsSignature*/ ({Map<int, t8>? m}) {} is t5);

  makeLive(/*needsSignature*/ ({Map<num, num>? m}) {} is t6);
  makeLive(/*needsSignature*/ ({Map<int, int>? m}) {} is t6);
  makeLive(/*needsSignature*/ ({Map? m}) {} is t6);
  makeLive(/*needsSignature*/ ({Object? m}) {} is t6);
  makeLive(/*needsSignature*/ ({var m}) {} is t6);

  makeLive(/*needsSignature*/ ({okWithT1_1? f}) {} is t7);
  makeLive(/*needsSignature*/ ({okWithT1_2? f}) {} is t7);
  makeLive(/*needsSignature*/ ({okWithT1_3? f}) {} is t7);
  makeLive(/*needsSignature*/ ({okWithT1_4? f}) {} is t7);

  makeLive(/*needsSignature*/ ({A? a}) {} is t8);
  makeLive(/*needsSignature*/ ({B? a}) {} is t8);
  makeLive(/*needsSignature*/ ({C? a}) {} is t8);
  makeLive(/*needsSignature*/ ({D? a}) {} is t8);
  makeLive(/*needsSignature*/ ({Object? a}) {} is t8);
  makeLive(/*needsSignature*/ ({var a}) {} is t8);
  makeLive(/*needsSignature*/ ({num? a}) {} is t8);
  makeLive(/*needsSignature*/ ({int? a}) {} is t8);
  makeLive(/*needsSignature*/ ({Map? a}) {} is t8);
  makeLive(
    /*needsSignature*/ ({Map<List<Map<List, List<int>>>, List>? a}) {} is t8,
  );
  makeLive(/*needsSignature*/ ({List? a}) {} is t8);
}
