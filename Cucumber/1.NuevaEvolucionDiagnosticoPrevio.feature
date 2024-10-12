Feature: Agregar una nueva evolución con diagnóstico previo.

    Para que se pueda diagnosticar al paciente 
    el médico 
    quiere añadir una nueva evolución en la historia clínica del paciente eligiendo un diagnostico previo.

    Rule: Solo se puede seleccionar un diagnóstico para crear una evolución.

    Background: El médico visualiza una historia clinica del paciente.
        Given el médico con <nombre-medico> ha iniciado sesión
        And ha buscado la historia clínica de un paciente.

    Scenario: El médico agrega una evolución con texto libre.
        Given el médico visualiza una historia clínica del paciente
        When el médico selecciona un <diagnostico> previo e ingresa una <descripcion> para la evolución
        And el médico guarda la evolución
        Then deberia registrarse la evolución en la historia clínica del paciente con 
        el <diagnostico>, la descripción y el médico.
        Examples:
        | diagnóstico | nombre-medico     | descripcion              |
        | DENGUE      | Dr. Frías Juan    | Se receta paracetamol    |
        | FEBRICULA   | Dra. Paz Josefina | Texto	                 |
        | NEUMONIA    | Dr. Lopez Pablo   | Dextrometorfano          |

    Scenario: El médico agrega una evolución con plantilla.
        Given el médico visualiza una historia clínica del paciente
        When el médico selecciona un <diagnostico> previo
        And selecciona una <plantilla> para la evolución
        And el medico guarda la evolución
        Then deberia registrarse la evolución en la historia clínica del paciente con 
        el <diagnostico>, la descripcion y el médico.
        Examples:
        | diagnostico | nombre-medico     | plantilla        |
        | DENGUE      | Dr. Frías Juan    | Dengue:      ... |
        | FEBRICULA   | Dra. Paz Josefina | Febricula:   ... |
        | VARICELA    | Dr. Lopez Pablo   | Varicela:    ... |

    Scenario: El médico no selecciona un diagnóstico.
        Given el médico visualiza una historia clínica del paciente
        When el médico guarda la evoución
        Then la evolución no se debería poder guardar.

    Scenario: El médico cancela la creación de una evolución.
        Given el médico visualiza una historia clínica del paciente
        And se encuentra en la creación de nueva evolución
        When el médico cancela la evolución
        Then debería cancelarse la creacion de la evolución.