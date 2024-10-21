INSERT INTO user_account (name, password, display_name, email, status, role, create_datetime, update_datetime)
VALUES
  ('john_doe', 'password123', 'John Doe', 'john.doe@example.com', 1, 1, NOW(), NOW()),
  ('jane_smith', 'securePass456', 'Jane Smith', 'jane.smith@example.com', 1, 2, NOW(), NOW()),
  ('bob_lee', 'bobPass789', 'Bob Lee', 'bob.lee@example.com', 1, 1, NOW(), NOW()),
  ('alice_wonder', 'alicePass123', 'Alice Wonder', 'alice.wonder@example.com', 1, 2, NOW(), NOW());

INSERT INTO user_ingredients (user_id, name, quantity, uom, expiry_date, create_datetime, update_datetime)
VALUES
  (1, 'Flour', 2.5, 'kg', '2024-12-01', NOW(), NOW()),
  (1, 'Sugar', 1.0, 'kg', '2024-11-15', NOW(), NOW()),
  (2, 'Chicken Breast', 1.2, 'kg', '2024-10-25', NOW(), NOW()),
  (2, 'Curry Powder', 0.1, 'kg', '2024-12-10', NOW(), NOW()),
  (3, 'Beef', 0.8, 'kg', '2024-11-30', NOW(), NOW()),
  (3, 'Tortilla', 0.5, 'kg', '2024-11-20', NOW(), NOW()),
  (4, 'Mozzarella Cheese', 0.4, 'kg', '2024-12-05', NOW(), NOW()),
  (4, 'Bell Peppers', 1.0, 'kg', '2024-10-30', NOW(), NOW());

  
INSERT INTO recipe (creator_id, name, image, description, cookingTimeInSec, difficultyLevel, rating, status, create_datetime, update_datetime, cuisine)
VALUES
  (1, 'Spaghetti Carbonara', 'carbonara.jpg', 'Classic Italian pasta dish', 1200, 2, 4.5, 1, NOW(), NOW(), 'Italian'),
  (2, 'Chicken Tikka Masala', 'tikka_masala.jpg', 'Spicy and flavorful chicken curry', 1800, 3, 4.8, 1, NOW(), NOW(), 'Indian'),
  (3, 'Beef Tacos', 'tacos.jpg', 'Mexican beef tacos with fresh salsa', 900, 2, 4.7, 1, NOW(), NOW(), 'Mexican'),
  (4, 'Vegetarian Pizza', 'veggie_pizza.jpg', 'Pizza topped with fresh vegetables', 1500, 2, 4.4, 1, NOW(), NOW(), 'Italian');

