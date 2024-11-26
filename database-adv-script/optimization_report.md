# AirBnB Clone: Optimize Complex Queries

- Write an initial query that retrieves all bookings along with the user details, property details, and payment details.
**Implementation:**
```
SELECT *
  FROM bookings AS b
  INNER JOIN users AS u ON b.user_id = u.user_id
  INNER JOIN properties AS p ON b.property_id = p.property_id
  INNER JOIN payments AS pay ON b.booking_id = pay.booking_id;
```

- Analyze the query’s performance using EXPLAIN and identify any inefficiencies.
**Implementation:**
```
EXPLAIN ANALYZE SELECT *
                  FROM bookings AS b
                 INNER JOIN users AS u ON b.user_id = u.user_id
                 INNER JOIN properties AS p ON b.property_id = p.property_id
                 INNER JOIN payments AS pay ON b.booking_id = pay.booking_id;
```
Output:
```
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| EXPLAIN                                                                                                                                                                                                                          |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| -> Nested loop inner join  (cost=2.18 rows=1) (actual time=0.068..0.102 rows=2 loops=1)
    -> Nested loop inner join  (cost=2.00 rows=1) (actual time=0.060..0.087 rows=2 loops=1)
        -> Inner hash join (no condition)  (cost=1.10 rows=4) (actual time=0.037..0.044 rows=4 loops=1)
            -> Table scan on p  (cost=0.23 rows=2) (actual time=0.005..0.008 rows=2 loops=1)
            -> Hash
                -> Filter: (pay.booking_id is not null)  (cost=0.45 rows=2) (actual time=0.017..0.022 rows=2 loops=1)
                    -> Table scan on pay  (cost=0.45 rows=2) (actual time=0.009..0.011 rows=2 loops=1)
        -> Filter: ((b.property_id = p.property_id) and (b.user_id is not null))  (cost=0.13 rows=0) (actual time=0.007..0.008 rows=0 loops=4)
            -> Single-row index lookup on b using PRIMARY (booking_id=pay.booking_id)  (cost=0.13 rows=1) (actual time=0.004..0.004 rows=1 loops=4)
    -> Single-row index lookup on u using PRIMARY (user_id=b.user_id)  (cost=0.25 rows=1) (actual time=0.003..0.003 rows=1 loops=2)
 |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
```

- Refactor the query to reduce execution time, such as reducing unnecessary joins or using indexing.
**Implementation:**
```
-- Create index on user_id column in bookings table
CREATE INDEX user_id_index ON bookings(user_id);

-- Specify columns to be selected in the query
SELECT 
    b.booking_id, b.start_date, b.end_date, b.total_price, b.status,
    u.first_name, u.last_name, u.email,
    p.name AS property_name, p.location, p.price_per_night,
    pay.amount, pay.payment_date, pay.payment_method
FROM bookings AS b
INNER JOIN users AS u ON b.user_id = u.user_id
INNER JOIN properties AS p ON b.property_id = p.property_id
INNER JOIN payments AS pay ON b.booking_id = pay.booking_id;
```

- Optimization result
```
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| EXPLAIN                                                                                                                                                                                                                          |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| -> Nested loop inner join  (cost=1.40 rows=1) (actual time=0.043..0.120 rows=2 loops=1)
    -> Nested loop inner join  (cost=1.05 rows=1) (actual time=0.035..0.105 rows=2 loops=1)
        -> Nested loop inner join  (cost=0.70 rows=1) (actual time=0.027..0.088 rows=2 loops=1)
            -> Filter: (pay.booking_id is not null)  (cost=0.35 rows=1) (actual time=0.010..0.015 rows=2 loops=1)
                -> Table scan on pay  (cost=0.35 rows=1) (actual time=0.007..0.010 rows=2 loops=1)
            -> Filter: ((b.property_id is not null) and (b.user_id is not null))  (cost=0.35 rows=1) (actual time=0.009..0.011 rows=1 loops=2)
                -> Single-row index lookup on b using PRIMARY (booking_id=pay.booking_id)  (cost=0.35 rows=1) (actual time=0.007..0.007 rows=1 loops=2)
        -> Single-row index lookup on p using PRIMARY (property_id=b.property_id)  (cost=0.35 rows=1) (actual time=0.004..0.005 rows=1 loops=2)
    -> Single-row index lookup on u using PRIMARY (user_id=b.user_id)  (cost=0.35 rows=1) (actual time=0.003..0.004 rows=1 loops=2)
 |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
```