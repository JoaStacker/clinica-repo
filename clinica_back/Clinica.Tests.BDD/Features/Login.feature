Feature: Iniciar sesion

  Para que se pueda acceder a las funcionalidades del sistema de clínica
  el medico
  quiere iniciar sesion con sus credenciales

Background: El medico tiene una cuenta asignada.
  Given que existen los siguientes usuarios medicos:
    | email           | clave        |
    | pedro@gmail.com | C0ding4Life$ |


# INICIAR SESION

Scenario Outline: El medico inicia sesion con claves invalidas
  When el medico ingresa el email "<email>" y la clave "<clave>" e inicia sesion
  Then no se debe crear una nueva sesion y mostrar un mensaje "Clave incorrecta".

  Examples:
    | email              | clave            |
    | pedro@gmail.com    | Program4Life$    | 
    | pedro@gmail.com    | Engineer4Life$   |
    | pedro@gmail.com    | Desgin4Life$     |

Scenario Outline: El medico inicia sesion con emails invalidos
  When el medico ingresa el email "<email>" y la clave "<clave>" e inicia sesion
  Then no se debe crear una nueva sesion y mostrar un mensaje "Email incorrecto".

  Examples:
    | email                 | clave             |
    | santiago@gmail.com    | C0ding4Life$      | 
    | pepe@gmail.com        | C0ding4Life$      |
    | barbara@gmail.com     | C0ding4Life$      |

Scenario: El medico ingresa un email y clave validos
  When el medico ingresa el email "pedro@gmail.com" y la clave "C0ding4Life$" e inicia sesion
  Then se debe crear una sesion para el usuario con dicho email y generar un token.


# CREAR USUARIO
#Scenario Outline: El medico crea usuario con claves no seguras
#  When el medico para crearse una cuenta ingresa el email "<email>" y la clave "<clave>"
#  Then no se debe crear un nuevo usuario y mostrar un mensaje "Clave insegura".
#
#  Examples:
#    | email           | clave           |
#    | pedro@gmail.com | Cf4$            | # Minimo 8 carecteres
#    | pedro@gmail.com | c0ding4life$    | # Minimo una mayuscula
#    | pedro@gmail.com | C0DING4LIFE$    | # Minimo una minuscula
#    | pedro@gmail.com | CodingfLife$    | # Minimo un numero
#    | pedro@gmail.com | C0ding4Lifee    | # Minimo un caracter especial
#
#Scenario: El medico crea usuario con un email ya existente.
#  When el medico para crearse una cuenta ingresa el email "pedro@gmail.com" y la clave "Coding4Life$"
#  Then no se debe crear un nuevo usuario y mostrar un mensaje "El email ya existe".