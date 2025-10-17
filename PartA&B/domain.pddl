(define (domain lunar)
    (:requirements :strips :typing)

    ;; -------------------------------
    ;; Types
    ;; -------------------------------
    (:types
        lander rover waypoint
    )

    ;; -------------------------------
    ;; Predicates
    ;; -------------------------------
    (:predicates
        (rover_pos ?r - rover ?wp - waypoint)
        (surface_loc_links ?x - waypoint ?y - waypoint)
        (image_stored ?r - rover)
        (scan_stored ?r - rover)
        (physical_sample ?r - rover)
        (sample_location ?wp - waypoint)
        (sample_collected ?l - lander)
        (lander_rover ?l - lander ?r - rover)
        (lander_pos ?l - lander ?wp - waypoint)
        (image_collected ?l - lander)
        (scan_collected ?l - lander)
        (scan_at ?wp - waypoint)
        (image_at ?wp - waypoint)
        (deployed_l ?l - lander)
        (deployed_r ?r - rover)
        (available ?wp - waypoint)
    )

    ;; -------------------------------
    ;; Actions
    ;; -------------------------------

    (:action deploy_lander
        :parameters (?l - lander ?wp - waypoint)
        :precondition (and (not (deployed_l ?l)) (available ?wp))
        :effect (and (lander_pos ?l ?wp) (deployed_l ?l) (not (available ?wp)))
    )

    (:action deploy_rover
        :parameters (?r - rover ?l - lander ?wp - waypoint)
        :precondition (and (lander_pos ?l ?wp) (lander_rover ?l ?r) (not (deployed_r ?r)) (deployed_l ?l))
        :effect (and (rover_pos ?r ?wp) (deployed_r ?r))
    )

    (:action move_rover
        :parameters (?r - rover ?from - waypoint ?to - waypoint)
        :precondition (and (deployed_r ?r) (rover_pos ?r ?from) (surface_loc_links ?from ?to))
        :effect (and (rover_pos ?r ?to) (not (rover_pos ?r ?from)))
    )

    (:action take_picture
        :parameters (?r - rover ?wp - waypoint)
        :precondition (and (rover_pos ?r ?wp))
        :effect (and (image_stored ?r)(image_at ?wp))
    )

    (:action use_radar
        :parameters (?r - rover ?wp - waypoint)
        :precondition (and (rover_pos ?r ?wp) )
        :effect (and (scan_stored ?r)(scan_at ?wp))
    )

    (:action take_sample
        :parameters (?r - rover ?wp - waypoint)
        :precondition (and (rover_pos ?r ?wp) (not (physical_sample ?r)) )
        :effect (and (physical_sample ?r)(sample_location ?wp))
    )

    (:action store_sample
        :parameters (?r - rover ?wp - waypoint ?l - lander)
        :precondition (and (rover_pos ?r ?wp) (physical_sample ?r) (not (sample_collected ?l)) (lander_rover ?l ?r) (lander_pos ?l ?wp) (deployed_l ?l))
        :effect (and (sample_collected ?l) (not (physical_sample ?r)))
    )

    (:action transmit_image
        :parameters (?r - rover ?wp - waypoint ?l - lander)
        :precondition (and (rover_pos ?r ?wp) (image_stored ?r) (lander_pos ?l ?wp) (deployed_l ?l) (lander_rover ?l ?r))
        :effect (and (image_collected ?l) (not (image_stored ?r)))
    )

    (:action transmit_scan
        :parameters (?r - rover ?wp - waypoint ?l - lander)
        :precondition (and (rover_pos ?r ?wp) (scan_stored ?r) (lander_pos ?l ?wp) (deployed_l ?l) (lander_rover ?l ?r))
        :effect (and (scan_collected ?l) (not (scan_stored ?r)))
    )
)