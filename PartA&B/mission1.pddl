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
        (surface_loc_links wp1 wp2)
        (surface_loc_links wp1 wp4)
        (surface_loc_links wp2 wp3)
        (surface_loc_links wp3 wp5)
        (surface_loc_links wp4 wp3)
        (surface_loc_links wp5 wp1)
        (lander_rover l1 r1)
    )

    (:goal
        (and
            ;tests
            (rover_pos r1 wp2)

        )
    )
)