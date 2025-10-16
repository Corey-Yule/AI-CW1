(define (problem lunar-mission-3)
    (:domain lunar-extended)

    (:objects
        l1 - lander
        r1 - rover
        Alice - human
        Bob - human
        docking_l1 - docking_bay
        control_l1 - c_room
        docking_l2 - docking_bay
        control_l2 - c_room
        l2 - lander
        r2 - rover
        wp1 - waypoint
        wp2 - waypoint
        wp3 - waypoint
        wp4 - waypoint
        wp5 - waypoint
        wp6 - waypoint
    )

    (:init
        ;; Surface navigation
        (surface_loc_links wp1 wp2)
        (surface_loc_links wp2 wp1)
        (surface_loc_links wp2 wp3)
        (surface_loc_links wp3 wp5)
        (surface_loc_links wp5 wp3)
        (surface_loc_links wp5 wp6)
        (surface_loc_links wp6 wp4)
        (surface_loc_links wp4 wp2)
        (surface_loc_links wp2 wp4)

        ;; Lander 1 rooms
        (room_lander docking_l1 l1)
        (room_lander control_l1 l1)
        (room_link docking_l1 control_l1)
        (room_link control_l1 docking_l1)

        ;; Lander 2 rooms
        (room_lander docking_l2 l2)
        (room_lander control_l2 l2)
        (room_link docking_l2 control_l2)
        (room_link control_l2 docking_l2)

        ;; Human assignments and positions
        (human_lander Alice l1)
        (human_pos Alice docking_l1)
        (human_lander Bob l2)
        (human_pos Bob control_l2)

        ;; Rover-lander associations
        (lander_rover l1 r1)
        (lander_rover l2 r2)

        ;; Initial deployments (l1 and r1 already deployed)
        (lander_pos l1 wp2)
        (rover_pos r1 wp2)
        (deployed_l l1)
        (deployed_r r1)

        ;; Available waypoints for l2 deployment
        (available wp1)
        (available wp3)
        (available wp4)
        (available wp5)
        (available wp6)
    )

    (:goal
        (and
            ;;Deployments
            (deployed_l l1)
            (deployed_l l2)

            ;; Mission objectives
            (image_at wp3)
            (scan_at wp4)
            (image_at wp2)
            (scan_at wp6)
            (sample_location wp5)
            (sample_location wp1)

            (image_collected l1)
            (scan_collected l1)
            (image_collected l2)
            (scan_collected l2)
            (sample_collected l1)
            (sample_collected l2)
        )
    )
)