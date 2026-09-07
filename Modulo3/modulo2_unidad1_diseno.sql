CREATE TABLE clientes(
	id_cliente int PRIMARY KEY, -- elegi tipo de dato entero ya que cada id de clientes lo representamos con un numero entero sin decimales para que sea unico
	nombre varchar(100), -- elegimos varchar para asignarle una cantidad maxima de 100 caracteres de tipo texto para escribir el nombre
	perfil_bio text, -- usamos tipo de dato text ya que aca iria una biografia larga describiendo al cliente
	fecha_registro date -- elegimos el tipo de dato date ya que registraríamos solo el dia/mes/año de registro del cliente
);
CREATE TABLE productos(
	id_producto int PRIMARY KEY, -- elegi tipo de dato entero ya que cada id de productos lo representamos con un numero entero sin decimales para que sea unico
  descripcion varchar(255), -- puse el tipo de dato varchar ya que aca ira una breve descripcion del producto y le asignamos que no sean mas de 255 caracteres
  precio decimal(10,2), -- usamos decimal ya que los precios de los productos pueden no llegar a ser redondos y ademas decimal es mas preciso que float para manejar dinero, evitando errores de redondeo
  esta_activo bool -- por ultimo elegi el dato de tipo bool ya que nos sirve para indicar si el producto sigue a la venta (true) o fue discontinuado (false), sin importar el stock que tenga
);
