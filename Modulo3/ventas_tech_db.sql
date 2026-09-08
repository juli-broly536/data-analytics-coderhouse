-- Ventas_Tech_DB - Script de ventas
-- Autor: Juliano Fayolle
-- Fecha: 8/09/2026

-- SE CREA LA BASE DE DATOS LLAMADA Ventas_Tech_DB
CREATE DATABASE IF NOT EXISTS Ventas_Tech_DB;

-- ACA LE DECIMOS AL MOTOR QUE UTILIZE LA BASE DE DATOS QUE CREAMOS ANTES PARA EJECUTAR TODAS LAS SIGUIENTES SENTENCIAS QUE LE DIMOS
USE Ventas_Tech_DB;

-- SE ELIMINAN LAS TABLAS (ventas, productos, clientes, categorias) SI ES QUE EXISTEN
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;

-- EN ESTE APARTADO COMENZAMOS CON EL SUBLENGUAJE DDL QUE SERIA LA CREACION DE NUESTRA ESTRUCTURA EN NUESTRA BASE DE DATOS
-- TABLA DE CATEGORIAS(tabla de dimension)
CREATE TABLE categorias (
	id_categoria int not null primary key,
    nombre_categoria varchar(50) not null,
    descripcion varchar(200)
);

-- TABLA DE CLIENTES(tabla de dimension)
CREATE TABLE clientes(
	id_cliente int not null primary key,
    nombre varchar(100) not null,
    email varchar(100) unique, -- usamos unique ya que queremos que en la columna email se cargue un dato que sea único y no se repita, porque si hay dos emails iguales podrían generarse inconsistencias en la base de datos
    ciudad varchar(50),
    fecha_registro date not null
);

-- TABLA DE PRODUCTOS(tabla de dimension)
CREATE TABLE productos(
	id_producto int not null primary key,
    nombre_producto varchar(100) not null,
    id_categoria int not null,
    precio decimal(10,2) not null,
    stock int default 0,
    activo tinyint(1) default 1, -- elegimos default 1 porque al cargar un producto nuevo lo lógico es asumir que está disponible para la venta, a menos que se indique explícitamente lo contrario; si el usuario no especifica un valor, se le asigna 1 automáticamente
    foreign key (id_categoria) references categorias(id_categoria)
);

-- TABLA DE VENTAS(tabla de hechos)
CREATE TABLE ventas(
	id_venta int not null primary key,
    id_cliente int not null,
    id_producto int not null,
    cantidad int not null,
    precio_unitario decimal(10,2) not null, -- usamos decimal ya que los precios de los productos pueden no llegar a ser redondos y ademas decimal es mas preciso que float para manejar dinero, evitando errores de redondeo
    fecha_venta date not null,
    foreign key(id_cliente) references clientes(id_cliente),
    foreign key(id_producto) references productos(id_producto)
);

-- AHORA EN ESTA PARTE COMENZAMOS CON EL SUBLENGUAJE DML QUE ES LA MANIPULACION DE LOS DATOS, EN ESTE CASP ESTARIAMOS AGREGANDO ATRIBUTOS A CADA COLUMNA DE CADA TABLA
-- AÑADIMOS DATOS A CADA COLUMNA DE LA TABLA DE CATEGORIAS
INSERT INTO categorias VALUES (1, 'Computación', 'Laptops, PCs y monitores');
INSERT INTO categorias VALUES (2, 'Accesorios', 'Periféricos y complementos');
INSERT INTO categorias VALUES (3, 'Audio', 'Auriculares y parlantes');
INSERT INTO categorias VALUES (4, 'Almacenamiento', 'Discos y memorias');

-- AÑADIMOS DATOS A CADA COLUMNA DE LA TABLA DE CLIENTES
INSERT INTO clientes VALUES (1, 'María López',   'maria@mail.com',   'Buenos Aires', '2024-01-05');
INSERT INTO clientes VALUES (2, 'Carlos Ruiz',   'carlos@mail.com',  'Córdoba',      '2024-01-10');
INSERT INTO clientes VALUES (3, 'Ana Gómez',     'ana@mail.com',     'Rosario',      '2024-02-01');
INSERT INTO clientes VALUES (4, 'Pedro Sanz',    'pedro@mail.com',   'Mendoza',      '2024-02-15');
INSERT INTO clientes VALUES (5, 'Laura Torres',  'laura@mail.com',   'Tucumán',      '2024-03-01');

-- AÑADIMOS DATOS A CADA COLUMNA DE LA TABLA DE PRODUCTOS
INSERT INTO productos VALUES (1, 'Laptop Pro 15',       1, 1200.00, 15, 1);
INSERT INTO productos VALUES (2, 'Mouse Inalámbrico',   2,   28.00, 80, 1);
INSERT INTO productos VALUES (3, 'Monitor 4K 27"',      1,  450.00, 12, 1);
INSERT INTO productos VALUES (4, 'Auriculares BT Pro',  3,  120.00, 35, 1);
INSERT INTO productos VALUES (5, 'SSD Externo 1TB',     4,  130.00, 18, 1);
INSERT INTO productos VALUES (6, 'Teclado Mecánico',    2,   95.00, 40, 1);

-- AÑADIMOS DATOS A CADA COLUMNA DE LA TABLA DE VENTAS
INSERT INTO ventas VALUES (1,  1, 1, 2, 1200.00, '2024-03-05');
INSERT INTO ventas VALUES (2,  2, 2, 5,   28.00, '2024-03-06');
INSERT INTO ventas VALUES (3,  3, 3, 1,  450.00, '2024-03-07');
INSERT INTO ventas VALUES (4,  1, 4, 2,  120.00, '2024-03-08');
INSERT INTO ventas VALUES (5,  4, 5, 3,  130.00, '2024-03-10');
INSERT INTO ventas VALUES (6,  2, 6, 4,   95.00, '2024-03-11');
INSERT INTO ventas VALUES (7,  5, 1, 1, 1200.00, '2024-03-12');
INSERT INTO ventas VALUES (8,  3, 2, 8,   28.00, '2024-03-13');
INSERT INTO ventas VALUES (9,  4, 4, 1,  120.00, '2024-03-14');
INSERT INTO ventas VALUES (10, 5, 3, 2,  450.00, '2024-03-15');

-- AHORA USAMOS EL COMANDO SELECT PARA CONFIRMAR QUE CADA TABLA SE CARGO CORRECTAMENTE
SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;