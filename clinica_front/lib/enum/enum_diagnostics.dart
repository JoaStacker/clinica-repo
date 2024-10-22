enum Diagnostics {
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
  const Diagnostics(this.value);
}
