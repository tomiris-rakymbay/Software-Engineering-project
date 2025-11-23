SELECT p.product_id,
       p.name,
       p.price,
       p.stock,
       p.unit
FROM   product p
WHERE  p.supplier_id = 1        
ORDER BY p.name;


SELECT scl.link_id,
       s.supplier_id,
       s.name        AS supplier_name,
       scl.status,
       scl.approvedate
FROM   supplier_consumer_link scl
JOIN   supplier s ON s.supplier_id = scl.supplier_id
WHERE  scl.consumer_id = 1;    


SELECT  o.order_id,
        o.supplier_id,
        s.name      AS supplier_name,
        o.status,
        o.createdate
FROM    "order" o
JOIN    supplier s ON s.supplier_id = o.supplier_id
WHERE   o.consumer_id = 1
ORDER BY o.createdate DESC;

SELECT  o.order_id,
        o.createdate,
        o.status,
        c.name       AS consumer_name,
        s.name       AS supplier_name,
        oi.product_id,
        p.name       AS product_name,
        oi.quantity,
        oi.price,
        (oi.quantity * oi.price) AS line_total
FROM    "order" o
JOIN    consumer c  ON c.consumer_id  = o.consumer_id
JOIN    supplier s  ON s.supplier_id  = o.supplier_id
JOIN    order_item oi ON oi.order_id  = o.order_id
JOIN    product p  ON p.product_id    = oi.product_id
WHERE   o.order_id = 1
ORDER BY oi.order_item_id;

SELECT  cp.complaint_id,
        cp.status,
        cp.description,
        cp.order_id,
        o.createdate AS order_date,
        cs.name      AS consumer_name,
        st.name      AS staff_name
FROM    complaint cp
JOIN    "order" o       ON o.order_id       = cp.order_id
JOIN    consumer cs     ON cs.consumer_id   = o.consumer_id
LEFT JOIN supplier_staff st ON st.staff_id  = cp.staff_id
WHERE   o.supplier_id = 1
AND     cp.status IN ('OPEN','IN_PROGRESS')
ORDER BY cp.complaint_id;

SELECT  cm.message_id,
        cm.created_at,
        cm.consumer_id,
        cm.staff_id,
        cm.content
FROM    chat_message cm
WHERE   cm.link_id = 1
ORDER BY cm.created_at;

SELECT  il.incident_id,
        il.order_id,
        il.status,
        il.createdate
FROM    incident_log il
WHERE   il.order_id = 1
ORDER BY il.createdate;


SELECT  s.supplier_id,
        s.name AS supplier_name,
        o.status,
        COUNT(*) AS orders_count
FROM    "order" o
JOIN    supplier s ON s.supplier_id = o.supplier_id
GROUP BY s.supplier_id, s.name, o.status
ORDER BY s.supplier_id, o.status;

SELECT  p.product_id,
        p.name,
        SUM(oi.quantity) AS total_qty,
        SUM(oi.quantity * oi.price) AS total_revenue
FROM    order_item oi
JOIN    product p ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name
ORDER BY total_qty DESC
LIMIT 10;

SELECT  cm.message_id,
        cm.created_at,
        cm.content,
        s.name AS supplier_name,
        st.name AS staff_name
FROM    chat_message cm
JOIN    supplier_consumer_link scl ON scl.link_id = cm.link_id
JOIN    supplier s ON s.supplier_id = scl.supplier_id
LEFT JOIN supplier_staff st ON st.staff_id = cm.staff_id
WHERE   cm.consumer_id = 1
ORDER BY cm.created_at;


UPDATE "order"
SET    status = 'SHIPPED'
WHERE  order_id = 1;


SELECT  p.product_id,
        p.name,
        p.stock,
        p.unit
FROM    product p
WHERE   p.product_id = 1;


