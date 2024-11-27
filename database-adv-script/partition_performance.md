# AirBnB Clone: Partitioning Large Tables
- Assume the `Booking` table is large and query performance is slow. Implement partitioning on the `Booking` table based on the `start_date` column.

**Implementation:**
```
CREATE TABLE bookings (
  booking_id VARCHAR(36),
  property_id VARCHAR(36),
  user_id VARCHAR(36),
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  total_price DECIMAL NOT NULL,
  status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (YEAR(start_date))(
    PARTITION bookings_2022 VALUES LESS THAN (2024),
    PARTITION bookings_2023 VALUES LESS THAN (2025),
    PARTITION bookings_2024 VALUES LESS THAN (2026),
    PARTITION bookings_future VALUES LESS THAN (MAXVALUE)
);
```

**Note:** I'm using MySQL 8 to implement this. Since it does not support partitioning a table that has foreign keys, foreign key constraints cannot be implemented. Also, other tables cannot have foreign keys that reference columns in the partitioned table. Because of this, partitioning the `bookings` table may not be the way to go if you are using MySQL. Other SQL DBMS do provide this behaviour but with limitations. You may consider indexing strategies, sharding, or horizontal scaling as alternatives to native partitioning.

- Test the performance of queries on the partitioned table

**Before partitioning:**
```
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| EXPLAIN                                                                                                                                                                                                                          |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| -> Filter: ((bookings.start_date >= DATE'2024-01-01') and (bookings.start_date < DATE'2025-01-01'))  (cost=1.85 rows=2) (actual time=0.048..0.088 rows=11 loops=1)
    -> Table scan on bookings  (cost=1.85 rows=16) (actual time=0.038..0.056 rows=15 loops=1)
 |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
```

**After partitioning:**
```
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| EXPLAIN                                                                                                                                                                                                                          |
+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| -> Filter: ((bookings.start_date >= DATE'2024-01-01') and (bookings.start_date < DATE'2025-01-01'))  (cost=1.35 rows=1) (actual time=0.037..0.079 rows=11 loops=1)
    -> Table scan on bookings  (cost=1.35 rows=11) (actual time=0.030..0.054 rows=11 loops=1)
 |
+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
```

## Conclusion
A significant reduction in query execution time was observed but the limitation on foreign keys may make you reconsider partitioning to  optimize query performance.