const _tosBody = '''Terms of Service
Last updated: April 16, 2026

These Terms of Service ("Terms") govern the use of the Cvío application ("the App"), developed and operated by Fiorenzo ("we", "us"). By using the App, the user accepts these Terms.

1. Service description
Cvío is a free application that lets users create professional resumes in PDF format. The App offers multiple templates, the ability to fill in the CV across several sections, and an automatic translation feature.

2. Use of the App
The user agrees to:
- Use the App in compliance with applicable laws.
- Enter truthful data to which they hold the rights.
- Not use the App for unlawful or fraudulent purposes.

3. Intellectual property
The App, its source code, templates and design are the property of Fiorenzo. The user retains full ownership of the content (texts and images) entered in their CV.

4. Third-party services
The App uses the MyMemory translation service, provided by Translated srl. Use of the translation feature is subject to MyMemory's Terms and Conditions (mymemory.translated.net/terms-and-conditions). We do not guarantee the correctness, completeness or availability of the translations provided by this service.

5. Disclaimer of warranties
The App is provided "as is" without warranties of any kind, express or implied. In particular:
- We do not guarantee that the App will be free of errors or interruptions.
- We do not guarantee the quality or accuracy of automatic translations.
- We are not responsible for any data loss caused by device or App malfunction.

6. Limitation of liability
To the maximum extent permitted by law, we shall not be liable for any direct, indirect, incidental or consequential damages arising from the use or inability to use the App, including but not limited to data loss, failure to obtain employment or any other loss.

7. Free service
The App is completely free. There are no in-app purchases, subscriptions or paid features. We reserve the right to change this in the future with appropriate prior notice.

8. Changes to the Terms
We reserve the right to modify these Terms at any time. Changes will be published on this page together with the update date. Continued use of the App after the publication of changes constitutes acceptance of the new Terms.

9. Applicable law
These Terms are governed by Italian law. For any dispute, the court of the consumer user's place of residence shall have jurisdiction, in accordance with the Italian Consumer Code.

10. Contact
For questions regarding these Terms, contact: cviomobilesupport@gmail.com''';

const _privacyBody = '''Privacy Policy
Last updated: April 16, 2026

This policy describes how the Cvío application ("the App") handles user data. The App is developed and operated by Fiorenzo ("we", "us").

1. Data collected
The App lets users create a curriculum vitae (CV) by entering personal and professional data such as first name, last name, email, phone, address, work experience, education, skills and other CV fields.

All this data is stored exclusively locally on the user's device. We do not operate servers that collect or store CV data. We do not create user accounts and do not require registration.

2. Translation service (MyMemory)
The App offers an automatic CV translation feature into multiple languages. When the user uses this feature, the CV text is sent to the MyMemory translation service, provided by Translated srl (mymemory.translated.net).

Data is sent to MyMemory in two cases:

- Language change in the preview: when the user changes the CV display language within the App, the text is translated in real time via MyMemory.

- Multi-language ZIP download: when the user downloads the ZIP package containing the CV translated into all languages, the text is sent to MyMemory for translation.

By using these features, the user accepts that:
- The CV text (including personal data such as first name, last name, work experience, etc.) is transmitted to MyMemory's servers for translation processing.
- MyMemory may retain the text segments sent, according to its own Terms and Conditions.
- We have no control over the data processing carried out by MyMemory.

If the user does not wish for the CV text to be sent to external services, they can use the App by downloading the PDF in the current language without changing language and without using the multi-language ZIP download.

3. PDF generation
PDF document generation takes place entirely locally on the device. No data is transmitted to external servers during this process.

4. Local storage data
The App uses the device's local storage to save:
- The CV data entered by the user.
- App preferences (e.g. onboarding completion).

This data remains on the device and can be deleted by the user at any time using the "Delete Data" function in the App's settings, or by uninstalling the App.

5. Data NOT collected
The App:
- Does not collect analytics or usage data.
- Does not use tracking cookies.
- Does not display advertising.
- Does not require account creation.
- Does not share data with third parties, except for the translation service described in point 2.

6. User rights
Since data is stored exclusively on the user's device, the user has full control over their data and can delete it at any time. Because no data is stored on our servers, no deletion request needs to be made to us.

7. Changes to the Privacy Policy
Any changes to this policy will be published on this page together with the update date. Continued use of the App after the publication of changes constitutes acceptance of such changes.

8. Contact
For questions regarding this policy, contact: cviomobilesupport@gmail.com''';

const Map<String, String> enStrings = {
  'appTitle': 'Cvío',
  'appSubtitle': 'Create your professional curriculum vitae',
  'templateSelect': 'Choose Template',
  'european': 'European Style',
  'modern': 'Modern',
  'classic': 'Classic Professional',
  'minimal': 'Minimal',
  'sidebar': 'Sidebar',
  'executive': 'Executive',
  'europeanDesc': 'European-style format, elegant and well-structured',
  'modernDesc': 'Clean and minimal design, perfect for tech and creative fields',
  'classicDesc': 'Traditional and professional layout, ideal for corporate environments',
  'minimalDesc': 'Ultra clean typographic layout, ideal for creatives and designers',
  'sidebarDesc': 'Dark sidebar panel with white main content, Canva-inspired style',
  'executiveDesc': 'Bold header with amber accents, perfect for managers and executives',
  'step': 'Step',
  'next': 'Next',
  'prev': 'Back',
  'finish': 'Download CV',
  'personalInfo': 'Personal Information',
  'profile': 'Professional Profile',
  'experience': 'Work Experience',
  'education': 'Education',
  'skills': 'Skills',
  'languages': 'Languages',
  'projects': 'Projects',
  'certifications': 'Certifications',
  'volunteer': 'Volunteer Work',
  'interests': 'Interests',
  'firstName': 'First Name',
  'lastName': 'Last Name',
  'email': 'Email',
  'phone': 'Phone',
  'address': 'Address',
  'birthDate': 'Date of Birth',
  'nationality': 'Nationality',
  'photo': 'Photo',
  'uploadPhoto': 'Upload Photo',
  'removePhoto': 'Remove Photo',
  'linkedin': 'LinkedIn',
  'website': 'Website',
  'profilePlaceholder': 'Briefly describe your professional profile, main skills and goals...',
  'jobTitle': 'Job Title',
  'company': 'Company',
  'location': 'Location',
  'startDate': 'Start Date',
  'endDate': 'End Date',
  'current': 'Current',
  'description': 'Description',
  'addExperience': 'Add Experience',
  'removeExperience': 'Remove',
  'degree': 'Degree',
  'institution': 'Institution',
  'addEducation': 'Add Education',
  'skillName': 'Skill',
  'skillLevel': 'Level',
  'addSkill': 'Add Skill',
  'language': 'Language',
  'level': 'Level',
  'addLanguage': 'Add Language',
  'langLevel_A1': 'A1 - Beginner',
  'langLevel_A2': 'A2 - Elementary',
  'langLevel_B1': 'B1 - Intermediate',
  'langLevel_B2': 'B2 - Upper Intermediate',
  'langLevel_C1': 'C1 - Advanced',
  'langLevel_C2': 'C2 - Native/Bilingual',
  'projectName': 'Project Name',
  'projectUrl': 'URL',
  'addProject': 'Add Project',
  'certName': 'Certification',
  'certIssuer': 'Issuing Authority',
  'certDate': 'Date',
  'addCertification': 'Add Certification',
  'volunteerRole': 'Role',
  'volunteerOrg': 'Organization',
  'addVolunteer': 'Add Volunteer Work',
  'interestsPlaceholder': 'List your interests and hobbies...',
  'modernSections': 'Modern Sections',
  'modernSectionsDesc': 'Enable to show additional sections like Projects, Certifications, Volunteer Work and Interests',
  'reorderSections': 'Reorder Sections',
  'dragToReorder': 'Drag to reorder',
  'downloadTitle': 'Download your CV',
  'downloadSingle': 'Download PDF (current language)',
  'downloadZip': 'Download ZIP (all languages)',
  'downloading': 'Generating...',
  'cancel': 'Cancel',
  'italian': 'Italian',
  'english': 'English',
  'spanish': 'Spanish',
  'preview': 'Preview',
  'present': 'Present',
  'settings': 'Settings',
  'clearData': 'Clear Data',
  'clearDataConfirm': 'Are you sure you want to clear all CV data?',
  'clearDataYes': 'Clear',
  'clearDataNo': 'Cancel',
  'edit': 'Edit',
  'url': 'URL',
  'remove': 'Remove',
  // Onboarding
  'onboarding_welcome': 'Welcome to Cvío',
  'onboarding_welcome_desc': 'Create your professional CV in minutes, ready to share.',
  'onboarding_templates': 'Choose your style',
  'onboarding_templates_desc': 'Six professional templates to choose from: European, Modern, Classic, Minimal, Sidebar and Executive.',
  'onboarding_languages': 'Automatic multilingual',
  'onboarding_languages_desc': 'Write in one language and download your CV translated into Italian, English and Spanish.',
  'onboarding_start': 'Get Started',
  // Download success
  'done': 'Done!',
  'share': 'Share',
  'saveLocal': 'Save',
  'saving': 'Saving...',
  'downloadSingleLabel': 'PDF — current language',
  'downloadZipLabel': 'ZIP — all languages',
  // Legal
  'legalSection': 'Legal',
  'privacyPolicy': 'Privacy Policy',
  'termsOfService': 'Terms of Service',
  // Consent
  'consentAccept': 'I Accept',
  'consentAcceptAndStart': 'Accept and start using the app',
  'consentScrollHint': 'Scroll to the bottom to continue',
  'tosBody': _tosBody,
  'privacyBody': _privacyBody,
};
