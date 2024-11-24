Feature: Iniciar sesion

  Para que se pueda acceder a las funcionalidades del sistema de clínica
  el medico
  quiere iniciar sesion con sus credenciales

Background: El medico tiene una cuenta asignada.
  Given que existen los siguientes usuarios medicos:
    | email           | clave |
    | pedro@gmail.com | 1234  |

Scenario Outline: El medico intenta iniciar sesion con credenciales invalidas
  When el medico ingresa el email "<email>" y la clave "<clave>" e inicia sesion
  Then no se debe crear una nueva sesion.

  Examples:
    | email                 | clave     |
    | santiago@gmail.com    | 1234      | # Email invalido
    | pedro@gmail.com       | 4321      | # clave invalida
    | santiago@gmail.com    | 5678      | # Ambas credenciales invalidas

Scenario: El medico ingresa un email y clave validos
  When el medico ingresa el email "pedro@gmail.com" y la clave "1234" e inicia sesion
  Then se debe crear una sesion para el usuario con dicho email y generar un token.