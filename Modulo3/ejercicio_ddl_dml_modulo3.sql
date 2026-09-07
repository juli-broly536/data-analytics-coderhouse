DROP TABLE IF EXISTS inventario;

CREATE TABLE inventario(
	id_producto int primary key,   
    nombre_producto varchar(100),
    categoria varchar(50),
    precio_unitario decimal(10,2),
    stock_actual int,
    stock_minimo int,
    fecha_ingreso date,
    activo tinyint
);

insert into inventario (id_producto, nombre_producto, categoria, precio_unitario, stock_actual, stock_minimo, fecha_ingreso, activo)
values 
(1, "Laptop Pro 15", "Computacion", 1200.00, 15, 3, "2024-01-10", 1),
(2, "Mouse Inalámbrico", "Accesoriors", 28.00, 80, 10, "2024-01-10", 1),
(3, "Monitor 4K 27", "Computacion", 450.00, 12, 2, "2024-01-15", 1),
(4, "Teclado Mecánico", "Accesorios", 95.00, 40, 5, "2024-01-15", 1),
(5, "Laptop Basic 14", "Computacion", 650.00, 20, 3, "2024-02-01", 1),
(6, "Auriculares BT Pro", "Audio", 120.00, 35, 5, "2024-02-01", 1),
(7, "Hub USB-C 7 puertos", "Accesorios", 45.00, 60, 10, "2024-02-10", 1),
(8, "Webcam HD 1080p", "Accesorios", 85.00, 25, 5, "2024-02-10", 1),
(9, "SSD Externo 1TB", "Almacenamiento", 130.00, 18, 3, "2024-03-01", 1),
(10, "Parlante Bluetooth", "Audio", 60.00, 45, 8, "2024-03-01", 1);

update inventario set stock_actual = stock_actual - 3 where id_producto = 1;
update inventario set stock_actual = stock_actual - 12 where id_producto = 2;
update inventario set stock_actual = stock_actual - 5 where id_producto = 6;

update inventario set activo = 0 where id_producto = 8;

SELECT * FROM inventario;
