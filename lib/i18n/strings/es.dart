const _tosBody = '''Términos de Servicio
Última actualización: 16 de abril de 2026

Los presentes Términos de Servicio ("Términos") regulan el uso de la aplicación Cvío ("la App"), desarrollada y gestionada por Fiorenzo ("nosotros"). Al utilizar la App, el usuario acepta los presentes Términos.

1. Descripción del servicio
Cvío es una aplicación gratuita que permite crear currículums vítae profesionales en formato PDF. La App ofrece varias plantillas, la posibilidad de rellenar el CV en varias secciones y una función de traducción automática.

2. Uso de la App
El usuario se compromete a:
- Utilizar la App conforme a las leyes aplicables.
- Introducir datos veraces y sobre los que ostenta los derechos.
- No utilizar la App con fines ilícitos o fraudulentos.

3. Propiedad intelectual
La App, su código fuente, las plantillas y el diseño son propiedad de Fiorenzo. El usuario conserva la plena propiedad de los contenidos (textos e imágenes) introducidos en su CV.

4. Servicios de terceros
La App utiliza el servicio de traducción MyMemory, proporcionado por Translated srl. El uso de la función de traducción está sujeto a los Términos y Condiciones de MyMemory (mymemory.translated.net/terms-and-conditions). No garantizamos la corrección, integridad o disponibilidad de las traducciones proporcionadas por este servicio.

5. Exclusión de garantías
La App se proporciona "tal cual", sin garantías de ningún tipo, explícitas o implícitas. En particular:
- No garantizamos que la App esté libre de errores o interrupciones.
- No garantizamos la calidad o exactitud de las traducciones automáticas.
- No somos responsables de eventuales pérdidas de datos debidas a fallos del dispositivo o de la App.

6. Limitación de responsabilidad
En la máxima medida permitida por la ley, no seremos responsables de daños directos, indirectos, incidentales o consecuentes derivados del uso o la imposibilidad de uso de la App, incluidos, entre otros, la pérdida de datos, la falta de contratación laboral o cualquier otra pérdida.

7. Gratuidad del servicio
La App es completamente gratuita. No existen compras dentro de la aplicación, suscripciones ni funciones de pago. Nos reservamos el derecho a modificar este aspecto en el futuro con un aviso adecuado.

8. Modificaciones de los Términos
Nos reservamos el derecho a modificar los presentes Términos en cualquier momento. Las modificaciones se publicarán en esta página con la fecha de actualización. El uso continuado de la App tras la publicación de las modificaciones constituye aceptación de los nuevos Términos.

9. Ley aplicable
Los presentes Términos se rigen por la ley italiana. Para cualquier controversia será competente el foro del lugar de residencia del usuario consumidor, conforme al Código del Consumo italiano.

10. Contacto
Para cuestiones relativas a los presentes Términos, contactar: fiorenzo9845@gmail.com''';

const _privacyBody = '''Política de Privacidad
Última actualización: 16 de abril de 2026

La presente política describe cómo la aplicación Cvío ("la App") trata los datos del usuario. La App está desarrollada y gestionada por Fiorenzo ("nosotros").

1. Datos recopilados
La App permite crear un currículum vítae (CV) introduciendo datos personales y profesionales como nombre, apellidos, correo electrónico, teléfono, dirección, experiencia laboral, formación, competencias y otros campos del CV.

Todos estos datos se guardan exclusivamente en local en el dispositivo del usuario. No disponemos de servidores que recopilen o almacenen los datos del CV. No creamos cuentas de usuario y no requerimos registro.

2. Servicio de traducción (MyMemory)
La App ofrece una función de traducción automática del CV a varios idiomas. Cuando el usuario utiliza esta función, el texto del CV se envía al servicio de traducción MyMemory, proporcionado por Translated srl (mymemory.translated.net).

El envío de datos a MyMemory se produce en dos casos:

- Cambio de idioma en la vista previa: cuando el usuario cambia el idioma de visualización del CV dentro de la App, los textos se traducen en tiempo real a través de MyMemory.

- Descarga ZIP multilingüe: cuando el usuario descarga el paquete ZIP que contiene el CV traducido a todos los idiomas, los textos se envían a MyMemory para la traducción.

Al utilizar estas funciones, el usuario acepta que:
- El texto del CV (incluidos datos personales como nombre, apellidos, experiencias laborales, etc.) se transmite a los servidores de MyMemory para el procesamiento de la traducción.
- MyMemory puede almacenar los segmentos de texto enviados, según sus propios Términos y Condiciones.
- No tenemos control sobre el tratamiento de los datos realizado por MyMemory.

Si el usuario no desea que el texto del CV se envíe a servicios externos, puede utilizar la App descargando el PDF en el idioma actual sin cambiar de idioma y sin utilizar la descarga ZIP multilingüe.

3. Generación del PDF
La generación del documento PDF se realiza íntegramente en local en el dispositivo. Durante este proceso no se transmite ningún dato a servidores externos.

4. Datos de almacenamiento local
La App utiliza el almacenamiento local del dispositivo para guardar:
- Los datos del CV introducidos por el usuario.
- Las preferencias de la App (p. ej., finalización del onboarding).

Estos datos permanecen en el dispositivo y pueden ser eliminados por el usuario en cualquier momento mediante la función "Eliminar Datos" en los ajustes de la App, o desinstalando la App.

5. Datos NO recopilados
La App:
- No recopila datos analíticos ni de uso.
- No utiliza cookies de seguimiento.
- No muestra publicidad.
- No requiere la creación de una cuenta.
- No comparte datos con terceros, excepto el servicio de traducción descrito en el punto 2.

6. Derechos del usuario
Dado que los datos se guardan exclusivamente en el dispositivo del usuario, este tiene pleno control sobre sus datos y puede eliminarlos en cualquier momento. Al no existir datos almacenados en nuestros servidores, no es necesaria ninguna solicitud de eliminación dirigida a nosotros.

7. Modificaciones de la Política de Privacidad
Cualquier modificación de esta política se publicará en esta página con la fecha de actualización. El uso continuado de la App tras la publicación de las modificaciones constituye aceptación de las mismas.

8. Contacto
Para cuestiones relativas a esta política, contactar: fiorenzo9845@gmail.com''';

const Map<String, String> esStrings = {
  'appTitle': 'Cvío',
  'appSubtitle': 'Crea tu currículum vitae profesional',
  'templateSelect': 'Elige Plantilla',
  'european': 'European Style',
  'modern': 'Moderno',
  'classic': 'Clásico Profesional',
  'minimal': 'Minimal',
  'sidebar': 'Sidebar',
  'executive': 'Ejecutivo',
  'europeanDesc': 'Formato de estilo europeo, elegante y bien estructurado',
  'modernDesc': 'Diseño limpio y minimalista, perfecto para el sector tech y creativo',
  'classicDesc': 'Diseño tradicional y profesional, ideal para entornos corporativos',
  'minimalDesc': 'Diseño tipográfico ultra limpio, ideal para creativos y diseñadores',
  'sidebarDesc': 'Panel lateral oscuro con contenido blanco, estilo Canva',
  'executiveDesc': 'Cabecera impactante con toques ámbar, perfecto para directivos',
  'step': 'Paso',
  'next': 'Siguiente',
  'prev': 'Atrás',
  'finish': 'Descargar CV',
  'personalInfo': 'Información Personal',
  'profile': 'Perfil Profesional',
  'experience': 'Experiencia Laboral',
  'education': 'Educación y Formación',
  'skills': 'Competencias',
  'languages': 'Idiomas',
  'projects': 'Proyectos',
  'certifications': 'Certificaciones',
  'volunteer': 'Voluntariado',
  'interests': 'Intereses',
  'firstName': 'Nombre',
  'lastName': 'Apellido',
  'email': 'Email',
  'phone': 'Teléfono',
  'address': 'Dirección',
  'birthDate': 'Fecha de Nacimiento',
  'nationality': 'Nacionalidad',
  'photo': 'Foto',
  'uploadPhoto': 'Subir Foto',
  'removePhoto': 'Eliminar Foto',
  'linkedin': 'LinkedIn',
  'website': 'Sitio Web',
  'profilePlaceholder': 'Describe brevemente tu perfil profesional, habilidades principales y objetivos...',
  'jobTitle': 'Puesto',
  'company': 'Empresa',
  'location': 'Ubicación',
  'startDate': 'Fecha Inicio',
  'endDate': 'Fecha Fin',
  'current': 'Actual',
  'description': 'Descripción',
  'addExperience': 'Añadir Experiencia',
  'removeExperience': 'Eliminar',
  'degree': 'Título',
  'institution': 'Institución',
  'addEducation': 'Añadir Educación',
  'skillName': 'Competencia',
  'skillLevel': 'Nivel',
  'addSkill': 'Añadir Competencia',
  'language': 'Idioma',
  'level': 'Nivel',
  'addLanguage': 'Añadir Idioma',
  'langLevel_A1': 'A1 - Principiante',
  'langLevel_A2': 'A2 - Elemental',
  'langLevel_B1': 'B1 - Intermedio',
  'langLevel_B2': 'B2 - Intermedio alto',
  'langLevel_C1': 'C1 - Avanzado',
  'langLevel_C2': 'C2 - Nativo/Bilingüe',
  'projectName': 'Nombre del Proyecto',
  'projectUrl': 'URL',
  'addProject': 'Añadir Proyecto',
  'certName': 'Certificación',
  'certIssuer': 'Entidad Certificadora',
  'certDate': 'Fecha',
  'addCertification': 'Añadir Certificación',
  'volunteerRole': 'Puesto',
  'volunteerOrg': 'Organización',
  'addVolunteer': 'Añadir Voluntariado',
  'interestsPlaceholder': 'Enumera tus intereses y aficiones...',
  'modernSections': 'Secciones Modernas',
  'modernSectionsDesc': 'Activa para mostrar secciones adicionales como Proyectos, Certificaciones, Voluntariado e Intereses',
  'reorderSections': 'Reordenar Secciones',
  'dragToReorder': 'Arrastra para reordenar',
  'downloadTitle': 'Descarga tu CV',
  'downloadSingle': 'Descargar PDF (idioma actual)',
  'downloadZip': 'Descargar ZIP (todos los idiomas)',
  'downloading': 'Generando...',
  'cancel': 'Cancelar',
  'italian': 'Italiano',
  'english': 'Inglés',
  'spanish': 'Español',
  'preview': 'Vista previa',
  'present': 'Presente',
  'settings': 'Configuración',
  'clearData': 'Borrar Datos',
  'clearDataConfirm': '¿Seguro que quieres borrar todos los datos del CV?',
  'clearDataYes': 'Borrar',
  'clearDataNo': 'Cancelar',
  'edit': 'Editar',
  'url': 'URL',
  'remove': 'Eliminar',
  // Onboarding
  'onboarding_welcome': 'Bienvenido a Cvío',
  'onboarding_welcome_desc': 'Crea tu CV profesional en minutos, listo para compartir.',
  'onboarding_templates': 'Elige tu estilo',
  'onboarding_templates_desc': 'Seis plantillas profesionales: Europeo, Moderno, Cl\u00e1sico, Minimal, Sidebar y Ejecutivo.',
  'onboarding_languages': 'Multiidioma autom\u00e1tico',
  'onboarding_languages_desc': 'Escribe en un idioma y descarga tu CV traducido a italiano, ingl\u00e9s y espa\u00f1ol.',
  'onboarding_start': 'Empezar',
  // Download success
  'done': '\u00a1Hecho!',
  'share': 'Compartir',
  'saveLocal': 'Guardar',
  'saving': 'Guardando...',
  'downloadSingleLabel': 'PDF — idioma actual',
  'downloadZipLabel': 'ZIP — todos los idiomas',
  // Legal
  'legalSection': 'Legal',
  'privacyPolicy': 'Pol\u00edtica de Privacidad',
  'termsOfService': 'T\u00e9rminos de Servicio',
  // Consent
  'consentAccept': 'Acepto',
  'consentAcceptAndStart': 'Aceptar y empezar a usar la app',
  'consentScrollHint': 'Despl\u00e1zate hasta el final para continuar',
  'tosBody': _tosBody,
  'privacyBody': _privacyBody,
};
