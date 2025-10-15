(define (domain lunar-extended)
    (:requirements :strips :typing)

    ; -------------------------------
    ; Types
    ; -------------------------------

    (:types
        lander rover human waypoint
        room
        c_room docking_bay - room
    )
    ; -------------------------------
    ; Predicates
    ; -------------------------------

    (:predicates
        (rover_pos ?r ?wp)
        (surface_loc_links ?x ?y)
        (image_stored ?wp ?r)
        (scan_stored ?wp ?r)
        (physical_sample ?r)
        (sample_location ?wp)
        (sample_collected ?l)
        (lander_rover ?l ?r)
        (lander_pos ?l ?wp)
        (image_collected ?l)
        (scan_collected ?l)
        (scan_at ?wp)
        (image_at ?wp)
        (human_lander ?h ?l)
        (human_pos ?h - human ?room)
        (room_lander ?room ?lander)
        (room_link ?r1 - room ?r2 - room)
    )

    ; -------------------------------
    ; Actions
    ; -------------------------------

    (:action deploy_lander
        :parameters (?l - lander ?wp - waypoint ?r - rover)
        :precondition(and (not(lander_pos ?l ?wp)) (not(rover_pos ?r ?wp)))
        :effect (and (lander_pos ?l ?wp))
    )

    (:action deploy_rover
        :parameters (?r - rover ?l -lander ?wp - waypoint ?h - human ?droom - docking_bay)
        :precondition(and (lander_pos ?l ?wp) (not(rover_pos ?r ?wp)) (lander_rover ?l ?r)(human_pos ?h ?droom))
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
        :precondition (and (rover_pos ?r ?wp) (image_at ?wp) (not(image_stored ?wp ?r)) (not(scan_stored ?wp ?r)) (not(image_stored ?x ?r)) (not(scan_stored ?x ?r)))
        :effect (and (image_stored ?wp ?r))
    )

    (:action use_radar
        :parameters (?r - rover ?wp - waypoint ?x - waypoint)
        :precondition (and (rover_pos ?r ?wp) (scan_at ?wp) (not(image_stored ?wp ?r)) (not(scan_stored ?wp ?r)) (not(image_stored ?x ?r)) (not(scan_stored ?x ?r)))
        :effect (and (scan_stored ?wp ?r))
    )

    (:action take_sample
        :parameters (?r - rover ?wp - waypoint ?h - human ?droom - docking_bay)
        :precondition (and (rover_pos ?r ?wp)
            (not(physical_sample ?r))(sample_location ?wp)(human_pos ?h ?droom))
        :effect (and (physical_sample ?r) (not(sample_location ?wp)))
    )

    (:action store_sample
        :parameters (?r - rover ?wp - waypoint ?l - lander ?droom - docking_bay ?h - human)
        :precondition (and (rover_pos ?r ?wp)(physical_sample ?r)(human_pos ?h ?droom)
            (not(sample_collected ?l))(lander_rover ?l ?r)(lander_pos ?l ?wp)(human_pos ?h ?droom))
        :effect (and (sample_collected ?l) (not(physical_sample ?r)))
    )

    (:action transmit_image
        :parameters (?r - rover ?wp - waypoint ?l - lander ?croom - c_room ?h - human)
        :precondition (and (rover_pos ?r ?wp)(image_stored ?wp ?r)(lander_pos ?l ?wp)
        (human_pos ?h ?croom))
        :effect (and (image_collected ?l) (not(image_stored ?wp ?r)))
    )

    (:action transmit_scan
        :parameters (?r - rover ?wp - waypoint ?l - lander ?croom - c_room ?h - human)
        :precondition (and (rover_pos ?r ?wp)(scan_stored ?wp ?r)(lander_pos ?l ?wp)
        (human_pos ?h ?croom))
        :effect (and (scan_collected ?l) (not(scan_stored ?wp ?r)))
    )

    (:action assign_human
        :parameters (?h - human ?l - lander)
        :precondition (and (not(human_lander ?h ?l)))
        :effect (and (human_lander ?h ?l))
    )
    (:action docking_bay
        :parameters (?h - human ?l - lander ?droom - docking_bay ?croom - c_room)
        :precondition (and (human_lander ?h ?l)(room_lander ?droom ?l)(room_lander ?croom ?l)
        (human_pos ?h ?croom)(not (human_pos ?h ?droom)))
        :effect (and (human_pos ?h ?droom)(not(human_pos ?h ?croom)))
    )
    (:action control_room
        :parameters (?h - human ?l - lander ?croom - c_room ?droom - docking_bay)
        :precondition (and (human_lander ?h ?l)(room_lander ?droom ?l)(room_lander ?croom ?l)
        (human_pos ?h ?droom)(not (human_pos ?h ?croom)))
        :effect (and (human_pos ?h ?croom)(not (human_pos ?h ?droom)))
    )
)