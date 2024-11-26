-- Retrieves all bookings along with the user details, property details, and payment details
SELECT *
  FROM bookings AS b
  INNER JOIN users AS u ON b.user_id = u.user_id
  INNER JOIN properties AS p ON b.property_id = p.property_id
  INNER JOIN payments AS pay ON b.booking_id = pay.booking_id;

-- Analyze the performance of the query
EXPLAIN ANALYZE SELECT *
                  FROM bookings AS b
                 INNER JOIN users AS u ON b.user_id = u.user_id
                 INNER JOIN properties AS p ON b.property_id = p.property_id
                 INNER JOIN payments AS pay ON b.booking_id = pay.booking_id;

--OPTIMIZED QUERY
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

-- Analyze the performance of the query
EXPLAIN ANALYZE SELECT 
    b.booking_id, b.start_date, b.end_date, b.total_price, b.status,
    u.first_name, u.last_name, u.email,
    p.name AS property_name, p.location, p.price_per_night,
    pay.amount, pay.payment_date, pay.payment_method
FROM bookings AS b
INNER JOIN users AS u ON b.user_id = u.user_id
INNER JOIN properties AS p ON b.property_id = p.property_id
INNER JOIN payments AS pay ON b.booking_id = pay.booking_id;