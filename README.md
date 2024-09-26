# carro-seguidor-de-linea

## Integrantes
Nicolas peña garzon
victor sebastian santiago acosta 
## Descripcion y contexto del problema
Mediante la implementación de este proyecto se busca la construcción de un carro seguidor de línea, el cual sea capaz de esquivar obstáculos y seguir una línea mediante diferentes implementaciones de sensores tales como lo son los sensores infrarrojos o el sensor de ultrasonido. A partir de estos sensores, queremos cumplir que el carrose mantenga en la linea mediante la progrmacion de una FPGA ice-40
## Objetivos
-. Hacer en verilog el codigo de un carro seguidor de linea .
-. Programar la FPGA para implementar las señales en un carro seguidor de linea
-. Explicar detalladamente el proceso de cosntruccion y exponer esquemas ,codigos y imagenes para mostrar el proceso de cosntruccion y diseño. 
## Procedimiento
se desarrollan los modulos necesarioas para el funcionamiento del carro seguidor de linea , estos modulos los cargaremos en este github para mostrar los codigos utilizados y que hace cada codigo para el control y funcionamiento de cada sensor , este proyecto esta compuesto por los siguientes sensores

## sensores y actuadores
1.motoreductor 3-9v derecho
2.sensor infrarrojo derecho
3.motoreductor 3-9v izquierao
4.sensor infrarrojo izquierdo
## funcionamiento
funcionamiento del sensor infrarrojo:
Emisión de Luz Infrarroja:

El sensor tiene un emisor de luz infrarroja (IR), que proyecta un haz de luz hacia el suelo.
Esta luz no es visible al ojo humano, pero se refleja en las superficies que la reciben.


Reflexión de la Luz:

El sensor también incluye un receptor, generalmente un fotodiodo o fototransistor, que detecta la luz reflejada.
Superficies claras (como una pista blanca) tienden a reflejar más luz infrarroja, mientras que superficies oscuras (como una línea negra) absorben más luz, reflejando muy poca.


Detección de la Línea:

Cuando el sensor se encuentra sobre una superficie clara, el receptor detecta una gran cantidad de luz reflejada.Cuando está sobre una línea oscura, el receptor recibe poca o ninguna luz.
El microcontrolador del carro interpreta esta información para determinar si el vehículo está sobre la línea o se ha desviado.

con esta señal, necesitamos encontrar la forma de acoplar que la señal que envia el sensor para controlar los motores, en este sentido tenemos que hacer un codigo en verilog donde hagamos la logica para que cada sensor controles un motor segun la logica que es que cuadno un sensor este sobre la linea negra este tiene que apagar el motor que controla para que solo actue el otro motor , para esto encontramos necesario utilizar un driver que al estimular las entradas hagan girar el motor que necesitamos utilizar un driver llamado puente H que es un circuito electrónico utilizado para controlar el sentido de giro y la velocidad de un motor de corriente continua (DC). Es fundamental en proyectos de robótica, como en este caso un carro seguidor de línea.

Funciones del Puente H:
Control del Sentido de Giro:

El puente H permite cambiar la dirección en la que gira el motor, lo que es esencial para maniobrar un robot o vehículo.
Esto se logra controlando cómo se aplica la corriente a través de las terminales del motor.
Dependiendo de la configuración de los interruptores (generalmente transistores), la corriente puede fluir en un sentido o en el otro, lo que hace que el motor gire en sentido horario o antihorario.

Control de la Velocidad:

Combinado con un método de control como el PWM (modulación por ancho de pulso), el puente H puede también regular la velocidad del motor. Con esto, se puede ajustar la velocidad del carro de acuerdo a las necesidades del entorno o el algoritmo de control.
a continuacion el esquema del puente H que elegimos , un L298n

![Puente H ](https://github.com/user-attachments/assets/bb365c9c-b175-48af-b4b5-19937b8bb02d)

