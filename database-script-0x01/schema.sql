-- Create the users table
CREATE TABLE users (
  user_id VARCHAR(36) PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(100) NOT NULL,
  phone_number VARCHAR(255),
  role ENUM('user', 'guest', 'host', 'admin') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create index on email column in users table
CREATE INDEX email_index ON users(email);

-- Create the properties table  
CREATE TABLE properties (
  property_id VARCHAR(36) PRIMARY KEY,
  host_id VARCHAR(36),
  name VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  location VARCHAR(255) NOT NULL,
  price_per_night DECIMAL NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (host_id) REFERENCES users(user_id)
);

-- Create the bookings table
CREATE TABLE bookings (
  booking_id VARCHAR(36) PRIMARY KEY,
  property_id VARCHAR(36),
  user_id VARCHAR(36),
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  total_price DECIMAL NOT NULL,
  status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES properties(property_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Create index on property_id column in bookings table
CREATE INDEX property_id_index ON bookings(property_id);

-- Create the reviews table
CREATE TABLE reviews (
  review_id VARCHAR(36) PRIMARY KEY,
  property_id VARCHAR(36),
  user_id VARCHAR(36),
  rating INT CHECK (rating >= 1 AND rating <= 5) NOT NULL,
  comment TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES properties(property_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Create the payments table
CREATE TABLE payments (
  payment_id VARCHAR(36) PRIMARY KEY,
  booking_id VARCHAR(36),
  amount DECIMAL NOT NULL,
  payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
  FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

-- Create index on booking_id column in payments table
CREATE INDEX booking_id_index ON payments(booking_id);

-- Create the messages table
CREATE TABLE messages (
  message_id VARCHAR(36) PRIMARY KEY,
  sender_id VARCHAR(36),
  recipient_id VARCHAR(36),
  message_body TEXT NOT NULL,
  sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (sender_id) REFERENCES users(user_id),
  FOREIGN KEY (recipient_id) REFERENCES users(user_id)
);