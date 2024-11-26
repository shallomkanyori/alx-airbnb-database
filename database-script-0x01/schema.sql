-- Create the users table
CREATE TABLE users (
  user_id uuid PRIMARY KEY NOT NULL,
  first_name VARCHAR NOT NULL,
  last_name VARCHAR NOT NULL,
  email VARCHAR UNIQUE NOT NULL indexed,
  password VARCHAR(100) NOT NULL,
  phone_number VARCHAR,
  role ENUM('user', 'guest', 'host', 'admin') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create index on email column in users table
CREATE INDEX email_index ON users(email);

-- Create the properties table  
CREATE TABLE properties (
  property_id uuid PRIMARY KEY NOT NULL,
  FOREIGN KEY (host_id) REFERENCES users(user_id),
  name VARCHAR NOT NULL,
  description TEXT NOT NULL,
  location VARCHAR NOT NULL,
  price_per_night DECIMAL NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the bookings table
CREATE TABLE bookings (
  booking_id uuid PRIMARY KEY NOT NULL,
  FOREIGN KEY (property_id) REFERENCES properties(property_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  total_price DECIMAL NOT NULL,
  status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create index on property_id column in bookings table
CREATE INDEX property_id_index ON bookings(property_id);

-- Create the reviews table
CREATE TABLE reviews (
  review_id uuid PRIMARY KEY,
  FOREIGN KEY (property_id) REFERENCES properties(property_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  rating INT CHECK (rating >= 1 AND rating <= 5) NOT NULL,
  comment TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the payments table
CREATE TABLE payments (
  payment_id uuid PRIMARY KEY NOT NULL,
  FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
  amount DECIMAL NOT NULL,
  payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL
);

-- Create index on booking_id column in payments table
CREATE INDEX booking_id_index ON payments(booking_id);

--Create the messages table
CREATE TABLE messages (
  message_id uuid PRIMARY KEY NOT NULL,
  FOREIGN KEY (sender_id) REFERENCES users(user_id),
  FOREIGN KEY (recipient_id) REFERENCES users(user_id),
  message_body TEXT NOT NULL,
  sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);