# AirBnB Clone: Monitor and Refine Database Performance

The most frequently used queries will revolve around user activities such as searching for properties, making bookings, viewing details, managing reviews, and handling payments. Thus a few things can be done to optimize performance.

- Use indexes for frequently filtered columns such as `location`, `start_date` and `end_date`.

    - **Implementation:**
    ```
    EXPLAIN ANALYZE SELECT *
    FROM properties
    WHERE location = 'New York, NY';

    CREATE INDEX location_index on properties(location);

    EXPLAIN ANALYZE SELECT *
    FROM properties
    WHERE location = 'New York, NY';
    ```

    - **Output:**
    ```
    +---------------------------------------------------------------------------------------------------------------+
    | EXPLAIN                                                                                                       |
    +---------------------------------------------------------------------------------------------------------------+
    | -> Filter: (properties.location = 'New York, NY')  (cost=0.45 rows=1) (actual time=0.025..0.028 rows=1 loops=1)
        -> Table scan on properties  (cost=0.45 rows=2) (actual time=0.016..0.020 rows=2 loops=1)
    |
    +---------------------------------------------------------------------------------------------------------------+
    +---------------------------------------------------------------------------------------------------------------+
    | EXPLAIN                                                                                                       |
    +---------------------------------------------------------------------------------------------------------------+
    | -> Index lookup on properties using location_index (location='New York, NY')  (cost=0.35 rows=1) (actual time=0.017..0.021 rows=1 loops=1)
    |
    +---------------------------------------------------------------------------------------------------------------+
    ```
    - A significant improvement is observed in the case of adding an index on the `location` column. Further observation is required to maintain balance between increased write times and reduced read times.

- For aggregations (e.g., ratings or earnings), ensure the necessary columns are indexed to avoid full table scans.
    - Most aggregation use the `[table]_id` colums and most primary and foreign keys are already indexed.

- Consider implementing caching (e.g., with Redis) for heavy queries like property searches or analytics to improve response times.
    - This is something to implement once the database has been set up.
