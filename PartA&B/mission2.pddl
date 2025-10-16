(define (problem lunar-mission-2)
    (:domain lunar)

    (:objects
        l1 - lander
        r1 - rover
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
        (surface_loc_links wp1 wp2)
        (surface_loc_links wp2 wp1)
        (surface_loc_links wp2 wp3)
        (surface_loc_links wp3 wp5)
        (surface_loc_links wp5 wp3)
        (surface_loc_links wp5 wp6)
        (surface_loc_links wp6 wp4)
        (surface_loc_links wp4 wp2)
        (surface_loc_links wp2 wp4)
        
        (lander_rover l1 r1)
        (lander_rover l2 r2)
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
            ;; Both landers must be deployed
            (deployed_l l1)
            (deployed_l l2)
            ;; task locations
            (image_at wp3)
            (scan_at wp4)
            (image_at wp2)
            (scan_at wp6)
            (sample_location wp5)
            (sample_location wp1)
            ;;Collected at
            (image_collected l1)
            (scan_collected l1)
            (image_collected l2)
            (scan_collected l2)
            (sample_collected l1)
            (sample_collected l2)
        )
    )
)