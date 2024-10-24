enum PreviusDiagnostics {
  Covid('COVID-19'),
  Flu('Influenza'),
  Cold('Common Cold'),
  Allergy('Allergy'),
  StomachFlu('Gastroenteritis'),
  ChickenPox('Varicella'),
  Measles('Rubeola'),
  Mumps('Parotitis'),
  RSV('Respiratory Syncytial Virus'),
  Sinusitis('Sinus Infection');

  final String value;
  const PreviusDiagnostics(this.value);
}


enum NewDiagnostics {
  Diabetes('Diabetes Mellitus'),
  Hypertension('High Blood Pressure'),
  Asthma('Asthma'),
  Arthritis('Arthritis'),
  HeartDisease('Coronary Heart Disease'),
  Obesity('Obesity'),
  Osteoporosis('Osteoporosis'),
  COPD('Chronic Obstructive Pulmonary Disease'),
  Stroke('Stroke'),
  KidneyDisease('Chronic Kidney Disease');

  final String value;
  const NewDiagnostics(this.value);
}