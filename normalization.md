# Normalizaing the Database
## Normalization Steps
1. First Normal Form (1NF):
    - [x] Ensure that all attributes in the tables are atomic (cannot be further divided).
    - [x] Eliminate any repeating groups or arrays by creating separate tables.
    - [x] Ensure that there are no multi-valued attributes.

2. Second Normal Form (2NF):
    - [x] Ensure that the table is in 1NF.
    - [x] Identify any partial dependencies, where a non-prime attribute (an attribute that is not part of the primary key) depends on only a part of the primary key.
    - [x] Create separate tables for the partial dependencies, and establish the appropriate foreign key relationships.

3. Third Normal Form (3NF):
    - [x] Ensure that the table is in 2NF.
    - [x] Identify any transitive dependencies, where a non-prime attribute depends on another non-prime attribute.
    - [x] Create separate tables for the transitive dependencies, and establish the appropriate foreign key relationships.

## Specific Observations:
- Users Table:
    Each field (like `first_name`, `email`, etc.) directly depends on `user_id`.
    The `role` attribute is an enum and doesn't violate 3NF.
-Properties Table:
    All fields depend on `property_id`. `host_id` links to the `users` table, ensuring no redundant data storage.
- Reviews Table:
    - The attributes depend directly on `review_id`, and foreign keys (`property_id` and `user_id`) properly reference other tables.
- Bookings Table:
    - All non-key attributes depend on `booking_id`. Status and dates are relevant to a specific booking, maintaining normalization.
- Payments Table:
    - The table ensures that each payment links to a specific booking using `booking_id`, preventing redundancy.
Messages Table:
    - Sender and recipient relationships are normalized, ensuring each message is linked through foreign keys.