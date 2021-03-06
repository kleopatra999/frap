Require Import Relations.

Set Implicit Arguments.


Record trsys state := {
  Initial : state -> Prop;
  Step : state -> state -> Prop
}.

Definition invariantFor {state} (sys : trsys state) (invariant : state -> Prop) :=
  forall s, sys.(Initial) s
            -> forall s', sys.(Step)^* s s'
                          -> invariant s'.

Theorem use_invariant : forall {state} (sys : trsys state) (invariant : state -> Prop) s s',
  sys.(Step)^* s s'
  -> sys.(Initial) s
  -> invariantFor sys invariant
  -> invariant s'.
Proof.
  firstorder.
Qed.

Theorem invariantFor_monotone : forall {state} (sys : trsys state)
  (invariant1 invariant2 : state -> Prop),
  (forall s, invariant1 s -> invariant2 s)
  -> invariantFor sys invariant1
  -> invariantFor sys invariant2.
Proof.
  unfold invariantFor; intuition eauto.
Qed.

Theorem invariant_induction : forall {state} (sys : trsys state)
  (invariant : state -> Prop),
  (forall s, sys.(Initial) s -> invariant s)
  -> (forall s, invariant s -> forall s', sys.(Step) s s' -> invariant s')
  -> invariantFor sys invariant.
Proof.
  unfold invariantFor; intros.
  assert (invariant s) by eauto.
  clear H1.
  induction H2; eauto.
Qed.
