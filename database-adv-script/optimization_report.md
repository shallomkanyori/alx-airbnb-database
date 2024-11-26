# AirBnB Clone: Optimize Complex Queries

- Write an initial query that retrieves all bookings along with the user details, property details, and payment details.
**Implementation:**
```
SELECT *
  FROM bookings AS b
  INNER JOIN users AS u ON b.user_id = u.user_id
  INNER JOIN properties AS p ON b.property_id = p.property_id
  INNER JOIN payments AS pay ON b.booking_id = pay.booking_id
  WHERE b.start_date >= '2024-01-01' AND b.end_date <= '2024-12-31';
```

- Analyze the query’s performance using EXPLAIN and identify any inefficiencies.
**Implementation:**
```
EXPLAIN ANALYZE SELECT *
                  FROM bookings AS b
                 INNER JOIN users AS u ON b.user_id = u.user_id
                 INNER JOIN properties AS p ON b.property_id = p.property_id
                 INNER JOIN payments AS pay ON b.booking_id = pay.booking_id
                 WHERE b.start_date >= '2024-01-01' AND b.end_date <= '2024-12-31';
```
Output:
```
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| EXPLAIN                                                                                                                                                                                                                          |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| -> Nested loop inner join  (cost=1.43 rows=0) (actual time=0.106..0.120 rows=1 loops=1)
    -> Nested loop inner join  (cost=1.29 rows=0) (actual time=0.094..0.105 rows=1 loops=1)
        -> Nested loop inner join  (cost=1.15 rows=0) (actual time=0.063..0.078 rows=3 loops=1)
            -> Table scan on p  (cost=0.45 rows=2) (actual time=0.012..0.016 rows=2 loops=1)
            -> Filter: ((b.start_date >= DATE'2024-01-01') and (b.end_date <= DATE'2024-12-31') and (b.user_id is not null))  (cost=0.26 rows=0) (actual time=0.020..0.024 rows=2 loops=2)
                -> Index lookup on b using property_id_index (property_id=p.property_id)  (cost=0.26 rows=1) (actual time=0.013..0.017 rows=2 loops=2)
        -> Index lookup on pay using booking_id_index (booking_id=b.booking_id)  (cost=0.50 rows=1) (actual time=0.004..0.005 rows=0 loops=3)
    -> Single-row index lookup on u using PRIMARY (user_id=b.user_id)  (cost=0.50 rows=1) (actual time=0.007..0.007 rows=1 loops=1)
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
INNER JOIN payments AS pay ON b.booking_id = pay.booking_id
WHERE b.start_date >= '2024-01-01' AND b.end_date <= '2024-12-31';
```

- Optimization result
```
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| EXPLAIN                                                                                                                                                                                                                          |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| -> Nested loop inner join  (cost=0.84 rows=0) (actual time=0.089..0.103 rows=1 loops=1)
    -> Nested loop inner join  (cost=0.77 rows=0) (actual time=0.071..0.082 rows=1 loops=1)
        -> Nested loop inner join  (cost=0.70 rows=0) (actual time=0.058..0.066 rows=1 loops=1)
            -> Filter: (pay.booking_id is not null)  (cost=0.35 rows=1) (actual time=0.016..0.024 rows=2 loops=1)
                -> Table scan on pay  (cost=0.35 rows=1) (actual time=0.012..0.017 rows=2 loops=1)
            -> Filter: ((b.start_date >= DATE'2024-01-01') and (b.end_date <= DATE'2024-12-31') and (b.property_id is not null) and (b.user_id is not null))  (cost=0.27 rows=0) (actual time=0.015..0.016 rows=0 loops=2)
                -> Single-row index lookup on b using PRIMARY (booking_id=pay.booking_id)  (cost=0.27 rows=1) (actual time=0.010..0.010 rows=1 loops=2)
        -> Single-row index lookup on p using PRIMARY (property_id=b.property_id)  (cost=0.75 rows=1) (actual time=0.008..0.009 rows=1 loops=1)
    -> Single-row index lookup on u using PRIMARY (user_id=b.user_id)  (cost=0.75 rows=1) (actual time=0.007..0.008 rows=1 loops=1)
 |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
```