(define (domain lunar-extended)
    (:requirements :strips :typing)

    ; -------------------------------
    ; Types
    ; -------------------------------
    (:types
        lander rover human waypoint room
        c_room docking_bay - room
    )

    ; -------------------------------
    ; Predicates
    ; -------------------------------
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
        (human_lander ?h - human ?l - lander)
        (human_pos ?h - human ?room - room)
        (room_lander ?room - room ?lander - lander)
        (room_link ?r1 - room ?r2 - room)
    )

    ; -------------------------------
    ; Actions
    ; -------------------------------

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
        :precondition (and (rover_pos ?r ?wp) (image_at ?wp))
        :effect (and (image_stored ?r))
    )

    (:action use_radar
        :parameters (?r - rover ?wp - waypoint)
        :precondition (and (rover_pos ?r ?wp) (scan_at ?wp))
        :effect (and (scan_stored ?r))
    )

    (:action take_sample
        :parameters (?r - rover ?wp - waypoint ?h - human ?l - lander ?droom - docking_bay)
        :precondition (and 
            (rover_pos ?r ?wp) 
            (not (physical_sample ?r)) 
            (sample_location ?wp)
            (human_pos ?h ?droom)
            (human_lander ?h ?l)
            (lander_rover ?l ?r)
            (room_lander ?droom ?l)
        )
        :effect (and (physical_sample ?r) (not (sample_location ?wp)))
    )

    (:action store_sample
        :parameters (?r - rover ?wp - waypoint ?l - lander ?h - human ?droom - docking_bay)
        :precondition (and 
            (rover_pos ?r ?wp) 
            (physical_sample ?r) 
            (not (sample_collected ?l))
            (lander_rover ?l ?r) 
            (lander_pos ?l ?wp) 
            (deployed_l ?l)
            (human_pos ?h ?droom)
            (human_lander ?h ?l)
            (room_lander ?droom ?l)
        )
        :effect (and (sample_collected ?l) (not (physical_sample ?r)))
    )

    (:action transmit_image
        :parameters (?r - rover ?wp - waypoint ?l - lander ?h - human ?croom - c_room)
        :precondition (and 
            (rover_pos ?r ?wp) 
            (image_stored ?r) 
            (lander_pos ?l ?wp) 
            (deployed_l ?l) 
            (lander_rover ?l ?r)
            (human_pos ?h ?croom)
            (human_lander ?h ?l)
            (room_lander ?croom ?l)
        )
        :effect (and (image_collected ?l) (not (image_stored ?r)))
    )

    (:action transmit_scan
        :parameters (?r - rover ?wp - waypoint ?l - lander ?h - human ?croom - c_room)
        :precondition (and 
            (rover_pos ?r ?wp) 
            (scan_stored ?r) 
            (lander_pos ?l ?wp) 
            (deployed_l ?l) 
            (lander_rover ?l ?r)
            (human_pos ?h ?croom)
            (human_lander ?h ?l)
            (room_lander ?croom ?l)
        )
        :effect (and (scan_collected ?l) (not (scan_stored ?r)))
    )

    (:action assign_human
        :parameters (?h - human ?l - lander)
        :precondition (not (human_lander ?h ?l))
        :effect (human_lander ?h ?l)
    )

    (:action move_to_docking
        :parameters (?h - human ?l - lander ?from - c_room ?to - docking_bay)
        :precondition (and 
            (human_lander ?h ?l)
            (room_lander ?from ?l)
            (room_lander ?to ?l)
            (human_pos ?h ?from)
            (room_link ?from ?to)
        )
        :effect (and 
            (human_pos ?h ?to)
            (not (human_pos ?h ?from))
        )
    )

    (:action move_to_control
        :parameters (?h - human ?l - lander ?from - docking_bay ?to - c_room)
        :precondition (and 
            (human_lander ?h ?l)
            (room_lander ?from ?l)
            (room_lander ?to ?l)
            (human_pos ?h ?from)
            (room_link ?from ?to)
        )
        :effect (and 
            (human_pos ?h ?to)
            (not (human_pos ?h ?from))
        )
    )
)