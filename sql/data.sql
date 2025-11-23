INSERT INTO supplier (name, status, createdate)
VALUES
('TechPro', 'ACTIVE', NOW()),
('AudioWorld', 'ACTIVE', NOW());

INSERT INTO consumer (name, address, phone)
VALUES
('Aruzhan S.', 'Almaty, Dostyk ave 55', '87001234567'),
('Timur K.', 'Astana, Turan 12', '87003456789');

INSERT INTO supplier_staff (supplier_id, role, name, phone)
VALUES
(1, 'Manager', 'Aidos B.', '87172223311'),
(1, 'Support', 'Dana B.', '87172223322'),
(2, 'Manager', 'Miras T.', '87273453412');

INSERT INTO product (supplier_id, name, price, stock, unit)
VALUES
(1, 'Tiger T7 Bluetooth Headphones', 120.00, 50, 'pcs'),
(1, 'DD-027 In-Ear Headphones', 80.00, 100, 'pcs'),
(2, 'Mr. 1022 Deep Bass Earbuds', 60.00, 200, 'pcs');

INSERT INTO supplier_consumer_link (supplier_id, consumer_id, status, approveDate)
VALUES
(1, 1, 'APPROVED', NOW()),
(1, 2, 'PENDING', NOW()),
(2, 1, 'APPROVED', NOW());

INSERT INTO "order" (consumer_id, supplier_id, status, createdate)
VALUES
(1, 1, 'NEW', NOW()),
(1, 2, 'NEW', NOW()),
(2, 1, 'NEW', NOW());

INSERT INTO order_item (order_id, product_id, quantity, price)
VALUES
(1, 1, 1, 120.00),
(1, 2, 2, 80.00),
(2, 3, 1, 60.00);

INSERT INTO complaint (order_id, staff_id, description, status)
VALUES
(1, 1, 'Headphones arrived damaged', 'OPEN'),
(2, 2, 'Package delayed', 'RESOLVED');

INSERT INTO chat_message (link_id, staff_id, consumer_id, content)
VALUES
(1, 1, 1, 'Hello, I want to check my order status'),
(1, 1, 1, 'Your order was shipped today!'),
(2, 2, 2, 'When will my headphones arrive?');


INSERT INTO incident_log (order_id, status, createdate)
VALUES
(1, 'CREATED', NOW()),
(1, 'RESOLVED', NOW()),
(2, 'CREATED', NOW());

