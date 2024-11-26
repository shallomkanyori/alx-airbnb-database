-- Retrieve all bookings and the respective users who made those bookings
SELECT * FROM bookings
  INNER JOIN users ON bookings.user_id = users.user_id;

-- Retrieve all properties and their reviews including those without reviews
SELECT * FROM properties
  LEFT JOIN reviews ON properties.property_id = reviews.property_id;

-- Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user
SELECT * FROM users
  LEFT JOIN bookings ON users.user_id = bookings.user_id;
UNION
SELECT * FROM users
  RIGHT JOIN bookings ON users.user_id = bookings.user_id;