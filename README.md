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

3.motoreductor 3-9v izquierdo

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

 Analizando el puente H que adquirimos ponemos analizar los pines para analizar como hacer la conexiones para logar el objetivo del proyecto, vemos que tiene una alimentacion de 12v y otra que puede funcionar como entrada o salida segun lo requiera , si se quiere que funcione como entrada hay que quitar quitar el jumper que mantiene la salida regulada, pero como salida es solo utilizarlo con el jumper y esta slaida proporcioanra 5v regulados que en este caso podria ser util para conectar la FPGA a este pin ya que requerimos tenerla encendida para sacar las seañales que diseñamos para el control del motor, por otro lado encontramos 6 pines ena1,in1,in2,in3,in4 y ena2 en este caso encontramos que in 1 y in 2 hacen el control de las salidas out 1 y out 2 es decir que con estas entradas controlamos uno de los motores por lo que en estos pines debemos conectar 1 pin a una de las salidas establecidas de la fpga y la otra a tiera y para in 3 y in 4 es lo mismo , las entradas de enable son para hacer el control de la velocidad mediante el mdoulo PWM por lo que debemos conectar estas salidas con las salidas establecidas del PWM en la FPGA

primeramente hacemos el diseño del codigo en donde establecemos las entradas y salidas en este caso s1 y s2 son las entradas , y en salidas tenemos m1 y m2 cada sensor controla cada salida, siguiente a eso debemos establecer los pines donde van a entrar las señales a la fpga y los pines dode va a salir la señal de los motores , siendo asi.

sensor 1 PIN 9

sensor 2 PIN 16 


motor 1 PIN 17

motor 2 PIN 15

CLK o reloj PIN 60

PWM1 PIN 37

PWM2 PIN 33

Por lo que hacemos la conexion va a ser la siguiente desde la fpga hasta el puente h 

PIN 9 conectado al out del sensor 1

PIN 16 conectado al out de sensor 

motor 1 PIN 17 conectada a in1

motor 2 PIN 15 conectado a in3

PWM1 PIN 37 conectado a ena1

PWM2 PIN 33 conectado a ena2

tambien establecemos la conexion para energizar los sensores , ya que la fpga nos suministra 3v de salida y gnd entonces
![image](https://github.com/user-attachments/assets/f3e047d2-5e52-4065-a686-9f90964eef04)

entonces hacemos las conexiones anteriormente establecidas al lado izquierdo de este esquema en la fpga,tambien el lado inferior de la imagen nos muestra otros pines , en este podemos tomar los pines de 5 v para alimentar la fpga ya que se convierte en entrada y el puente H nos suministra 5v regulados.

la conexion de los motores si van directamente al puente H en los out que mencionamos mas arriba ya que las salidas de motor que tenemos en la fpga funcionan es para el control , apagar o prender el motor que controla cada sensor para mantenerse en la linea.

en el caso de los enable esta entrada nos permite habilitar el pulso que programamos en el codigo para hacer el control de velocidad que se requiera.

## Digrama de flujo 
![image](https://github.com/user-attachments/assets/e7645635-d15c-4881-bd4d-9734099d1e56)


## Diagrama de bloques 
![image](https://github.com/user-attachments/assets/92a2ccb4-af0b-4d10-969f-ee3e706517ce)

## Esquematico controlador motor
Los sensores infrarrojos  determinarán que dirección debe seguir el carro  si se activa el sensor izquierdo se activa el motor izquierdo por lo tanto el carro ira a la izquierda , si se activa el otro sensor se activara el motor derecho y deberá realizar un giro a la derecha en caso de que ambos sensores esten activados el carro ira derecho y si ninguno se activa el carro se detendra. 
[![image.png](https://i.postimg.cc/pT1zSTDN/image.png)](https://postimg.cc/7G05GqsX)
## Esquematico PWM
El PWM es una sirve para controlar la potencia suministrada en los  como motores. El PWM se utiliza para ajustar la velocidad de los motores mediante la variación de la proporción entre el tiempo que el motor está encendido (alto) y el tiempo que está apagado (bajo), conocido como ciclo de trabajo o duty cycle.

Duty cycle (ciclo de trabajo): Es la proporción del tiempo en que la señal está en estado alto (encendida) durante un ciclo. Un duty cycle del 50% significa que la señal está encendida la mitad del tiempo y apagada la otra mitad, lo que resulta en una velocidad media.

[![image.png](https://i.postimg.cc/CLrmCmfq/image.png)](https://postimg.cc/PPZWTbyX)
## Esquematico seguidor de linea 
La fpga tiene la logica controla los motores y los PWM, los pines de esta se conectan a el driver L298N que estara conectado a los moteres y a la fuente de energía del circuito 
[![image.png](https://i.postimg.cc/4NR8NBhv/image.png)](https://postimg.cc/w3F5w523)

video del funcionamiento
https://youtu.be/kAsGApBmvmA

prueba sensores
https://youtu.be/ksQ-yB77qn0

Prueba sensores 2
https://youtu.be/G1jybRseQ5s?si=YUk4it_H8NBm0bn_



