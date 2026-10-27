# RetailPro | Data Analytics – Coderhouse

Repositorio de entregas del curso de **Data Analytics de Coderhouse**. El proyecto principal, **RetailPro**, utiliza datos de una empresa ficticia que comercializa productos de tecnología en Argentina para practicar consultas SQL, procesos ETL, modelado de datos y visualización en Power BI.

## Objetivo del proyecto

La pregunta central del análisis es:

> **¿Qué tan concentradas están las ventas de RetailPro en la Ciudad Autónoma de Buenos Aires (CABA) frente al resto de Argentina?**

A lo largo de los módulos se construyen y consultan los datos de ventas para explorar el comportamiento comercial, preparar la información y desarrollar un modelo analítico. Las consultas también abordan facturación mensual, productos con mayores ventas y recurrencia de clientes.

## Base de datos

La base se denomina **`Ventas_Tech_DB`** y consta de cuatro tablas:

| Tabla | Función |
| --- | --- |
| `ventas` | Tabla de hechos: registra las operaciones de venta. |
| `clientes` | Información de los clientes, incluida su ciudad. |
| `productos` | Información de los productos comercializados. |
| `categorias` | Clasificación de los productos. |

Las tablas se relacionan para analizar las ventas por cliente, producto, categoría y ubicación geográfica.

## Herramientas utilizadas

| Herramienta | Aplicación en el curso |
| --- | --- |
| **MySQL Workbench** | Módulo 3: creación y carga inicial de la base de datos con SQL. |
| **SQL Server y SQL Server Management Studio (SSMS)** | Desde el módulo 4: consultas de negocio, relaciones entre tablas y análisis con SQL. |
| **Power BI Desktop** | Desde el módulo 6: preparación, modelado y análisis de datos. |
| **Power Query y lenguaje M** | Módulo 6: construcción del pipeline ETL y transformaciones. |
| **DAX** | Módulo 8: creación de medidas para el modelo analítico. |

## Estructura del repositorio

```text
data-analytics-coderhouse/
├── Modulo3/
│   ├── ventas_tech_db.sql
│   ├── ddl_dml_bodega.sql
│   └── modulo2_unidad1_diseno.sql
├── Modulo4/
│   └── m4_consultas_negocio.sql
├── Modulo5/
│   └── m5_consultas_joins.sql
├── Modulo6/
│   ├── Pipeline_ETL_Fayolle_Juliano.pbix
│   └── README.md
├── Modulo8/
│   ├── Fayolle_Juliano_Checkpoint2.pbix
│   └── README.md
└── README.md
```

> **¿Por qué faltan módulos?** Los módulos 1, 2, 7 y 9 no están en el repo porque esas entregas se hicieron directamente en la plataforma de Coderhouse (documentos, el diagrama ER hecho en draw.io y el boceto del dashboard), no por GitHub.

### Contenido por módulo

- **Módulo 3:** `ventas_tech_db.sql` crea la base y carga sus datos. `ddl_dml_bodega.sql` es el ejercicio BodegaTech: una tabla de inventario armada con DDL y DML (`CREATE TABLE`, `INSERT` y `UPDATE`). `modulo2_unidad1_diseno.sql` es el ejercicio de diseño de las tablas `clientes` y `productos` con `CREATE TABLE`, explicando por qué elegí cada tipo de dato.
- **Módulo 4:** `m4_consultas_negocio.sql` incluye resumen mensual, ranking de productos, clientes recurrentes y comparación de meses por encima o por debajo del promedio.
- **Módulo 5:** `m5_consultas_joins.sql` incluye una vista base con `INNER JOIN`, detección de clientes y productos sin ventas mediante `LEFT JOIN`, y consolidación **CABA vs. resto del país** con `UNION ALL`.
- **Módulo 6:** archivo `.pbix` del pipeline ETL en Power Query y su documentación específica.
- **Módulo 8:** archivo `.pbix` del modelo de datos y las medidas DAX, junto con su documentación específica.

## Cómo ejecutar los scripts SQL

> **Importante:** el proyecto usó **dos motores de bases de datos**: MySQL en el módulo 3 y SQL Server desde el módulo 4. `ventas_tech_db.sql` está escrito para MySQL, pero para correrlo en SQL Server alcanza con cambiar **dos líneas** (ver paso 2).

### 1. (Opcional) Crear la base en MySQL Workbench, como en el Módulo 3

1. Iniciar un servidor MySQL y abrir **MySQL Workbench**.
2. Conectarse a la instancia correspondiente.
3. Abrir `Modulo3/ventas_tech_db.sql` desde **File > Open SQL Script**.
4. Ejecutar el script de creación y carga. Confirmar que exista la base **`Ventas_Tech_DB`** y sus cuatro tablas.

Los archivos `Modulo3/ddl_dml_bodega.sql` y `Modulo3/modulo2_unidad1_diseno.sql` son ejercicios aparte del módulo 3. No hace falta correrlos para armar RetailPro.

### 2. Preparar RetailPro en SQL Server (desde el Módulo 4)

1. Abrir **SQL Server Management Studio (SSMS)** y conectarse a una instancia de SQL Server.
2. Abrir `Modulo3/ventas_tech_db.sql` con **File > Open > File**.
3. Hacer dos cambios, porque estas líneas son sintaxis de MySQL:
   - Cambiar `CREATE DATABASE IF NOT EXISTS Ventas_Tech_DB;` por:

     ```sql
     DROP DATABASE IF EXISTS Ventas_Tech_DB;
     CREATE DATABASE Ventas_Tech_DB;
     ```

   - En la tabla `productos`, cambiar `activo tinyint(1) default 1` por `activo tinyint default 1` (en SQL Server `TINYINT` no lleva tamaño).

   Son los únicos cambios que tuve que hacer cuando pasé el proyecto a SQL Server en el módulo 4.
4. Ejecutar el script con **F5** y comprobar que `Ventas_Tech_DB` tenga las tablas `ventas`, `clientes`, `productos` y `categorias` con sus datos.

### 3. Ejecutar las consultas en SSMS (Módulos 4 y 5)

Ejecutar los archivos en este orden sugerido:

1. **`Modulo4/m4_consultas_negocio.sql`**: análisis comercial general.
2. **`Modulo5/m5_consultas_joins.sql`**: cruces entre tablas y análisis geográfico CABA vs. resto del país.

En SSMS, abrir cada archivo con **File > Open > File**, revisar que la base seleccionada sea `Ventas_Tech_DB` y presionar **Execute**. Si algún script crea objetos persistentes, como una vista, verificar antes de volver a ejecutarlo si ya existen.

### 4. Abrir los proyectos de Power BI (Módulos 6 y 8)

1. Abrir `Modulo6/Pipeline_ETL_Fayolle_Juliano.pbix` con **Power BI Desktop** para revisar el pipeline ETL, Power Query y las transformaciones M.
2. Abrir `Modulo8/Fayolle_Juliano_Checkpoint2.pbix` para explorar el modelo de datos y las medidas DAX.
3. Si se requiere actualizar la información, revisar las **configuraciones de origen de datos**, las credenciales y la conexión a la base disponible en el entorno local antes de actualizar.
4. Consultar los archivos `README.md` de cada módulo para su documentación específica.

## Alcance

Este repositorio reúne entregas realizadas a lo largo del curso. Los scripts, el proceso ETL y los archivos de Power BI permiten seguir la evolución del trabajo desde la base de datos inicial hasta el análisis de ventas y su concentración geográfica.
