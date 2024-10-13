Feature: Agregar un diagnóstico a la historia clínica del paciente.

	Para que se pueda diagnosticar a un paciente 
	el médico 
	quiere añadir un diagnóstico disponible a la historia clínica del paciente.

	Rule: Solo se puede seleccionar un diagnóstico disponible en el CIE-10 para añadir a la historia clínica.

	Background: El médico visualiza una historia clínica del paciente.
		Given el médico ha iniciado sesión
		And se ha buscado la historia clínica de un paciente.

	Scenario: El médico agrega un nuevo diagnóstico.
		Given el médico visualiza una historia clínica del paciente
		When el médico selecciona un diagnóstico disponible en el CIE-10
		And el médico guarda el nuevo diagnóstico
		Then debería registrarse el nuevo diagnóstico en la historia clínica del paciente.

	Scenario: El médico no selecciona ningún diagnóstico.
		Given el médico visualiza una historia clínica del paciente
		When el médico no selecciona ninguna diagnóstico
		Then no se debería poder guardar en la historia clínica.