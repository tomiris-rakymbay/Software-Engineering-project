CREATE TABLE consumer (
    consumer_id SERIAL PRIMARY KEY,
    name        VARCHAR(255) NOT NULL,
    address     VARCHAR(255),
    phone       VARCHAR(50)
);
CREATE TABLE supplier (
    supplier_id SERIAL PRIMARY KEY,
    name        VARCHAR(255) NOT NULL,
    status      VARCHAR(50) NOT NULL,
    create_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE supplier_consumer_link (
    link_id     SERIAL PRIMARY KEY,
    supplier_id INTEGER NOT NULL,
    consumer_id INTEGER NOT NULL,
    status      VARCHAR(50) NOT NULL,
    approveDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_link_supplier
        FOREIGN KEY (supplier_id)
        REFERENCES supplier(supplier_id)
        ON UPDATE CASCADE ON DELETE CASCADE,

    CONSTRAINT fk_link_consumer
        FOREIGN KEY (consumer_id)
        REFERENCES consumer(consumer_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE supplier_staff (
    staff_id    SERIAL PRIMARY KEY,
    supplier_id INTEGER NOT NULL,
    role        VARCHAR(100) NOT NULL,
    name        VARCHAR(255),
    phone       VARCHAR(50),

    CONSTRAINT fk_staff_supplier
        FOREIGN KEY (supplier_id)
        REFERENCES supplier(supplier_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE product (
    product_id  SERIAL PRIMARY KEY,
    supplier_id INTEGER NOT NULL,
    name        VARCHAR(255) NOT NULL,
    price       NUMERIC(10,2) NOT NULL,
    stock       INTEGER NOT NULL,
    unit        VARCHAR(20),

    CONSTRAINT fk_product_supplier
        FOREIGN KEY (supplier_id)
        REFERENCES supplier(supplier_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE "order" (
    order_id    SERIAL PRIMARY KEY,
    consumer_id INTEGER NOT NULL,
    supplier_id INTEGER NOT NULL,
    status      VARCHAR(50) NOT NULL,
    createDate  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_order_consumer
        FOREIGN KEY (consumer_id)
        REFERENCES consumer(consumer_id)
        ON UPDATE CASCADE ON DELETE CASCADE,

    CONSTRAINT fk_order_supplier
        FOREIGN KEY (supplier_id)
        REFERENCES supplier(supplier_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE order_item (
    orderItem_id SERIAL PRIMARY KEY,
    order_id     INTEGER NOT NULL,
    product_id   INTEGER NOT NULL,
    quantity     INTEGER NOT NULL,
    price        NUMERIC(10,2),

    CONSTRAINT fk_item_order
        FOREIGN KEY (order_id)
        REFERENCES "order"(order_id)
        ON UPDATE CASCADE ON DELETE CASCADE,

    CONSTRAINT fk_item_product
        FOREIGN KEY (product_id)
        REFERENCES product(product_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE complaint (
    complaint_id SERIAL PRIMARY KEY,
    order_id     INTEGER NOT NULL,
    staff_id     INTEGER NOT NULL,
    description  TEXT NOT NULL,
    status       VARCHAR(50),

    CONSTRAINT fk_complaint_order
        FOREIGN KEY (order_id)
        REFERENCES "order"(order_id)
        ON UPDATE CASCADE ON DELETE CASCADE,

    CONSTRAINT fk_complaint_staff
        FOREIGN KEY (staff_id)
        REFERENCES supplier_staff(staff_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- ============================
-- 9. CHAT MESSAGE
-- ============================
CREATE TABLE chat_message (
    message_id  SERIAL PRIMARY KEY,
    link_id     INTEGER NOT NULL,
    staff_id    INTEGER,
    consumer_id INTEGER,
    content     TEXT NOT NULL,
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_chat_link
        FOREIGN KEY (link_id)
        REFERENCES supplier_consumer_link(link_id)
        ON UPDATE CASCADE ON DELETE CASCADE,

    CONSTRAINT fk_chat_staff
        FOREIGN KEY (staff_id)
        REFERENCES supplier_staff(staff_id)
        ON UPDATE CASCADE ON DELETE SET NULL,

    CONSTRAINT fk_chat_consumer
        FOREIGN KEY (consumer_id)
        REFERENCES consumer(consumer_id)
        ON UPDATE CASCADE ON DELETE SET NULL
);

-- ============================
-- 10. INCIDENT LOG
-- ============================
CREATE TABLE incident_log (
    incident_id SERIAL PRIMARY KEY,
    order_id    INTEGER NOT NULL,
    status      VARCHAR(50),
    createDate  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_incident_order
        FOREIGN KEY (order_id)
        REFERENCES "order"(order_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);
