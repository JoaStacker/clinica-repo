Feature: Agregar una nueva evolución con receta digital.

    Para indicarle medicamentos y tratamientos al paciente 
    el médico 
    quiere añadir una receta digital en una evolución.

    Rule: Solo se puede crear una receta digital por evolución.

    Background: El médico visualiza una historia clinica del paciente.
        Given el médico con <nombre-medico> ha iniciado sesión
        And se ha buscado la historia clínica de un paciente.

    Scenario: El médico agrega una evolución con receta digital con medicamentos y dosis.
        Given el médico visualiza una historia clínica del paciente
        When el médico selecciona una <diagnostico> previo
        * selecciona cada <medicamento> que desee recetar
        * por cada uno ingresa una <cantidad> y una <dosis>
        * el médico guarda la evolución
        Then debería registrarse la evolución en la historia clinica del paciente con 
        el <diagnostico>, la receta digital y el médico.
        Examples:
        | diagnostico | nombre-medico    | medicamento | cantidad | dosis  					             |   
        | DENGUE      | Dr. Frías Juan   | ibuprofeno  | 2		  | Uno en el almuerzo y otro en la cena |
        | FEBRICULA   | Dra. Paz Josefina| paracetamol | 1		  | 1 al medido día hasta el 20 de Abril |
        | VARICELA    | Dr. Lopez Pablo  | aspirina    | 3		  | 1 cada 8 hs					         |

    Scenario: El médico imprime la receta digital.
        Given el médico visualiza una historia clínica del paciente
        When el médico selecciona una evolución con receta digital
        And el médico imprime la receta digital
        Then debería generarse una impresión de la receta.