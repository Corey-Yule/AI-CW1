(define (problem lunar-mission-1)
    (:domain lunar)

    (:objects
        l1 - lander
        r1 - rover
        wp1 - waypoint
        wp2 - waypoint
        wp3 - waypoint
        wp4 - waypoint
        wp5 - waypoint
    )

    (:init
        ;; Surface links
        (surface_loc_links wp1 wp2)
        (surface_loc_links wp2 wp1)
        (surface_loc_links wp1 wp4)
        (surface_loc_links wp4 wp1)
        (surface_loc_links wp2 wp3)
        (surface_loc_links wp3 wp2)
        (surface_loc_links wp3 wp5)
        (surface_loc_links wp5 wp3)
        (surface_loc_links wp4 wp3)
        (surface_loc_links wp3 wp4)
        (surface_loc_links wp5 wp1)
        (surface_loc_links wp1 wp5)

        ;; Rover and lander
        (lander_rover l1 r1)

     
        ;; All waypoints available for landing
        (available wp1)
        (available wp2)
        (available wp3)
        (available wp4)
        (available wp5)
        ;;Has to be here due to physical location
        (sample_location wp1)
    )

    (:goal
        (and
            ;; Lander must be deployed
            (deployed_l l1)
            ;; Task locations
            (image_at wp5)
            (scan_at wp3)

            ;; All mission tasks completed
            (image_collected l1)
            (scan_collected l1)
            (sample_collected l1)
           
        )
    )
)