-- Create index on user_id column in bookings table
CREATE INDEX user_id_index ON bookings(user_id);

-- Get the average rating for each property (before indexing)
EXPLAIN ANALYZE 
SELECT property_id, AVG(rating) 
  FROM reviews 
 GROUP BY property_id;

-- Create index on property_id column in reviews table
CREATE INDEX reviews_property_id_index ON reviews(property_id);

-- Get the average rating for each property (after indexing)
EXPLAIN ANALYZE 
SELECT property_id, AVG(rating) 
  FROM reviews 
 GROUP BY property_id;