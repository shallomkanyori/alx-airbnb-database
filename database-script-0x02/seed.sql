-- Seed users
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES 
('076e6319-707f-409a-a711-208073008080', 'John', 'Doe', 'john.doe@example.com', 'hashedpassword123', '1234567890', 'guest', CURRENT_TIMESTAMP),
('92876c19-2bb4-4f2f-8ece-0e6580ab7752', 'Jane', 'Smith', 'jane.smith@example.com', 'hashedpassword456', '0987654321', 'host', CURRENT_TIMESTAMP),
('74979982-a50f-4c47-b003-da77567bb1ad', 'Admin', 'User', 'admin@example.com', 'hashedpassword789', '5551234567', 'admin', CURRENT_TIMESTAMP);

-- Seed properties
INSERT INTO properties (property_id, host_id, name, description, location, price_per_night, created_at)
VALUES 
('98bc898d-8356-4201-a7d5-e7baa30fb81d', '92876c19-2bb4-4f2f-8ece-0e6580ab7752', 'Cozy Apartment', 'A lovely 2-bedroom apartment in the city center.', 'New York, NY', 150.00, CURRENT_TIMESTAMP),
('48e2df87-9803-4388-b97e-594da54a745d', '92876c19-2bb4-4f2f-8ece-0e6580ab7752', 'Beachfront Villa', 'A luxurious villa right on the beach.', 'Miami, FL', 300.00, CURRENT_TIMESTAMP);

-- Seed bookings
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES 
('4a1b13fb-e8c6-43b3-8e21-1453a8923ded', '98bc898d-8356-4201-a7d5-e7baa30fb81d', '076e6319-707f-409a-a711-208073008080', '2024-12-01', '2024-12-05', 600.00, 'confirmed', CURRENT_TIMESTAMP),
('401b61fd-cda8-42c4-af39-1afd3321c2ee', '48e2df87-9803-4388-b97e-594da54a745d', '076e6319-707f-409a-a711-208073008080', '2025-01-10', '2025-01-15', 1500.00, 'pending', CURRENT_TIMESTAMP);

-- Seed reviews
INSERT INTO reviews (review_id, property_id, user_id, rating, comment, created_at)
VALUES 
('7dcacf85-47e4-437b-80a9-94517485f6bc', '98bc898d-8356-4201-a7d5-e7baa30fb81d', '076e6319-707f-409a-a711-208073008080', 5, 'Amazing stay! Very clean and comfortable.', CURRENT_TIMESTAMP),
('e7e9ba35-7373-4e32-8a04-ac5663ba9ede', '48e2df87-9803-4388-b97e-594da54a745d', '076e6319-707f-409a-a711-208073008080', 4, 'Great location, but a bit pricey.', CURRENT_TIMESTAMP);

-- Seed payments
INSERT INTO payments (payment_id, booking_id, amount, payment_date, payment_method)
VALUES 
('f77840f1-c8f8-4bb4-9d26-b5556d729f44', '4a1b13fb-e8c6-43b3-8e21-1453a8923ded', 600.00, CURRENT_TIMESTAMP, 'credit_card'),
('15ab259b-142b-46fb-bc53-75d6959ef8f7', '401b61fd-cda8-42c4-af39-1afd3321c2ee', 750.00, CURRENT_TIMESTAMP, 'paypal');

-- Seed messages
INSERT INTO messages (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES 
('80957173-3300-4f1f-baa2-843b7c6e8c14', '076e6319-707f-409a-a711-208073008080', '92876c19-2bb4-4f2f-8ece-0e6580ab7752', 'Hi! I’m interested in booking your apartment.', CURRENT_TIMESTAMP),
('ee2724ff-e917-4ba2-8346-cd7d6e886c96', '92876c19-2bb4-4f2f-8ece-0e6580ab7752', '076e6319-707f-409a-a711-208073008080', 'Thanks for reaching out! Let me know your dates.', CURRENT_TIMESTAMP);