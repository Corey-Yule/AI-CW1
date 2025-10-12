(define (domain lunar)
    (:requirements :strips :typing)

    ; -------------------------------
    ; Types
    ; -------------------------------

    ; EXAMPLE

    ; (:types
    ;     parent_type
    ;     child_type - parent_type

    ; )
    (:types
        lander rover waypoint
    )

    ; -------------------------------
    ; Predicates
    ; -------------------------------

    ; EXAMPLE

    ; (:predicates
    ;     (no_arity_predicate)
    ;     (one_arity_predicate ?p - parameter_type)
    ; )

    (:predicates
        (rover_pos ?x ?y)
        (surface_loc_links ?x ?y)
        (data ?x)
        (physical_sample)
        (lander_rover ?x ?y)
        (mission ?x)
        (objectives ?x ?y ?z)
    )

    ; -------------------------------
    ; Actions
    ; -------------------------------

    ; EXAMPLE

    ; (:action action-template
    ;     :parameters (?p - parameter_type)
    ;     :precondition (and
    ;         (one_arity_predicate ?p)
    ;     )
    ;     :effect 
    ;     (and 
    ;         (no_arity_predicate)
    ;         (not (one_arity_predicate ?p))
    ;     )
    ; )

    (:action move_rover
        :parameters (?r ?wp ?x)
        :precondition (and (rover_pos ?r ?x) (surface_loc_links ?x ?wp))
        :effect (and (rover_pos ?r ?wp)
            (not (rover_pos ?r ?x))
        )
    )
)