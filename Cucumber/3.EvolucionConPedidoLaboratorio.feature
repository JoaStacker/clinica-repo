Feature: Agregar una nueva evolución con pedido de laboratorio.

    Para indicarle un pedido de laboratorio al paciente 
    el médico 
    quiere añadir un pedido de laboratorio en una evolución.

	Rule: Solo se puede crear un pedido de laboratorio por evolución.

    Background: el médico visualiza una historia clinica del paciente.
        Given el médico con <nombre-medico> ha iniciado sesión
        And se ha buscado la historia clínica de un paciente.

    Scenario: El médico agrega una evolución con pedido de laboratorio de texto libre.
        Given el médico visualiza una historia clínica del paciente
        When el médico selecciona un <diagnostico> previo
        And ingresa un <texto-pedido> para el pedido de laboratorio
        And el medico guarda la evolución
        Then debería registrarse la evolución en la historia clinica del paciente con 
        el <diagnostico>, el pedido de laboratorio y el medico.
        Examples:
        | diagnostico | nombre-medico     | texto-pedido                 |   	  
        | DENGUE      | Dr. Frías Juan    | Análisis completo            |	  
        | FEBRÍCULA   | Dra. Paz Josefina | Solo hemoglobina             |  	  
        | NEUMONIA    | Dr. Lopez Pablo   | Se hace análisis de orina    |

    Scenario: El médico agrega una evolución con pedido de laboratorio con plantilla.
        Given el médico visualiza una historia clínica del paciente
        When el médico selecciona un <diagnostico> previo
        And selecciona la <plantilla> de pedido de laboratorio
        And el médico guarda la evolución
        Then debería registrarse la evolución en la historia clinica del paciente con 
        el <diagnostico>, el pedido de laboratorio y el médico.
        Examples:
        | diagnostico | nombre-medico    | plantilla     |
        | DENGUE      | Dr. Frías Juan   | Completo: ... |
        | FEBRICULA   | Dra. Paz Josefina| Hemo:     ... |
        | VARICELA    | Dr. Lopez Pablo  | Orina:    ... |
