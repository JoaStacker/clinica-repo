// ignore_for_file: constant_identifier_names

enum NewDiagnostics {
  A011('Fiebre paratifoidea a'),
  A012('Fiebre paratifoidea b'),
  A013('Fiebre paratifoidea c'),
  A014('Fiebre paratifoidea, no especificada'),
  A02('Otras infecciones debidas a Salmonella'),
  A020('Enteritis debida a salmonella'),
  A021('Septicemia debida a salmonella'),
  A022('Infecciones localizadas debida a salmonella'),
  A028('Otras infecciones especificadas como debidas a salmonella'),
  A029('Infeccion debida a salmonella no especificada'),
  A03('Shigelosis'),
  A030('Shigelosis debida a shigella dysenteriae'),
  A031('Shigelosis debida a shigella flexneri'),
  A032('Shigelosis debida a shigella boydii'),
  A033('Shigelosis debida a shigella sonnei'),
  A038('Otras shigelosis'),
  A039('Shigelosis de tipo no especificado'),
  A04('Otras infecciones intestinales bacterianas'),
  A040('Infeccion debida a escherichia coli enteropatogena'),
  A041('Infeccion debida a escherichia coli enterotoxigena'),
  A042('Infeccion debida a escherichia coli enteroinvasiva'),
  A043('Infeccion debida a escherichia coli enterohemorragica'),
  A044('Otras infecciones intestinales debidas a escherichia coli'),
  A045('Enteritis debida a campylobacter'),
  A046('Enteritis debida a yersinia enterocolitica'),
  A047('Enterocolitis debida a clostridium difficile'),
  A048('Otras infecciones intestinales bacterianas especificadas'),
  A049('Infeccion intestinal bacteriana, no especificada'),
  A05('Otras intoxicaciones alimentarias bacterias'),
  A050('Intoxicacion alimentaria estafilococica'),
  A051('Botulismo'),
  A052('Intoxicacion alimentaria debida a clostridium perfringens [clostridium welchii]'),
  A053('Intoxicacion alimentaria debida a vibrio parahaemolyticus'),
  A054('Intoxicacion alimentaria debida a bacillus cereus'),
  A058('Otras intoxicaciones alimentarias debidas a bacterias especificadas'),
  A059('Intoxicacion alimentaria bacteriana, no especificada'),
  A06('Amebiasis'),
  A060('Disenteria amebiana aguda'),
  A061('Amebiasis intestinal cronica'),
  A062('Colitis amebiana no disenterica'),
  A063('Ameboma intestinal'),
  A064('Absceso amebiano del higado'),
  A065('Absceso amebiano del pulmon (j99.8)'),
  A066('Absceso amebiano del cerebro (g07)'),
  A067('Amebiasis cutanea'),
  A068('Infeccion amebiana de otras localizaciones'),
  A069('Amebiasis, no especificada'),
  A07('Otras enfermedades intestinales debidas a protozoarios'),
  A070('Balantidiasis'),
  A071('Giardiasis [lambliasis]'),
  A072('Criptosporidiosis'),
  A073('Isosporiasis'),
  A078('Otras enfermedades intestinales especificadas debidas a protozoarios'),
  A079('Enfermedad intestinal debida a protozoarios, no especificada'),
  A08('Infecciones intestinales debidas a virus y otros organismos especificados'),
  A080('Enteritis debida a rotavirus'),
  A081('Gastroenteropatia aguda debida al agente de norwalk'),
  A082('Enteritis debida a adenovirus'),
  A083('Otras enteritis virales'),
  A084('Infeccion intestinal viral, sin otra especificacion'),
  A085('Otras infecciones intestinales especificadas'),
  A09('Diarrea y gastroenteritis de presunto origen infeccioso'),
  A15('Tuberculosis respiratoria, confirmada bacteriológica e histologicamente'),
  A150('Tuberculosis del pulmon, confirmada por hallazgo microscopico del bacilo tuberculoso en esputo, con o sin cultivo'),
  A151('Tuberculosis del pulmon, confirmada unicamente por cultivo'),
  A152('Tuberculosis del pulmon, confirmada histologicamente'),
  A153('Tuberculosis del pulmon , confirmada por medios no especificados'),
  A154('Tuberculosis de ganglios linfaticos intratoracicos, confirmada bacteriologica e histologicamente'),
  A155('Tuberculosis de laringe, traquea y bronquios, confirmada bacteriologica e histologicamente'),
  A156('Pleuresia tuberculosa, confirmada bacteriologica e histologicamente'),
  A157('Tuberculosis respiratoria primaria, confirmada bacteriologica e histologicamente'),
  A158('Otras tuberculosis respiratorias, confirmadas bacteriologica e histologicamente'),
  A159('Tuberculosis respiratoria no especificada, confirmada bacteriologicamente e histologicamente'),
  A16('Tuberculosis respiratoria, no confirmada bacteriologica e histologicamente'),
  A160('Tuberculosis del pulmon, con examen bacteriologico e histologico negativos'),
  A161('Tuberculosis del pulmon, sin examen bacteriologico e histologico'),
  A162('Tuberculosis de pulmon, sin mencion de confirmacion bacteriologica o histologica'),
  A163('Tuberculosis de ganglios linfaticos intratoracicos, sin mencion de confirmacion bacteriologica o histologica'),
  A164('Tuberculosis de laringe, traquea y bronquios, sin mencion de confirmacion bacteriologica o histologica'),
  A165('Pleuresia tuberculosa, sin mencion de confirmacion bacteriologica e histologica'),
  A167('Tuberculosis respiratoria primaria, sin mencion de confirmacion bacteriologica e histologica'),
  A168('Otras tuberculosis respiratorias, sin mencion de confirmacion'),
  A169('Tuberculosis respiratoria no especificada, sin mencion de confirmacion bacteriologica e histologica'),
  A17('Tuberculosis del sistema nervioso'),
  A170('Meningitis tuberculosa (g01)'),
  A171('Tuberculoma meningeo (g07)'),
  A178('Otras tuberculosis del sistema nervioso'),
  A179('Tuberculosis del sistema nervioso, no especificada (g99.8)'),
  A18('Tuberculosis de otros órganos'),
  A180('Tuberculosis de huesos y articulaciones'),
  A181('Tuberculosis del aparato genitourinario'),
  A182('Linfadenopatia periferica tuberculosa'),
  A183('Tuberculosis de los intestinos, el peritoneo y los ganglios mesentericos'),
  A184('Tuberculosis de la piel y el tejido subcutaneo'),
  A185('Tuberculosis del ojo'),
  A186('Tuberculosis del oido'),
  A187('Tuberculosis de glandulas suprarrenales (e35.1)'),
  A188('Tuberculosis de otros organos especificados'),
  A19('Tuberculosis miliar'),
  A190('Tuberculosis miliar aguda de un solo sitio especificado'),
  A191('Tuberculosis miliar aguda de sitios multiples'),
  A192('Tuberculosis miliar aguda, no especificada'),
  A198('Otras tuberculosis miliares'),
  A199('Tuberculosis miliar, sin otra especificacion');

  final String value;
  const NewDiagnostics(this.value);
}