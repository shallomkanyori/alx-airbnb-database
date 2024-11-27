-- Implement partitioning by year on the bookings table based on the start_date column
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

-- Analyze selecting bookings for the year 2024
EXPLAIN ANALYZE SELECT *
  FROM bookings
 WHERE start_date >= '2024-01-01' AND start_date < '2025-01-01';