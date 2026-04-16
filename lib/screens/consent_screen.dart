import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import '../i18n/app_localizations.dart';
import 'home_screen.dart';

const _kSettingsBox = 'settings';
const _kConsentDone = 'consent_done';

Future<bool> isConsentComplete() async {
  final box = Hive.box(_kSettingsBox);
  return box.get(_kConsentDone, defaultValue: false) as bool;
}

Future<void> _markConsentComplete() async {
  final box = Hive.box(_kSettingsBox);
  await box.put(_kConsentDone, true);
}

// ─── Legal texts (plain text, embedded in-app) ──────────────────────────────

const _tosText = '''Termini di Servizio
Ultimo aggiornamento: 16 aprile 2026

I presenti Termini di Servizio ("Termini") regolano l'utilizzo dell'applicazione Cvío ("l'App"), sviluppata e gestita da Fiorenzo ("noi", "ci"). Utilizzando l'App, l'utente accetta i presenti Termini.

1. Descrizione del servizio
Cvío e un'applicazione gratuita che consente di creare curriculum vitae professionali in formato PDF. L'App offre diversi template, la possibilita di compilare il CV in piu sezioni e una funzione di traduzione automatica.

2. Utilizzo dell'App
L'utente si impegna a:
- Utilizzare l'App in conformita con le leggi applicabili.
- Inserire dati veritieri e di cui detiene i diritti.
- Non utilizzare l'App per scopi illeciti o fraudolenti.

3. Proprieta intellettuale
L'App, il suo codice sorgente, i template e il design sono di proprieta di Fiorenzo. L'utente mantiene la piena proprieta dei contenuti (testi e immagini) inseriti nel proprio CV.

4. Servizi di terze parti
L'App utilizza il servizio di traduzione MyMemory, fornito da Translated srl. L'utilizzo della funzione di traduzione e soggetto ai Termini e Condizioni di MyMemory (mymemory.translated.net/terms-and-conditions). Non garantiamo la correttezza, completezza o disponibilita delle traduzioni fornite da questo servizio.

5. Esclusione di garanzia
L'App e fornita "cosi com'e" senza garanzie di alcun tipo, esplicite o implicite. In particolare:
- Non garantiamo che l'App sia priva di errori o interruzioni.
- Non garantiamo la qualita o l'accuratezza delle traduzioni automatiche.
- Non siamo responsabili per eventuali perdite di dati dovute a malfunzionamenti del dispositivo o dell'App.

6. Limitazione di responsabilita
Nella misura massima consentita dalla legge, non saremo responsabili per danni diretti, indiretti, incidentali o consequenziali derivanti dall'uso o dall'impossibilita di utilizzare l'App, inclusi ma non limitati a perdita di dati, mancata assunzione o qualsiasi altra perdita.

7. Gratuita del servizio
L'App e completamente gratuita. Non sono previsti acquisti in-app, abbonamenti o funzionalita a pagamento. Ci riserviamo il diritto di modificare questo aspetto in futuro con adeguato preavviso.

8. Modifiche ai Termini
Ci riserviamo il diritto di modificare i presenti Termini in qualsiasi momento. Le modifiche saranno pubblicate su questa pagina con la data di aggiornamento. L'uso continuato dell'App dopo la pubblicazione delle modifiche costituisce accettazione dei nuovi Termini.

9. Legge applicabile
I presenti Termini sono regolati dalla legge italiana. Per qualsiasi controversia sara competente il foro del luogo di residenza dell'utente consumatore, ai sensi del Codice del Consumo.

10. Contatti
Per domande relative ai presenti Termini, contattare: fiorenzo9845@gmail.com''';

const _privacyText = '''Informativa sulla Privacy
Ultimo aggiornamento: 16 aprile 2026

La presente informativa descrive come l'applicazione Cvío ("l'App") tratta i dati dell'utente. L'App e sviluppata e gestita da Fiorenzo ("noi", "ci").

1. Dati raccolti
L'App consente di creare un curriculum vitae (CV) inserendo dati personali e professionali quali nome, cognome, email, telefono, indirizzo, esperienze lavorative, istruzione, competenze e altri campi del CV.

Tutti questi dati sono salvati esclusivamente in locale sul dispositivo dell'utente. Non disponiamo di server che raccolgono o memorizzano i dati del CV. Non creiamo account utente e non richiediamo registrazione.

2. Servizio di traduzione (MyMemory)
L'App offre una funzione di traduzione automatica del CV in piu lingue. Quando l'utente utilizza questa funzione, il testo del CV viene inviato al servizio di traduzione MyMemory, fornito da Translated srl (mymemory.translated.net).

L'invio dei dati a MyMemory avviene in due casi:

- Cambio lingua nell'anteprima: quando l'utente cambia la lingua di visualizzazione del CV all'interno dell'App, i testi vengono tradotti in tempo reale tramite MyMemory.

- Download ZIP multilingua: quando l'utente scarica il pacchetto ZIP contenente il CV tradotto in tutte le lingue, i testi vengono inviati a MyMemory per la traduzione.

Utilizzando queste funzioni, l'utente accetta che:
- Il testo del CV (inclusi dati personali come nome, cognome, esperienze lavorative, ecc.) viene trasmesso ai server di MyMemory per l'elaborazione della traduzione.
- MyMemory puo memorizzare i segmenti di testo inviati, secondo i propri Termini e Condizioni.
- Noi non abbiamo controllo sul trattamento dei dati effettuato da MyMemory.

Se l'utente non desidera che il testo del CV venga inviato a servizi esterni, puo utilizzare l'App scaricando il PDF nella lingua corrente senza cambiare lingua e senza utilizzare il download ZIP multilingua.

3. Generazione PDF
La generazione del documento PDF avviene interamente in locale sul dispositivo. Nessun dato viene trasmesso a server esterni durante questo processo.

4. Dati di archiviazione locale
L'App utilizza lo storage locale del dispositivo per salvare:
- I dati del CV inseriti dall'utente.
- Le preferenze dell'App (es. completamento dell'onboarding).

Questi dati restano sul dispositivo e possono essere cancellati dall'utente in qualsiasi momento tramite la funzione "Cancella Dati" nelle impostazioni dell'App, oppure disinstallando l'App.

5. Dati NON raccolti
L'App:
- Non raccoglie dati analitici o di utilizzo.
- Non utilizza cookie di tracciamento.
- Non mostra pubblicita.
- Non richiede la creazione di un account.
- Non condivide dati con terze parti, ad eccezione del servizio di traduzione descritto al punto 2.

6. Diritti dell'utente
Poiche i dati sono salvati esclusivamente sul dispositivo dell'utente, quest'ultimo ha pieno controllo sui propri dati e puo cancellarli in qualsiasi momento. Non essendoci dati memorizzati su nostri server, non e necessaria alcuna richiesta di cancellazione a noi.

7. Modifiche alla Privacy Policy
Eventuali modifiche a questa informativa saranno pubblicate su questa pagina con la data di aggiornamento. L'uso continuato dell'App dopo la pubblicazione delle modifiche costituisce accettazione delle stesse.

8. Contatti
Per domande relative a questa informativa, contattare: fiorenzo9845@gmail.com''';

// ─── Consent Screen ─────────────────────────────────────────────────────────

class ConsentScreen extends ConsumerStatefulWidget {
  const ConsentScreen({super.key});

  @override
  ConsumerState<ConsentScreen> createState() => _ConsentScreenState();
}

enum _ConsentStep { tos, loading, privacy }

class _ConsentScreenState extends ConsumerState<ConsentScreen> {
  _ConsentStep _step = _ConsentStep.tos;
  bool _scrolledToBottom = false;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrolledToBottom) return;
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 20) {
      setState(() => _scrolledToBottom = true);
    }
  }

  void _acceptTos() {
    setState(() {
      _step = _ConsentStep.loading;
      _scrolledToBottom = false;
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _step = _ConsentStep.privacy);
      // Reset scroll controller for new content
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(0);
        }
      });
    });
  }

  void _acceptPrivacyAndStart() async {
    await _markConsentComplete();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, _, _) => const HomeScreen(),
        transitionsBuilder: (_, anim, _, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = ref.watch(appLocalizationsProvider);

    if (_step == _ConsentStep.loading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              Text(
                l.t('privacyPolicy'),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final isTos = _step == _ConsentStep.tos;
    final title = isTos ? l.t('termsOfService') : l.t('privacyPolicy');
    final text = isTos ? _tosText : _privacyText;
    final buttonLabel = isTos ? l.t('consentAccept') : l.t('consentAcceptAndStart');
    final onPressed = isTos ? _acceptTos : _acceptPrivacyAndStart;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  Icon(
                    isTos ? Icons.description_outlined : Icons.privacy_tip_outlined,
                    color: Theme.of(context).colorScheme.primary,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            if (!_scrolledToBottom)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey.shade500),
                    const SizedBox(width: 4),
                    Text(
                      l.t('consentScrollHint'),
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            // ── Scrollable text ───────────────────────────────────────
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Scrollbar(
                    controller: _scrollController,
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.6,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // ── Bottom bar ────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: _scrolledToBottom ? onPressed : null,
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: Text(buttonLabel),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
