(define (domain lunar)
    (:requirements :strips :typing)

    ; -------------------------------
    ; Types
    ; -------------------------------

    (:types
        lander rover waypoint

    ; -------------------------------
    ; Predicates
    ; -------------------------------

    (:predicates
        (rover_pos ?x ?y)
        (surface_loc_links ?x ?y)
        (image_stored ?wp ?r )
        (scan_stored ?wp ?r )
        (physical_sample)
        (lander_rover ?x ?y)
        (lander_pos ?x ?y)
        (mission ?x)
        (objectives ?x ?y ?z)
    )

    ; -------------------------------
    ; Actions
    ; -------------------------------

    (:action deploy_lander
        :parameters (?l - lander ?wp - waypoint ?r - rover)
        :precondition (and (not(lander_pos ?l ?wp)) (not(rover_pos ?r ?wp)))
        :effect (and (lander_pos ?l ?wp))
    )

    (:action deploy_rover
        :parameters (?r - rover ?l -lander ?wp - waypoint)
        :precondition (and (lander_pos ?l ?wp) (not(rover_pos ?r ?wp)) (lander_rover ?l ?r))
        :effect (and (rover_pos ?r ?wp))
    )

    (:action move_rover
        :parameters (?r - rover ?wp - waypoint ?x - waypoint)
        :precondition (and (rover_pos ?r ?x) (surface_loc_links ?x ?wp))
        :effect (and (rover_pos ?r ?wp)
            (not (rover_pos ?r ?x))
        )
    )

    (:action take_picture
        :parameters (?r - rover ?wp - waypoint ?x - waypoint)
        :precondition (and (rover_pos ?r ?wp) (not(image_stored ?wp ?r)) (not(scan_stored ?wp ?r)) (not(image_stored ?x ?r)) (not(scan_stored ?x ?r)))
        :effect (and (image_stored ?wp ?r))
    )

    (:action use_radar
        :parameters (?r - rover ?wp - waypoint ?x - waypoint)
        :precondition (and (rover_pos ?r ?wp) (not(image_stored ?wp ?r)) (not(scan_stored ?wp ?r)) (not(image_stored ?x ?r)) (not(scan_stored ?x ?r)))
        :effect (and (scan_stored ?wp ?r))
    )

)