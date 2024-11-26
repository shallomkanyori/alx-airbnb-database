# AirBnB Clone: Implementing Indexes for Optimization

I observed that the columns `property_id` in the `reviews` table and `user_id` in the `bookings` table were often used in WHERE, JOIN and ORDER BY clauses. However, after implementing indexes on these columns and measuring the query performance, I found that the indexes seemed to slow down query execution time as below:

```
EXPLAIN ANALYZE 
SELECT property_id, AVG(rating) 
FROM reviews 
GROUP BY property_id;

-- Create index on property_id column in reviews table
CREATE INDEX reviews_property_id_index ON reviews(property_id);

EXPLAIN ANALYZE 
SELECT property_id, AVG(rating) 
FROM reviews 
GROUP BY property_id;
```
Output
```
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| EXPLAIN                                                                                                                                                                                                             |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| -> Group aggregate: avg(reviews.rating)  (cost=1.85 rows=8) (actual time=0.044..0.056 rows=2 loops=1)
    -> Index scan on reviews using property_id  (cost=1.05 rows=8) (actual time=0.031..0.040 rows=8 loops=1)
 |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| EXPLAIN                                                                                                                                                                                                                           |
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| -> Group aggregate: avg(reviews.rating)  (cost=1.85 rows=8) (actual time=0.088..0.096 rows=2 loops=1)
    -> Index scan on reviews using reviews_property_id_index  (cost=1.05 rows=8) (actual time=0.074..0.080 rows=8 loops=1)
 |
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
```

The execution time is slightly slower after adding the index, which is unexpected. This could be due to:
- Small dataset
- Initial index creation overhead
- Caching effects
- Minimal performance impact for this specific query

I will further experiment to discover what is causing this.