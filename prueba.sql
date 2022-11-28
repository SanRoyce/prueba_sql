
CREATE DATABASE prueba_sql;

/* 1. Crea el modelo (revisa bien cuál es el tipo de relación antes de crearlo), respeta las
claves primarias, foráneas y tipos de datos. */

R:
Creacion de la tabla pelicula.

CREATE TABLE peliculas (
    id serial PRIMARY KEY,
    nombre varchar(255),
    anno integer
);

Creacion de la tabla tags.

CREATE TABLE tags (
    id serial PRIMARY KEY,
    tag varchar(32)
);

Creacion de la tabla intermedia.

CREATE TABLE peliculas_tags (
    pelicula_id integer,
    tag_id integer,
    FOREIGN KEY (pelicula_id) REFERENCES peliculas (id),
    FOREIGN KEY (tag_id) REFERENCES tags (id)
);


/* 2. Inserta 5 películas y 5 tags, la primera película tiene que tener 3 tags asociados, la
segunda película debe tener dos tags asociados. */

R:
Insertamos datos de las peliculas dentro de la tabla peliculas.

INSERT INTO peliculas (nombre, anno) 
VALUES('El señor de los anillos', 2002);

INSERT INTO peliculas (nombre, anno) 
VALUES('Up', 2009);

INSERT INTO peliculas (nombre, anno) 
VALUES('Jurassic World', 2015);

INSERT INTO peliculas (nombre, anno) 
VALUES('Interestellar', 2014);

INSERT INTO peliculas (nombre, anno) 
VALUES('Rapidos y furiosos', 2001);

Insertamos datos de las etiquetas dentro de la tabla tags.

INSERT INTO tags (tag) 
VALUES('Suspenso');

INSERT INTO tags (tag) 
VALUES('Ciencia Ficción');

INSERT INTO tags (tag) 
VALUES('Aventura');

INSERT INTO tags (tag) 
VALUES('Fantasía');

INSERT INTO tags (tag) 
VALUES('Romance');

Insertamos datos asociados dentro de la tabla peliculas_tags.

INSERT INTO peliculas_tags (pelicula_id, tag_id) 
VALUES(1,1);

INSERT INTO peliculas_tags (pelicula_id, tag_id) 
VALUES(1,2);

INSERT INTO peliculas_tags (pelicula_id, tag_id) 
VALUES(1,3);

INSERT INTO peliculas_tags (pelicula_id, tag_id) 
VALUES(2,3);

INSERT INTO peliculas_tags (pelicula_id, tag_id) 
VALUES(2,5);

/* 3. Cuenta la cantidad de tags que tiene cada película. Si una película no tiene tags debe
mostrar 0. */

R:
SELECT peliculas.nombre, COUNT (peliculas_tags.tag_id) FROM peliculas LEFT JOIN peliculas_tags ON peliculas.id = peliculas_tags.pelicula_id GROUP BY peliculas.nombre;


/* 4. Crea las tablas respetando los nombres, tipos, claves primarias y foráneas y tipos de
datos. */

R:
Creacion de la tabla preguntas.

CREATE TABLE preguntas (
    id SERIAL PRIMARY KEY,
    pregunta VARCHAR(255),
    respuesta_correcta VARCHAR
);

Creacion de la tabla usuarios.

CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255),
    edad integer
);

Creacion de la tabla intermedia.

CREATE TABLE respuestas (
    id SERIAL PRIMARY KEY,
    respuesta VARCHAR(255),
    pregunta_id integer,
    usuario_id integer,
    FOREIGN KEY (pregunta_id) REFERENCES preguntas (id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios (id)
);


/* 5. Agrega datos, 5 usuarios y 5 preguntas, la primera pregunta debe estar contestada
dos veces correctamente por distintos usuarios, la pregunta 2 debe estar contestada
correctamente sólo por un usuario, y las otras 2 respuestas deben estar incorrectas.
 */

 R:
Insertamos los datos en la tabla usuarios.

INSERT INTO usuarios (nombre, edad)
VALUES ('Daniel', 25);

INSERT INTO usuarios (nombre, edad)
VALUES ('Fernando', 28);

INSERT INTO usuarios (nombre, edad)
VALUES('Cris', 30);

INSERT INTO usuarios (nombre, edad)
VALUES('Consuelo', 26);

INSERT INTO usuarios (nombre, edad)
VALUES('Enzo', 29);


Insertamos los datos en la tabla preguntas.

INSERT INTO preguntas (pregunta, respuesta_correcta)
VALUES ('Quien vive en la costa', 'Yo vivo en viña del mar');

INSERT INTO preguntas (pregunta, respuesta_correcta)
VALUES ('Prefieres los climas calidos o frios', 'me gusta más el frio');

INSERT INTO preguntas (pregunta, respuesta_correcta)
VALUES ('Cuanto tiempo llevas viviendo en ese lugar', 'más de 5 años');

INSERT INTO preguntas (pregunta, respuesta_correcta)
VALUES ('Te mudarias a la capital', 'por nada del mundo');

INSERT INTO preguntas (pregunta, respuesta_correcta)
VALUES ('Sueles viajar mucho', 'de vez en cuando');


insertamos los datos en la tabla respuestas.

INSERT INTO respuestas (respuesta, usuario_id, pregunta_id)
VALUES ('Yo vivo en viña del mar', 2, 1);

INSERT INTO respuestas (respuesta, usuario_id, pregunta_id)
VALUES ('yo vivo en la serena', 4, 1);

INSERT INTO respuestas (respuesta, usuario_id, pregunta_id)
VALUES ('me gusta más el frio', 3, 2);

INSERT INTO respuestas (respuesta, usuario_id, pregunta_id)
VALUES ('soy team invierno', 4, 2);

INSERT INTO respuestas (respuesta, usuario_id, pregunta_id)
VALUES ('odio el calor de verano', 1, 2);


/* 6. Cuenta la cantidad de respuestas correctas totales por usuario (independiente de la
pregunta) */

R:
SELECT usuarios.nombre, COUNT (preguntas.respuesta_correcta) FROM preguntas RIGHT JOIN respuestas ON respuestas.respuesta = preguntas.respuesta_correcta JOIN usuarios ON usuarios.id = respuestas.usuario_id GROUP BY usuario_id, usuarios.nombre;


/* 7. Por cada pregunta, en la tabla preguntas, cuenta cuántos usuarios tuvieron la
respuesta correcta. */

R:
SELECT preguntas.pregunta, COUNT(respuestas.usuario_id) FROM respuestas RIGHT JOIN preguntas ON respuestas.pregunta_id = preguntas.id GROUP BY preguntas.pregunta;


/* 8. Implementa borrado en cascada de las respuestas al borrar un usuario y borrar el
primer usuario para probar la implementación. */

R:
ALTER TABLE respuestas CONSTRAINT respuestas_usuario_id_fkey, REFERENCES usuarios(id) ON DELETE CASCADE;


/* 9. Crea una restricción que impida insertar usuarios menores de 18 años en la base de
datos. */

R:
ALTER TABLE usuarios ADD CHECK (edad > 18); 


/* 10. Altera la tabla existente de usuarios agregando el campo email con la restricción de
único. */

R:
ALTER TABLE usuarios ADD email VARCHAR UNIQUE;
