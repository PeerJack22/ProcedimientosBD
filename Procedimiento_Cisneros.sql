create database procedimientos;

use procedimientos;

-- Crear tabla cliente
CREATE TABLE cliente (
    ClienteID INT AUTO_INCREMENT PRIMARY KEY,  -- Campo para el ID único del cliente
    Nombre VARCHAR(100),                      -- Campo para el nombre del cliente
    Estatura DECIMAL(5,2),                    -- Campo para la estatura del cliente con dos decimales
    FechaNacimiento DATE,                     -- Campo para la fecha de nacimiento del cliente
    Sueldo DECIMAL(10,2)                      -- Campo para el sueldo del cliente con dos decimales
);

-- Proceso para mostrar tabla cliente

DELIMITER //
CREATE PROCEDURE mostrarCliente()
BEGIN
    SELECT * FROM cliente;  
END //
DELIMITER ;

INSERT INTO cliente (Nombre, Estatura, FechaNacimiento, Sueldo) VALUES
('Juan Pérez', 1.75, '1990-05-15', 3000.00),
('María Gómez', 1.65, '1985-10-20', 2500.50),
('Carlos López', 1.80, '1992-03-30', 4000.00),
('Ana Martínez', 1.60, '1988-07-25', 2800.75),
('Luis Fernández', 1.70, '1995-12-05', 3200.00);

-- Llamar procedimiento

call mostrarCliente();

-- Procedimiento de insertar

DELIMITER //

CREATE PROCEDURE InsertarCliente(
    IN p_Nombre VARCHAR(100),
    IN p_Estatura DECIMAL(5,2),
    IN p_FechaNacimiento DATE,
    IN p_Sueldo DECIMAL(10,2)
)
BEGIN
    INSERT INTO cliente (Nombre, Estatura, FechaNacimiento, Sueldo)
    VALUES (p_Nombre, p_Estatura, p_FechaNacimiento, p_Sueldo);
END //

DELIMITER ;

call InsertarCliente("Paulo Cisneros",1.76,"2002-05-05",3500.00)
 
 
-- Actualizar la edad

DELIMITER //

CREATE PROCEDURE ActualizarEdadCliente(
    IN p_ClienteID INT,
    IN p_NuevaEdad INT
)
BEGIN
    DECLARE nueva_FechaNacimiento DATE;

    -- Calcular la nueva fecha de nacimiento en función de la edad
    SET nueva_FechaNacimiento = DATE_SUB(CURDATE(), INTERVAL p_NuevaEdad YEAR);

    -- Actualizar el registro del cliente
    UPDATE cliente
    SET FechaNacimiento = nueva_FechaNacimiento
    WHERE ClienteID = p_ClienteID;
END //

DELIMITER ;

call ActualizarEdadCliente(1,30);

-- eliminar cliente

DELIMITER //

CREATE PROCEDURE EliminarCliente(
    IN p_ClienteID INT
)
BEGIN
    DELETE FROM cliente
    WHERE ClienteID = p_ClienteID;
END //

DELIMITER ;

call EliminarCliente(1);

-- Procedimiento de verificar la edad
DELIMITER //

CREATE PROCEDURE VerificarEdadCliente(
    IN p_ClienteID INT
)
BEGIN
    DECLARE edad INT;
    DECLARE fechaNacimiento DATE;
    SELECT FechaNacimiento INTO fechaNacimiento
    FROM cliente
    WHERE ClienteID = p_ClienteID;

    -- Calcular la edad del cliente
    SET edad = TIMESTAMPDIFF(YEAR, fechaNacimiento, CURDATE());

    -- Verificar si la edad es mayor o igual a 22
    IF edad >= 22 THEN
        SELECT CONCAT('El cliente con ID ', p_ClienteID, ' tiene ', edad, ' años y es mayor o igual a 22 años.') AS Mensaje;
    ELSE
        SELECT CONCAT('El cliente con ID ', p_ClienteID, ' tiene ', edad, ' años y es menor de 22 años.') AS Mensaje;
    END IF;
END //

DELIMITER ;

call VerificarEdadCliente(2); 

-- Crear tabla de ordenes 
create table ordenes (
	OrdenID int primary key auto_increment,
    ClienteID int,
    Monto decimal (10,2),
    foreign key (ClienteID) references cliente(ClienteID)
);

-- Procedimiento de inserción
DELIMITER //

CREATE PROCEDURE InsertarOrden(
    IN p_ClienteID INT,
    IN p_Monto DECIMAL(10,2)
)
BEGIN
    INSERT INTO ordenes (ClienteID, Monto)
    VALUES (p_ClienteID, p_Monto);
END //

DELIMITER ;

-- Procedimiento de Actualizar
DELIMITER //

CREATE PROCEDURE ActualizarOrden(
    IN p_OrdenID INT,
    IN p_NuevoMonto DECIMAL(10,2)
)
BEGIN
    UPDATE ordenes
    SET Monto = p_NuevoMonto
    WHERE OrdenID = p_OrdenID;
END //

DELIMITER ;

-- Procedimiento de eliminación

DELIMITER //

CREATE PROCEDURE EliminarOrden(
    IN p_OrdenID INT
)
BEGIN
    DELETE FROM ordenes
    WHERE OrdenID = p_OrdenID;
END //

DELIMITER ;


