-- Find all properties where the average rating is greater than 4.0 using a non-correlated subquery
SELECT * FROM properties
  WHERE properties.property_id IN (
    SELECT property_id FROM reviews
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
);

-- Find all users who have made more than 3 bookings using a correlated subquery
SELECT * FROM users
  WHERE users.user_id IN (
    SELECT user_id FROM bookings
    GROUP BY user_id
    HAVING COUNT(*) > 3
);