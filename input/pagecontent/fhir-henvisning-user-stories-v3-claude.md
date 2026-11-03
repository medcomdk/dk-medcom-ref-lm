<div class="stu-note">
  <p><b>Bemærk: Dette er en disclaimer for denne side om "User stories for FHIR-baseret henvisningshåndtering"</b></p>
  <p>
    Oversigten er en mock-up på user stories og diagrammer og er på ingen måde nødvendigvis fuldt dækkende og fuldt retvisende. Det forsøges til stadighed at blive mere dækkende og mere retvisende.
    <br/><br/>
    Oversigten og diagrammerne er delvist udarbejdet sammen med AI-værktøjerne Clause og ChatGPT, så justeringer efter deres forslag må påregnes.
    <br/><br/>
    Oversigten vil være velegnet til en dialog med de rette aktører om henvisningsaktiviteter på hhv Henviser- og Visitator-siden samt dialogen imellem dem.
  </p>
</div>

## User stories for FHIR-baseret henvisningshåndtering

Oversigten beskriver user stories for de to primære roller i et FHIR-baseret henvisningsflow:

> **Henviser** (den der afsender en henvisning)  
> **Visitator** (den der modtager og triagerer).

Derudover beskrives user stories der kun opstår i den fælles udvekslingsdialog mellem de to parter. Al kommunikation foregår via FHIR-baserede meddelelser.

Oversigten er suppleret med user stories for tre yderligere roller:

> **Centralvisitator** (den der kanaliserer henvisninger videre til de relevante specialenheder)  
> **Patient** (den der henvises)  
> **Administrator** (den der følger henvisningsprocessen på aggregeret niveau).

**Begreber og konventioner i denne version:**

> - **Henvisningsmodtager = Visitator.** I de nyeste input anvendes "henvisningsmodtager". Her anvendes "visitator" konsekvent, som i de oprindelige user stories.
> - **Nummerering:** De oprindelige user stories (1.1-1.6, 2.1-2.6 og 3.1-3.6) har bevaret deres numre, så referencer til diagrammer og øvrige sider stadig passer. Nye user stories er nummereret fortløbende efter de oprindelige i hver sektion (1.7 ff., 2.7 ff., 3.7 ff.). Nye roller har egne sektioner (4, 5 og 6).
> - **Oprindelse:** Hver user story er markeret med én af tre værdier i feltet *Oprindelse*: **Eksisterende** (uændret), **Flettet** (eksisterende og ny user story i princippet den samme, og de er slået sammen) eller **Ny**.
> - **FHIR-ressourcer med \*** er et foreslået udgangspunkt for de nye user stories og ikke endeligt afklaret.

## User story oversigt med FHIR ressource

| User story                                                                                                   | FHIR-ressource(r)                                                | Retning                                | Oprindelse                         |
|--------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------|----------------------------------------|------------------------------------|
| [Oprette henvisning](#user-story-11-oprette-en-ny-henvisning)                                                | ServiceRequest                                                   | Henviser → Visitator                   | **Flettet** (1.1 + ny)             |
| [Tilknytte dokumentation](#user-story-12-tilknytte-klinisk-dokumentation)                                    | DiagnosticReport, Media, DocumentReference                       | Henviser → Visitator                   | **Flettet** (1.2 + ny)             |
| [Ændre henvisning](#user-story-13-%C3%A6ndre-en-afsendt-henvisning)                                          | ServiceRequest (revision)                                        | Henviser → Visitator                   | Eksisterende                       |
| [Tilbagekalde henvisning](#user-story-14-tilbagekalde-en-henvisning)                                         | ServiceRequest (revoked)                                         | Henviser → Visitator                   | Eksisterende                       |
| [Monitorere status](#user-story-15-monitorere-status-p%C3%A5-afsendte-henvisninger)                          | Subscription, SubscriptionStatus                                 | Begge                                  | Eksisterende                       |
| [Modtage afgørelse](#user-story-16-modtage-afg%C3%B8relse-fra-visitatoren)                                   | Task, SubscriptionNotification                                   | Visitator → Henviser                   | **Flettet** (1.6 + 2 nye)          |
| [Ensartet national henvisningsproces](#user-story-17-ensartet-national-henvisningsproces)                    | Nationale profiler af ServiceRequest\*                           | Henviser → Visitator                   | Ny                                 |
| [Finde relevant undersøgelse/behandling](#user-story-18-finde-relevant-unders%C3%B8gelse-eller-behandling)   | PlanDefinition, HealthcareService, Organization\*                | Henviser (internt)                     | Ny                                 |
| [Hjælp til at udfylde henvisning](#user-story-19-f%C3%A5-hj%C3%A6lp-til-at-udfylde-henvisningen)             | Questionnaire, QuestionnaireResponse, PlanDefinition\*           | Henviser (internt)                     | Ny                                 |
| [Importere data fra journalsystem](#user-story-110-importere-data-fra-journalsystemet)                       | Condition, Observation, MedicationStatement\*                    | Henviser (internt)                     | Ny                                 |
| [Samme dag under samme tag](#user-story-111-angive-behov-for-samme-dag-under-samme-tag)                      | ServiceRequest (extension)\*                                     | Henviser → Visitator                   | Ny                                 |
| [Sammenkoble henvisninger](#user-story-112-sammenkoble-henvisninger-og-angive-r%C3%A6kkef%C3%B8lge)          | ServiceRequest (basedOn/requisition, extension)\*                | Henviser → Visitator                   | Ny                                 |
| [Markere som færdig](#user-story-113-markere-henvisning-som-f%C3%A6rdig)                                     | ServiceRequest (status), Task\*                                  | Henviser → Visitator                   | Ny                                 |
| [Se årsag til afvisning](#user-story-114-se-%C3%A5rsag-til-afvist-henvisning)                                | Task, ServiceRequest\*                                           | Visitator → Henviser                   | Ny                                 |
| [Tilrette afvist henvisning](#user-story-115-tilrette-og-gensende-afvist-henvisning)                         | ServiceRequest (revision), Task\*                                | Henviser → Visitator                   | Ny                                 |
| [Se videresendelse](#user-story-116-se-at-henvisning-er-videresendt)                                         | ServiceRequest (replaces), SubscriptionNotification\*            | Visitator → Henviser                   | Ny                                 |
| [Se booking](#user-story-117-se-at-patienten-er-booket)                                                      | Appointment, SubscriptionNotification\*                          | Visitator → Henviser                   | Ny                                 |
| [Modtage og kvittere](#user-story-21-modtage-og-kvittere-for-ny-henvisning)                                  | Bundle, MessageHeader                                            | Visitator (intern)                     | Eksisterende                       |
| [Triagere og prioritere](#user-story-22-triagere-og-prioritere-en-henvisning)                                | Task                                                             | Visitator (intern)                     | Eksisterende                       |
| [Acceptere og booke](#user-story-23-acceptere-en-henvisning-og-booke-forl%C3%B8b)                            | ServiceRequest, Appointment                                      | Visitator → Henviser                   | **Flettet** (2.3 + 2 nye)          |
| [Afvise henvisning](#user-story-24-afvise-en-henvisning)                                                     | Task, ServiceRequest                                             | Visitator → Henviser                   | **Flettet** (2.4 + 2 nye)          |
| [Videresende](#user-story-25-videresende-til-anden-modtager)                                                 | ServiceRequest (replaces)                                        | Visitator → Ny modtager (Ny Visitator) | **Flettet** (2.5 + ny)             |
| [Ændre prioritet](#user-story-26-%C3%A6ndre-prioritet-p%C3%A5-en-modtaget-henvisning)                        | ServiceRequest, SubscriptionNotification                         | Visitator → Henviser                   | Eksisterende                       |
| [Se og vurdere færdig henvisning](#user-story-27-se-og-vurdere-f%C3%A6rdig-henvisning)                       | ServiceRequest, Task\*                                           | Henviser → Visitator                   | Ny                                 |
| [Modtage fyldestgørende henvisninger](#user-story-28-modtage-fyldestg%C3%B8rende-henvisninger)               | ServiceRequest, Questionnaire\*                                  | Henviser → Visitator                   | Ny                                 |
| [Vedligeholde vejledninger](#user-story-29-vedligeholde-patientforl%C3%B8bsbeskrivelser-og-henvisningsvejledninger) | PlanDefinition, ActivityDefinition, DocumentReference\*   | Visitator → Henviser                   | Ny                                 |
| [Hente accepteret henvisning](#user-story-210-hente-accepteret-henvisning-til-eget-journalsystem)            | ServiceRequest, DocumentReference, Bundle\*                      | Visitator (intern)                     | Ny                                 |
| [Se sammenkoblede henvisninger](#user-story-211-se-sammenkoblede-henvisninger-og-samme-dag-under-samme-tag)  | ServiceRequest (extension)\*                                     | Visitator (intern)                     | Ny                                 |
| [Anmode om supplement](#user-story-31-anmode-om-supplerende-oplysninger)                                     | CommunicationRequest                                             | Visitator → Henviser                   | Eksisterende                       |
| [Besvare supplement](#user-story-32-besvare-anmodning-om-supplement)                                         | Communication                                                    | Henviser → Visitator                   | Eksisterende                       |
| [Faglig afklaring](#user-story-33-faglig-afklaring-i-dialog)                                                 | Communication (thread)                                           | Begge                                  | Eksisterende                       |
| [Statusnotifikation](#user-story-34-statusnotifikation-til-henviser)                                         | SubscriptionNotification                                         | Visitator → Henviser                   | Eksisterende                       |
| [Alternativ visitation](#user-story-35-aftale-om-alternativ-visitation)                                      | Communication, Task                                              | Begge                                  | Eksisterende                       |
| [Korrektionsaftale](#user-story-36-korrektionsaftale-om-fejl-i-afsendt-henvisning)                           | Communication, ServiceRequest                                    | Begge                                  | Eksisterende                       |
| [Dialog under udfyldelse](#user-story-37-skriftlig-dialog-under-udfyldelse-af-henvisning)                    | Communication, ServiceRequest (draft)\*                          | Begge                                  | **Flettet** (2 nye)                |
| [Dele henvisningsudkast](#user-story-38-dele-henvisningsudkast-med-modtager)                                 | ServiceRequest (draft)\*                                         | Henviser → Visitator                   | **Flettet** (2 nye)                |
| [Adskilt dialog-indbakke](#user-story-39-adskilt-indbakke-til-henvisningsdialog)                             | Communication (category)\*                                       | Begge                                  | Ny                                 |
| [Overblik i centralvisitation](#user-story-41-overblik-over-f%C3%A6rdige-henvisninger-i-centralvisitation)   | ServiceRequest, Task\*                                           | Centralvisitator (intern)              | Ny                                 |
| [Patient: se status](#user-story-51-se-status-for-min-henvisning)                                            | ServiceRequest, Task\*                                           | System → Patient                       | Ny                                 |
| [Patient: se henvisninger og bilag](#user-story-52-se-mine-henvisninger-inklusive-bilag)                     | ServiceRequest, DocumentReference\*                              | System → Patient                       | Ny                                 |
| [Patient: se beskeder om bookinger](#user-story-53-se-beskeder-om-mine-bookinger)                            | Communication, Appointment\*                                     | System → Patient                       | Ny                                 |
| [Statistik: overblik](#user-story-61-adgang-til-anonymiseret-henvisningsstatistik)                           | Measure, MeasureReport\*                                         | System → Administrator                 | Ny                                 |
| [Statistik: statusser](#user-story-62-statistik-over-henvisningsstatusser)                                   | Measure, MeasureReport\*                                         | System → Administrator                 | Ny                                 |
| [Statistik: diagnoser](#user-story-63-statistik-over-henvisningsdiagnoser)                                   | Measure, MeasureReport\*                                         | System → Administrator                 | Ny                                 |
| [Statistik: afvisningsårsager](#user-story-64-statistik-over-%C3%A5rsager-til-afviste-henvisninger)          | Measure, MeasureReport\*                                         | System → Administrator                 | Ny                                 |
| [Statistik: videresendelser](#user-story-65-statistik-over-videresendte-henvisninger)                        | Measure, MeasureReport\*                                         | System → Administrator                 | Ny                                 |
| {: .grid}                                                                                                    |                                                                  |                                        |                                    |

**Oversigt over fletninger:**

| Eksisterende user story | Flettet med ny user story (rolle: tekst)                                                                                                              |
|-------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|
| 1.1                     | Henviser: "kunne henvise min patient digitalt til specialiseret undersøgelse og/eller behandling"                                                     |
| 1.2                     | Henviser: "kunne vedhæfte filer til min henvisning"                                                                                                   |
| 1.6                     | Henviser: "kunne se om henvisningen er afvist af henvisningsmodtager" og "kunne se om henvisningen er accepteret"                                     |
| 2.3                     | Henvisningsmodtager: "kunne angive at henvisningen er accepteret" og "kunne sende besked til henviser, når patienten bookes"                          |
| 2.4                     | Henvisningsmodtager: "kunne afvise en færdig henvisning" og "kunne angive årsagen til en afvist henvisning"                                           |
| 2.5                     | Henvisningsmodtager: "kunne sende henvisningen videre til en anden modtager"                                                                          |
| 3.7 (ny)                | Henviser: "hurtig og direkte skriftlig dialog med henvisningsmodtager" og Henvisningsmodtager: "kommunikere hurtigt og nemt på skrift med henviser"   |
| 3.8 (ny)                | Henviser: "henvisningsmodtager kan se henvisningen, selvom den ikke er færdig" og Henvisningsmodtager: "se henvisningen når den er under udfyldelse"  |
| {: .grid}               |                                                                                                                                                       |

**Diagrammer:**

> - Hver oprindelig user storie refererer til et tilhørende PlantUML-diagram i filen `fhir-henvisning-use-cases-claude2.puml`.  
> - Filen indeholder 18 `@startuml`-blokke, én per oprindelig user storie, og kan renderes enkeltvis via PlantUML-CLI (`-p <diagram-id>`) eller i editorer med PlantUML-understøttelse (VS Code, IntelliJ, Confluence o.l.).  
> - Diagrammerne kan også gengives samlet ved at ekskludere `!include`-direktiverne og blot åbne `.puml`-filen direkte.  
> - De nye user stories (1.7-1.17, 2.7-2.11, 3.7-3.9, 4.1, 5.1-5.3 og 6.1-6.5) har endnu ikke et tilhørende diagram.

* * *

## Henviserens user stories

Disse user stories udføres primært af henviseren, uden at kræve aktiv respons fra visitatoren ud over systemkvittering. Enkelte user stories handler om henviserens indsigt i visitatorens handlinger (fx afgørelse, videresendelse og booking).

### User story 1.1 Oprette en ny henvisning

> **User story:**  
> Som henviser ønsker jeg at kunne oprette og afsende en struktureret henvisning digitalt via FHIR,  
> når jeg har truffet en klinisk beslutning om at viderehenvise min patient, fordi jeg ikke selv kan opfylde patientens behov for undersøgelse, diagnosticering og/eller behandling,  
> så visitatoren modtager alle nødvendige oplysninger på et standardiseret format, og patienten hurtigst muligt kan komme videre i sit forløb.

[![UC-1-1-Oprette-henvisning](UC-1-1-Oprette-henvisning.svg)](UC-1-1-Oprette-henvisning.svg)

Henviseren udfærdiger og afsender en ny henvisning til et modtagende tilbud. Henvisningen repræsenteres som en `ServiceRequest`-ressource med status `proposed` og sendes i en FHIR-`Bundle`. Henvisningen indeholder patientoplysninger, indikation, hastegrad og ønsket ydelse.

|---|---|
| **Oprindelse:** | **Flettet**: eksisterende 1.1 + ny user story (Henviser: "kunne henvise min patient digitalt til specialiseret undersøgelse og/eller behandling") |
| **Primær FHIR-ressource:** | `ServiceRequest` |
| **Triggerhændelse:** | Klinisk beslutning om at henvise patient, når henviser ikke selv kan opfylde patientens behov |
| **Forrige trin:** | ← [1.9 Få hjælp til at udfylde henvisningen](#user-story-19-f%C3%A5-hj%C3%A6lp-til-at-udfylde-henvisningen) *(hvis henvisningen udfyldes med hjælp)* ·  <br/>← [1.15 Tilrette og gensende afvist henvisning](#user-story-115-tilrette-og-gensende-afvist-henvisning) *(gensendelse efter afvisning)* |
| **Næste trin:** | → [1.2 Tilknytte klinisk dokumentation](#user-story-12-tilknytte-klinisk-dokumentation) *(hvis supplerende materiale er relevant)* ·  <br/>→ [2.1 Modtage og kvittere for ny henvisning](#user-story-21-modtage-og-kvittere-for-ny-henvisning) *(visitatorsiden modtager)* |
{: .grid}

### User story 1.2 Tilknytte klinisk dokumentation

> **User story:**  
> Som henviser ønsker jeg at kunne vedhæfte relevant klinisk dokumentation og filer til en eksisterende henvisning,  
> når jeg vurderer at visitatoren har brug for supplerende materiale, eller der er oplysninger i særskilte filer som skal sendes med henvisningen,  
> så beslutningsgrundlaget er samlet ét sted, og jeg undgår at indtaste oplysningerne manuelt.

[![UC-1-2-Tilknytte-dokumentation](UC-1-2-Tilknytte-dokumentation.svg)](UC-1-2-Tilknytte-dokumentation.svg)

Henviseren vedhæfter supplerende klinisk materiale til en eksisterende henvisning, fx laboratoriesvar, billeddiagnostik, tidligere epikriser eller andre særskilte filer. Materialet knyttes til `ServiceRequest`-ressourcen via referencer til `DiagnosticReport`, `Media` eller `DocumentReference`.

|---|---|
| **Oprindelse:** | **Flettet**: eksisterende 1.2 + ny user story (Henviser: "kunne vedhæfte filer til min henvisning") |
| **Primær FHIR-ressource:** | `DiagnosticReport`, `Media`, `DocumentReference` |
| **Triggerhændelse:** | Behov for at understøtte klinisk beslutningsgrundlag, eller oplysninger der foreligger i særskilte filer |
| **Forrige trin:** | ← [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) *(hvis supplerende materiale er relevant)* ·  <br/>← [1.10 Importere data fra journalsystemet](#user-story-110-importere-data-fra-journalsystemet) *(importerede dokumenter vedhæftes)* |
| **Næste trin:** | → [2.1 Modtage og kvittere for ny henvisning](#user-story-21-modtage-og-kvittere-for-ny-henvisning) *(visitatoren modtager den berigede henvisning)* |
{: .grid}

### User story 1.3 Ændre en afsendt henvisning

> **User story:**  
> Som henviser ønsker jeg at kunne rette indholdet i en allerede afsendt henvisning,  
> når jeg opdager en fejl eller patientens kliniske situation ændrer sig,  
> så visitatoren altid arbejder ud fra korrekte og aktuelle oplysninger.

[![UC-1-3-Aendre-henvisning](UC-1-3-Aendre-henvisning.svg)](UC-1-3-Aendre-henvisning.svg)

Henviseren opdaterer indholdet af en allerede afsendt henvisning, fx korrigerer indikation, hastegrad eller kontaktoplysninger. Opdateringen sker via en opdatering på den eksisterende `ServiceRequest`, og der sættes et revisionsflag så visitatoren notificeres om ændringen.

|---|---|
| **Oprindelse:** | Eksisterende |
| **Primær FHIR-ressource:** | `ServiceRequest` (revision) |
| **Triggerhændelse:** | Fejl opdaget eller klinisk situation ændret efter afsendelse |
| **Forrige trin:** | ← [3.6 Korrektionsaftale](#user-story-36-korrektionsaftale-om-fejl-i-afsendt-henvisning) *(visitatoren anmoder om korrektion)* |
| **Næste trin:** | → [2.2 Triagere og prioritere en henvisning](#user-story-22-triagere-og-prioritere-en-henvisning) *(visitatoren modtager ændringsnotifikation og revurderer)* |
{: .grid}

### User story 1.4 Tilbagekalde en henvisning

> **User story:**  
> Som henviser ønsker jeg at kunne tilbagekalde en afsendt henvisning,  
> når patienten ikke længere ønsker forløbet eller det kliniske grundlag er bortfaldet,  
> så visitatoren ikke bruger ressourcer på en henvisning der ikke skal ekspederes.

[![UC-1-4-Tilbagekalde-henvisning](UC-1-4-Tilbagekalde-henvisning.svg)](UC-1-4-Tilbagekalde-henvisning.svg)

Henviseren annullerer en afsendt henvisning, der endnu ikke er ekspederet. `ServiceRequest`-status sættes til `revoked` og en notifikation sendes til visitatoren.

|---|---|
| **Oprindelse:** | Eksisterende |
| **Primær FHIR-ressource:** | `ServiceRequest` (status = revoked) |
| **Triggerhændelse:** | Patienten ønsker ikke forløbet, eller klinisk grundlag er bortfaldet |
| **Forrige trin:** | ← [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) *(afsender ønsker at tilbagekalde)* |
| **Næste trin:** | *(Flowet afsluttes, ingen yderligere behandling påkrævet)* |
{: .grid}

### User story 1.5 Monitorere status på afsendte henvisninger

> **User story:**  
> Som henviser ønsker jeg løbende at kunne se status på mine afsendte og udestående henvisninger,  
> når jeg har behov for overblik over patienternes videre forløb,  
> så jeg kan følge op og informere patienterne korrekt.

[![UC-1-5-Monitorere-status](UC-1-5-Monitorere-status.svg)](UC-1-5-Monitorere-status.svg)

Henviseren følger løbende op på status for egne udestående henvisninger. Dette kan ske via FHIR-subscription (push) eller ved periodisk polling mod visitatorens FHIR-endpoint.

|---|---|
| **Oprindelse:** | Eksisterende |
| **Primær FHIR-ressource:** | `Subscription`, `SubscriptionStatus`, `ServiceRequest` |
| **Triggerhændelse:** | Behov for overblik over egne afsendte henvisninger |
| **Forrige trin:** | ← [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) *(efter afsendelse ønskes overblik)* |
| **Næste trin:** | → [1.6 Modtage afgørelse fra visitatoren](#user-story-16-modtage-afg%C3%B8relse-fra-visitatoren) *(statusoverblikket leder til modtagelse af den endelige afgørelse)* ·  <br/>→ [1.16 Se at henvisning er videresendt](#user-story-116-se-at-henvisning-er-videresendt) ·  <br/>→ [1.17 Se at patienten er booket](#user-story-117-se-at-patienten-er-booket) |
{: .grid}

### User story 1.6 Modtage afgørelse fra visitatoren

> **User story:**  
> Som henviser ønsker jeg automatisk at modtage visitatorens afgørelse i mit journalsystem, og hurtigt kunne se om henvisningen er accepteret eller afvist,  
> når jeg har angivet en henvisning som færdig, og visitatoren har truffet beslutning om accept, afvisning eller alternativt tilbud,  
> så jeg ved at visitationsprocessen er i gang (accept), eller får hurtig besked om en bremset visitationsproces (afvisning), og dermed hurtigt kan handle og orientere patienten.

[![UC-1-6-Modtage-afgoerelse](UC-1-6-Modtage-afgoerelse.svg)](UC-1-6-Modtage-afgoerelse.svg)

Henviseren modtager visitatorens endelige afgørelse (accept, afvisning eller alternativt tilbud) og integrerer denne i eget journalsystem. Afgørelsen leveres som en `Task`-ressource eller notifikation med reference til den oprindelige `ServiceRequest`.

|---|---|
| **Oprindelse:** | **Flettet**: eksisterende 1.6 + to nye user stories (Henviser: "kunne se om henvisningen er afvist af henvisningsmodtager" og "kunne se om henviser [sic: henvisningsmodtager] har accepteret min henvisning") |
| **Primær FHIR-ressource:** | `Task`, `SubscriptionNotification` |
| **Triggerhændelse:** | Visitatoren har truffet afgørelse om henvisningen |
| **Forrige trin:** | ← [1.5 Monitorere status](#user-story-15-monitorere-status-p%C3%A5-afsendte-henvisninger) *(statusoverblikket leder hertil)* ·  <br/>← [3.4 Statusnotifikation](#user-story-34-statusnotifikation-til-henviser) *(notifikation udløser håndtering)* ·  <br/>← [1.13 Markere henvisning som færdig](#user-story-113-markere-henvisning-som-f%C3%A6rdig) *(færdig henvisning er overdraget til visitation)* |
| **Næste trin:** | → [1.14 Se årsag til afvist henvisning](#user-story-114-se-%C3%A5rsag-til-afvist-henvisning) *(hvis afgørelsen er en afvisning)* ·  <br/>→ [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) *(hvis afgørelsen er en afvisning og patienten skal viderehenvises)* ·  <br/>*(Flowet afsluttes ved accept)* |
{: .grid}

### User story 1.7 Ensartet national henvisningsproces

> **User story:**  
> Som henviser ønsker jeg at henvisningsprocessen er den samme uanset hvilken rolle, speciale og geografisk placering henviser og modtager har,  
> når jeg skal henvise min patient,  
> så henvisningsprocessen er ensrettet på nationalt plan og ikke påvirkes af lokale aftaler.

Henvisningsprocessen understøttes af nationale, fælles FHIR-profiler og en fælles procesbeskrivelse, så de samme trin, data og statusser gælder for alle henvisere og modtagere. Lokale tilpasninger sker inden for rammerne af de nationale profiler. Denne user story er tværgående og stiller krav til alle øvrige user stories.

|---|---|
| **Oprindelse:** | Ny |
| **Primær FHIR-ressource:** | Nationale profiler af `ServiceRequest` m.fl.\* |
| **Triggerhændelse:** | Henviser skal henvise en patient, uanset rolle, speciale og geografi |
| **Forrige trin:** | *(Tværgående, ingen bestemt forgænger)* |
| **Næste trin:** | → [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) |
{: .grid}

### User story 1.8 Finde relevant undersøgelse eller behandling

> **User story:**  
> Som henviser ønsker jeg at få hjælp til at finde den rette/relevante specialiserede undersøgelse og/eller behandling i patientens nærområde,  
> når jeg har skrevet et notat som beskriver grundlaget for henvisningen og angiver patientens symptomer/problemstillinger,  
> så jeg kan spare tid på at finde et relevant behandlingstilbud eller den relevante patientforløbsbeskrivelse på sundhed.dk.

Ud fra notatets indhold foreslås relevante behandlingstilbud i patientens nærområde og de tilhørende patientforløbsbeskrivelser, som henviseren kan vælge imellem. Valget bruges som udgangspunkt for henvisningens modtager og ydelse.

|---|---|
| **Oprindelse:** | Ny |
| **Primær FHIR-ressource:** | `PlanDefinition`, `HealthcareService`, `Organization`\* |
| **Triggerhændelse:** | Notat om henvisningsgrundlag og symptomer/problemstillinger er skrevet |
| **Forrige trin:** | *(Henviser har skrevet et notat i journalsystemet)* |
| **Næste trin:** | → [1.9 Få hjælp til at udfylde henvisningen](#user-story-19-f%C3%A5-hj%C3%A6lp-til-at-udfylde-henvisningen) ·  <br/>→ [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) |
{: .grid}

### User story 1.9 Få hjælp til at udfylde henvisningen

> **User story:**  
> Som henviser ønsker jeg at få hjælp til at udfylde henvisningen med de rette/relevante informationer som angivet i henvisningsvejledningen/patientforløbsbeskrivelsen,  
> når jeg har skrevet et notat som beskriver grundlaget for henvisningen og angiver patientens symptomer/problemstillinger,  
> så jeg kan spare tid på at udfylde henvisningen med oplysninger som jeg allerede har beskrevet i notatet.

Henvisningens felter forudfyldes eller foreslås ud fra notatet og de oplysninger, som den valgte henvisningsvejledning/patientforløbsbeskrivelse kræver. Henviseren gennemgår og godkender forslagene.

|---|---|
| **Oprindelse:** | Ny |
| **Primær FHIR-ressource:** | `Questionnaire`, `QuestionnaireResponse`, `PlanDefinition`\* |
| **Triggerhændelse:** | Notat om henvisningsgrundlag er skrevet, og relevant henvisningsvejledning er identificeret |
| **Forrige trin:** | ← [1.8 Finde relevant undersøgelse eller behandling](#user-story-18-finde-relevant-unders%C3%B8gelse-eller-behandling) |
| **Næste trin:** | → [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) ·  <br/>→ [1.10 Importere data fra journalsystemet](#user-story-110-importere-data-fra-journalsystemet) |
{: .grid}

### User story 1.10 Importere data fra journalsystemet

> **User story:**  
> Som henviser ønsker jeg at kunne importere oplysninger og data fra journalsystemet ind i henvisningen,  
> når jeg skal udfylde henvisningen med oplysninger som allerede findes i patientens journal,  
> så jeg sparer tid ved at undgå at indtaste oplysninger manuelt.

Relevante oplysninger fra patientens journal, fx diagnoser, målinger og medicin, hentes ind i henvisningen og kan efterfølgende redigeres af henviseren.

|---|---|
| **Oprindelse:** | Ny |
| **Primær FHIR-ressource:** | `Condition`, `Observation`, `MedicationStatement`\* |
| **Triggerhændelse:** | Henvisningen skal udfyldes med oplysninger der allerede findes i journalen |
| **Forrige trin:** | ← [1.9 Få hjælp til at udfylde henvisningen](#user-story-19-f%C3%A5-hj%C3%A6lp-til-at-udfylde-henvisningen) |
| **Næste trin:** | → [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) ·  <br/>→ [1.2 Tilknytte klinisk dokumentation](#user-story-12-tilknytte-klinisk-dokumentation) *(hvis dokumenter også skal vedhæftes)* |
{: .grid}

### User story 1.11 Angive behov for samme dag under samme tag

> **User story:**  
> Som henviser ønsker jeg at kunne angive om patienten har behov for at blive undersøgt "samme dag under samme tag",  
> når patienten skal henvises til flere specialer/undersøgelser,  
> så patienter med transportudfordringer får hjælp til at møde op til alle sine bookinger.

Henviseren markerer på henvisningen, at patientens undersøgelser så vidt muligt skal samles på samme dag og samme lokation.

|---|---|
| **Oprindelse:** | Ny |
| **Primær FHIR-ressource:** | `ServiceRequest` (extension)\* |
| **Triggerhændelse:** | Patienten henvises til flere specialer/undersøgelser og har transportudfordringer |
| **Forrige trin:** | ← [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) |
| **Næste trin:** | → [1.12 Sammenkoble henvisninger og angive rækkefølge](#user-story-112-sammenkoble-henvisninger-og-angive-r%C3%A6kkef%C3%B8lge) ·  <br/>→ [2.11 Se sammenkoblede henvisninger og samme dag under samme tag](#user-story-211-se-sammenkoblede-henvisninger-og-samme-dag-under-samme-tag) |
{: .grid}

### User story 1.12 Sammenkoble henvisninger og angive rækkefølge

> **User story:**  
> Som henviser ønsker jeg at kunne sammenkoble flere henvisninger for den samme patient og angive den korrekte rækkefølge for de ønskede bookinger,  
> når patienten skal henvises til flere specialer/undersøgelser for samme problemstilling, fx radiologi og efterfølgende ortopædkirurgi,  
> så patienten bookes til alle undersøgelser og konsultationer i den rette rækkefølge.

Henviseren knytter flere henvisninger til samme problemstilling sammen og angiver hvilken rækkefølge bookingerne ønskes i.

|---|---|
| **Oprindelse:** | Ny |
| **Primær FHIR-ressource:** | `ServiceRequest` (basedOn/requisition, extension for rækkefølge)\* |
| **Triggerhændelse:** | Flere specialer/undersøgelser skal i en bestemt rækkefølge for samme problemstilling |
| **Forrige trin:** | ← [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) ·  <br/>← [1.11 Angive behov for samme dag under samme tag](#user-story-111-angive-behov-for-samme-dag-under-samme-tag) |
| **Næste trin:** | → [2.11 Se sammenkoblede henvisninger og samme dag under samme tag](#user-story-211-se-sammenkoblede-henvisninger-og-samme-dag-under-samme-tag) |
{: .grid}

### User story 1.13 Markere henvisning som færdig

> **User story:**  
> Som henviser ønsker jeg tydeligt at kunne angive at henvisningen er færdigudfyldt,  
> når jeg vil overdrage henvisningen til henvisningsmodtageren,  
> så visitationsforløbet kan igangsættes.

Henviseren markerer henvisningen som færdig (fra udkast til afsendt), hvorved den overdrages til visitation. Før markeringen kan henvisningen være et udkast, jf. [3.8](#user-story-38-dele-henvisningsudkast-med-modtager).

|---|---|
| **Oprindelse:** | Ny |
| **Primær FHIR-ressource:** | `ServiceRequest` (status), `Task`\* |
| **Triggerhændelse:** | Henvisningen er færdigudfyldt og skal overdrages til modtager |
| **Forrige trin:** | ← [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) ·  <br/>← [1.15 Tilrette og gensende afvist henvisning](#user-story-115-tilrette-og-gensende-afvist-henvisning) |
| **Næste trin:** | → [2.1 Modtage og kvittere for ny henvisning](#user-story-21-modtage-og-kvittere-for-ny-henvisning) ·  <br/>→ [2.7 Se og vurdere færdig henvisning](#user-story-27-se-og-vurdere-f%C3%A6rdig-henvisning) |
{: .grid}

### User story 1.14 Se årsag til afvist henvisning

> **User story:**  
> Som henviser ønsker jeg at kunne se årsagen til en afvist henvisning,  
> når jeg modtager besked om en afvist henvisning,  
> så jeg kan vælge den rette mitigerende handling for at få patienten videre i sit forløb.

|---|---|
| **Oprindelse:** | Ny |
| **Primær FHIR-ressource:** | `Task` (reason), `ServiceRequest`\* |
| **Triggerhændelse:** | Besked om afvist henvisning modtaget |
| **Forrige trin:** | ← [1.6 Modtage afgørelse fra visitatoren](#user-story-16-modtage-afg%C3%B8relse-fra-visitatoren) ·  <br/>← [2.4 Afvise en henvisning](#user-story-24-afvise-en-henvisning) |
| **Næste trin:** | → [1.15 Tilrette og gensende afvist henvisning](#user-story-115-tilrette-og-gensende-afvist-henvisning) *(afvist pga. manglende oplysninger)* ·  <br/>→ [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) *(patienten skal henvises andetsteds)* ·  <br/>→ [3.5 Aftale om alternativ visitation](#user-story-35-aftale-om-alternativ-visitation) |
{: .grid}

### User story 1.15 Tilrette og gensende afvist henvisning

> **User story:**  
> Som henviser ønsker jeg at kunne tilrette en afvist henvisning og igen markere den som færdig,  
> når jeg modtager besked om en henvisning som er afvist pga. manglende oplysninger,  
> så visitationsprocessen kan genoptages.

Til forskel fra [1.3](#user-story-13-%C3%A6ndre-en-afsendt-henvisning) (rettelse af en henvisning under behandling) tager denne user story udgangspunkt i en henvisning, som visitator allerede har afvist.

|---|---|
| **Oprindelse:** | Ny |
| **Primær FHIR-ressource:** | `ServiceRequest` (revision), `Task`\* |
| **Triggerhændelse:** | Henvisning afvist pga. manglende oplysninger |
| **Forrige trin:** | ← [1.14 Se årsag til afvist henvisning](#user-story-114-se-%C3%A5rsag-til-afvist-henvisning) |
| **Næste trin:** | → [1.13 Markere henvisning som færdig](#user-story-113-markere-henvisning-som-f%C3%A6rdig) ·  <br/>→ [2.2 Triagere og prioritere en henvisning](#user-story-22-triagere-og-prioritere-en-henvisning) *(visitationen genoptages)* |
{: .grid}

### User story 1.16 Se at henvisning er videresendt

> **User story:**  
> Som henviser ønsker jeg at kunne se hvis/når henvisningsmodtager videresender/vælger min henvisning til en anden modtager,  
> når modtager har vurderet at henvisningen skal til en anden modtager end den jeg har valgt i henvisningen,  
> så jeg er orienteret om hvor patienten skal undersøges/behandles.

|---|---|
| **Oprindelse:** | Ny |
| **Primær FHIR-ressource:** | `ServiceRequest` (replaces), `SubscriptionNotification`\* |
| **Triggerhændelse:** | Visitator har videresendt henvisningen til en anden modtager |
| **Forrige trin:** | ← [2.5 Videresende til anden modtager](#user-story-25-videresende-til-anden-modtager) ·  <br/>← [4.1 Overblik over færdige henvisninger i centralvisitation](#user-story-41-overblik-over-f%C3%A6rdige-henvisninger-i-centralvisitation) |
| **Næste trin:** | *(Henviser følger videre status via [1.5](#user-story-15-monitorere-status-p%C3%A5-afsendte-henvisninger))* |
{: .grid}

### User story 1.17 Se at patienten er booket

> **User story:**  
> Som henviser ønsker jeg at kunne se når patienten er booket til en eller flere kontakter,  
> når min henvisning er visiteret,  
> så jeg er orienteret om at patienten er videre i sit forløb.

|---|---|
| **Oprindelse:** | Ny (spejling af den visitator-side, der er flettet ind i [2.3](#user-story-23-acceptere-en-henvisning-og-booke-forl%C3%B8b)) |
| **Primær FHIR-ressource:** | `Appointment`, `SubscriptionNotification`\* |
| **Triggerhændelse:** | Henvisningen er visiteret og patienten er booket |
| **Forrige trin:** | ← [2.3 Acceptere en henvisning og booke forløb](#user-story-23-acceptere-en-henvisning-og-booke-forl%C3%B8b) ·  <br/>← [3.4 Statusnotifikation til henviser](#user-story-34-statusnotifikation-til-henviser) |
| **Næste trin:** | *(Flowet afsluttes for henviser)* |
{: .grid}

## Visitatorens user stories

Disse user stories udføres selvstændigt af visitatoren som led i modtagelse og behandling af indkomne henvisninger.

### User story 2.1 Modtage og kvittere for ny henvisning

> **User story:**  
> Som visitator ønsker jeg automatisk at modtage og kvittere for indkomne henvisninger via FHIR,  
> når en ny `ServiceRequest` ankommer i mit endpoint,  
> så afsenderen hurtigt får bekræftet at henvisningen er modtaget korrekt.

[![UC-2-1-Modtage-kvittere](UC-2-1-Modtage-kvittere.svg)](UC-2-1-Modtage-kvittere.svg)

Visitatoren modtager en indkommende FHIR-`Bundle` med en ny `ServiceRequest` og sender en teknisk kvittering (ACK) tilbage til afsendersystemet. Henvisningen registreres i visitationssystemet med status `active` eller `on-hold` afhængigt af triagekapacitet.

|---|---|
| **Oprindelse:** | Eksisterende |
| **Primær FHIR-ressource:** | `Bundle`, `MessageHeader`, `ServiceRequest` |
| **Triggerhændelse:** | Indkommende henvisning i FHIR-endpoint |
| **Forrige trin:** | ← [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) *(afsendelse af ny henvisning)* ·  <br/>← [1.2 Tilknytte klinisk dokumentation](#user-story-12-tilknytte-klinisk-dokumentation) *(beriget henvisning modtages)* ·  <br/>← [2.5 Videresende](#user-story-25-videresende-til-anden-modtager) *(ny modtager starter modtagelsesflow)* ·  <br/>← [1.13 Markere henvisning som færdig](#user-story-113-markere-henvisning-som-f%C3%A6rdig) |
| **Næste trin:** | → [2.2 Triagere og prioritere en henvisning](#user-story-22-triagere-og-prioritere-en-henvisning) |
{: .grid}

### User story 2.2 Triagere og prioritere en henvisning

> **User story:**  
> Som visitator ønsker jeg at kunne foretage en struktureret triage af en modtaget henvisning og dokumentere mit udfald,  
> når en ny eller opdateret henvisning er klar til klinisk vurdering,  
> så prioriteringen er sporbar og ensartet på tværs af alle indkomne sager.

[![UC-2-2-Triagere-prioritere](UC-2-2-Triagere-prioritere.svg)](UC-2-2-Triagere-prioritere.svg)

Visitatoren vurderer henvisningens faglige indhold, klassificerer hastegrad og prioriterer i forhold til øvrige indkomne henvisninger. Triage-udfaldet dokumenteres i en `Task`-ressource med udfald og begrundelse.

|---|---|
| **Oprindelse:** | Eksisterende |
| **Primær FHIR-ressource:** | `Task` (triage-outcome, priority) |
| **Triggerhændelse:** | Ny eller opdateret henvisning klar til klinisk vurdering |
| **Forrige trin:** | ← [2.1 Modtage og kvittere](#user-story-21-modtage-og-kvittere-for-ny-henvisning) *(efter kvittering påbegyndes triage)* ·  <br/>← [1.3 Ændre en afsendt henvisning](#user-story-13-%C3%A6ndre-en-afsendt-henvisning) *(ændringsnotifikation modtaget)* ·  <br/>← [3.2 Besvare anmodning om supplement](#user-story-32-besvare-anmodning-om-supplement) *(supplement modtaget, triage genoptages)* ·  <br/>← [3.6 Korrektionsaftale](#user-story-36-korrektionsaftale-om-fejl-i-afsendt-henvisning) *(triage genoptages efter korrektion)* ·  <br/>← [1.15 Tilrette og gensende afvist henvisning](#user-story-115-tilrette-og-gensende-afvist-henvisning) *(genoptaget efter afvisning)* |
| **Næste trin:** | → [2.3 Acceptere en henvisning og booke forløb](#user-story-23-acceptere-en-henvisning-og-booke-forl%C3%B8b) *(positiv afgørelse)* ·  <br/>→ [2.4 Afvise en henvisning](#user-story-24-afvise-en-henvisning) *(negativ afgørelse)* ·  <br/>→ [3.1 Anmode om supplerende oplysninger](#user-story-31-anmode-om-supplerende-oplysninger) *(grundlaget er utilstrækkeligt)* ·  <br/>→ [2.6 Ændre prioritet](#user-story-26-%C3%A6ndre-prioritet-p%C3%A5-en-modtaget-henvisning) *(prioriteten justeres)* |
{: .grid}

### User story 2.3 Acceptere en henvisning og booke forløb

> **User story:**  
> Som visitator ønsker jeg at kunne acceptere en henvisning, oprette en booking og sende besked til henviser, når patienten bookes til en eller flere kontakter,  
> når min visitationsafgørelse er positiv, og min afdeling skal varetage patientens undersøgelse/behandling,  
> så patienten får en tid, henviseren automatisk modtager bekræftelsen og er orienteret om at patienten er indkaldt, og en eventuel tidsperiode for behandlingsgaranti startes op.

[![UC-2-3-Acceptere-booke](UC-2-3-Acceptere-booke.svg)](UC-2-3-Acceptere-booke.svg)

Visitatoren accepterer henvisningen og opretter et forløb. Der bookes en tid, og `ServiceRequest`-status opdateres til `active`. En `Appointment`-ressource oprettes og linkes til henvisningen. Accepten kan være udløsende for en eventuel behandlingsgaranti, og henviseren får besked når patienten bookes til en eller flere kontakter.

|---|---|
| **Oprindelse:** | **Flettet**: eksisterende 2.3 + to nye user stories (Henvisningsmodtager: "kunne angive at henvisningen er accepteret" og "kunne sende besked til henviser, når patienten bookes til en eller flere kontakter") |
| **Primær FHIR-ressource:** | `ServiceRequest` (active), `Appointment` (booked) |
| **Triggerhændelse:** | Positiv visitationsafgørelse, og senere planlagt opstart af undersøgelse/behandling |
| **Forrige trin:** | ← [2.2 Triagere og prioritere](#user-story-22-triagere-og-prioritere-en-henvisning) *(positiv afgørelse)* ·  <br/>← [3.5 Alternativ visitation](#user-story-35-aftale-om-alternativ-visitation) *(alternativt tilbud accepteres)* ·  <br/>← [3.3 Faglig afklaring](#user-story-33-faglig-afklaring-i-dialog) *(afklaring munder ud i accept)* ·  <br/>← [2.11 Se sammenkoblede henvisninger og samme dag under samme tag](#user-story-211-se-sammenkoblede-henvisninger-og-samme-dag-under-samme-tag) *(booking koordineres med øvrige modtagere)* |
| **Næste trin:** | → [3.4 Statusnotifikation til henviser](#user-story-34-statusnotifikation-til-henviser) *(henviser notificeres om accept og booking)* ·  <br/>→ [2.10 Hente accepteret henvisning til eget journalsystem](#user-story-210-hente-accepteret-henvisning-til-eget-journalsystem) ·  <br/>→ [1.17 Se at patienten er booket](#user-story-117-se-at-patienten-er-booket) |
{: .grid}

### User story 2.4 Afvise en henvisning

> **User story:**  
> Som visitator ønsker jeg at kunne afvise en færdig henvisning og angive en dokumenteret årsag,  
> når indikationen ikke er opfyldt, kapaciteten er nået, der mangler oplysninger i henvisningen, eller min afdeling ikke kan tilbyde patienten en relevant undersøgelse eller behandling,  
> så henviseren forstår årsagen og kan lave de relevante mitigerende handlinger for at få patienten videre i sit forløb.

[![UC-2-4-Afvise-henvisning](UC-2-4-Afvise-henvisning.svg)](UC-2-4-Afvise-henvisning.svg)

Visitatoren afviser henvisningen med en faglig eller kapacitetsmæssig begrundelse eller pga. manglende oplysninger. `ServiceRequest`-status sættes til `revoked` eller `completed` med en `Task`-ressource der angiver årsag til afvisning.

|---|---|
| **Oprindelse:** | **Flettet**: eksisterende 2.4 + to nye user stories (Henvisningsmodtager: "kunne afvise en færdig henvisning" og "kunne angive årsagen til en afvist henvisning") |
| **Primær FHIR-ressource:** | `Task` (declined + reason), `ServiceRequest` |
| **Triggerhændelse:** | Indikation ikke opfyldt, forkert visitationsspor, kapacitetsloft nået, manglende oplysninger eller manglende relevant tilbud |
| **Forrige trin:** | ← [2.2 Triagere og prioritere](#user-story-22-triagere-og-prioritere-en-henvisning) *(negativ afgørelse)* ·  <br/>← [3.3 Faglig afklaring](#user-story-33-faglig-afklaring-i-dialog) *(afklaring munder ud i afvisning)* ·  <br/>← [2.7 Se og vurdere færdig henvisning](#user-story-27-se-og-vurdere-f%C3%A6rdig-henvisning) *(henvisningen vurderes ikke klar til visitation)* |
| **Næste trin:** | → [3.4 Statusnotifikation til henviser](#user-story-34-statusnotifikation-til-henviser) *(henviser notificeres om afvisning)* ·  <br/>→ [3.5 Aftale om alternativ visitation](#user-story-35-aftale-om-alternativ-visitation) *(hvis alternativ løsning bør afsøges)* ·  <br/>→ [1.14 Se årsag til afvist henvisning](#user-story-114-se-%C3%A5rsag-til-afvist-henvisning) |
{: .grid}

### User story 2.5 Videresende til anden modtager

> **User story:**  
> Som visitator ønsker jeg at kunne videresende en fejlplaceret henvisning direkte til rette modtager,  
> når jeg vurderer at en anden modtager end den angivne bedre kan varetage patientens undersøgelse/behandling,  
> så henvisningen ikke skal retur til henviser for at blive videresendt og dermed forsinkes, og henviseren holdes orienteret om omdirigeringen.

[![UC-2-5-Videresende](UC-2-5-Videresende.svg)](UC-2-5-Videresende.svg)

Visitatoren vurderer at henvisningen hører hjemme et andet sted og videresender. Der oprettes en ny `ServiceRequest` med reference til den originale via `replaces`-attributten, og der sendes notifikation til den oprindelige henviser.

|---|---|
| **Oprindelse:** | **Flettet**: eksisterende 2.5 + ny user story (Henvisningsmodtager: "kunne sende henvisningen videre til en anden modtager") |
| **Primær FHIR-ressource:** | `ServiceRequest` (replaces), `Task`, `Communication` |
| **Triggerhændelse:** | Forkert modtager eller bedre egnet tilbud identificeret |
| **Forrige trin:** | ← [2.2 Triagere og prioritere](#user-story-22-triagere-og-prioritere-en-henvisning) *(forkert modtager identificeret)* ·  <br/>← [4.1 Overblik over færdige henvisninger i centralvisitation](#user-story-41-overblik-over-f%C3%A6rdige-henvisninger-i-centralvisitation) *(centralvisitator kanaliserer videre)* |
| **Næste trin:** | → [2.1 Modtage og kvittere for ny henvisning](#user-story-21-modtage-og-kvittere-for-ny-henvisning) *(ny modtager starter sit eget modtagelsesflow)* ·  <br/>→ [3.4 Statusnotifikation til henviser](#user-story-34-statusnotifikation-til-henviser) *(den oprindelige henviser orienteres)* ·  <br/>→ [1.16 Se at henvisning er videresendt](#user-story-116-se-at-henvisning-er-videresendt) |
{: .grid}

### User story 2.6 Ændre prioritet på en modtaget henvisning

> **User story:**  
> Som visitator ønsker jeg at kunne justere prioriteten på en allerede modtaget henvisning,  
> når ny klinisk information eller ændret kapacitetssituation tilsiger det,  
> så den kliniske hastegrad afspejles korrekt og henviseren notificeres om ændringen.

[![UC-2-6-Aendre-prioritet](UC-2-6-Aendre-prioritet.svg)](UC-2-6-Aendre-prioritet.svg)

Visitatoren revurderer hastegraden for en allerede modtaget henvisning, fx på baggrund af ny klinisk information eller ændret kapacitetssituation. Prioriteten opdateres på `ServiceRequest` og der sendes notifikation til henviseren.

|---|---|
| **Oprindelse:** | Eksisterende |
| **Primær FHIR-ressource:** | `ServiceRequest` (priority update), `SubscriptionNotification` |
| **Triggerhændelse:** | Ny information ændrer klinisk hastegrad |
| **Forrige trin:** | ← [2.2 Triagere og prioritere](#user-story-22-triagere-og-prioritere-en-henvisning) *(prioritetsjustering under triage)* |
| **Næste trin:** | → [3.4 Statusnotifikation til henviser](#user-story-34-statusnotifikation-til-henviser) *(henviser notificeres om den ændrede prioritet)* |
{: .grid}

### User story 2.7 Se og vurdere færdig henvisning

> **User story:**  
> Som visitator ønsker jeg at kunne se den færdige henvisning,  
> når henviser har angivet at henvisningen er færdig,  
> så jeg kan vurdere om henvisningen er klar til visitation.

|---|---|
| **Oprindelse:** | Ny |
| **Primær FHIR-ressource:** | `ServiceRequest`, `Task`\* |
| **Triggerhændelse:** | Henviser har markeret henvisningen som færdig |
| **Forrige trin:** | ← [1.13 Markere henvisning som færdig](#user-story-113-markere-henvisning-som-f%C3%A6rdig) |
| **Næste trin:** | → [2.2 Triagere og prioritere en henvisning](#user-story-22-triagere-og-prioritere-en-henvisning) *(klar til visitation)* ·  <br/>→ [2.4 Afvise en henvisning](#user-story-24-afvise-en-henvisning) *(ikke klar til visitation)* |
{: .grid}

### User story 2.8 Modtage fyldestgørende henvisninger

> **User story:**  
> Som visitator ønsker jeg at modtage fyldestgørende henvisninger,  
> når jeg skal visitere henvisninger for min afdeling/speciale,  
> så patienten hurtigst muligt kan komme videre i sit forløb.

Denne user story er et kvalitetskrav til henvisningens indhold og understøttes bl.a. af [1.8](#user-story-18-finde-relevant-unders%C3%B8gelse-eller-behandling), [1.9](#user-story-19-f%C3%A5-hj%C3%A6lp-til-at-udfylde-henvisningen) og [2.9](#user-story-29-vedligeholde-patientforl%C3%B8bsbeskrivelser-og-henvisningsvejledninger).

|---|---|
| **Oprindelse:** | Ny |
| **Primær FHIR-ressource:** | `ServiceRequest`, `Questionnaire`\* |
| **Triggerhændelse:** | Visitator skal visitere henvisninger for sin afdeling/speciale |
| **Forrige trin:** | ← [1.9 Få hjælp til at udfylde henvisningen](#user-story-19-f%C3%A5-hj%C3%A6lp-til-at-udfylde-henvisningen) |
| **Næste trin:** | → [2.2 Triagere og prioritere en henvisning](#user-story-22-triagere-og-prioritere-en-henvisning) |
{: .grid}

### User story 2.9 Vedligeholde patientforløbsbeskrivelser og henvisningsvejledninger

> **User story:**  
> Som visitator ønsker jeg at det er nemt at oprette og opdatere patientforløbsbeskrivelser og henvisningsvejledninger,  
> når der er nye informationer som skal ud til henviser,  
> så henviser altid har mulighed for at holde sig opdateret om nye eller ændrede henvisningskriterier.

|---|---|
| **Oprindelse:** | Ny |
| **Primær FHIR-ressource:** | `PlanDefinition`, `ActivityDefinition`, `DocumentReference`\* |
| **Triggerhændelse:** | Nye eller ændrede henvisningskriterier eller andre informationer til henviser |
| **Forrige trin:** | *(Uafhængig vedligeholdelsesopgave)* |
| **Næste trin:** | → [1.8 Finde relevant undersøgelse eller behandling](#user-story-18-finde-relevant-unders%C3%B8gelse-eller-behandling) ·  <br/>→ [1.9 Få hjælp til at udfylde henvisningen](#user-story-19-f%C3%A5-hj%C3%A6lp-til-at-udfylde-henvisningen) |
{: .grid}

### User story 2.10 Hente accepteret henvisning til eget journalsystem

> **User story:**  
> Som visitator ønsker jeg at hente den accepterede henvisning med eventuelle bilag ned i eget journalsystem,  
> når min afdeling skal varetage patientens undersøgelse/behandling,  
> så henvisningsoplysningerne videregives jf. regler og lovgivning om henvisning og overdragelse af behandlingsansvar.

|---|---|
| **Oprindelse:** | Ny |
| **Primær FHIR-ressource:** | `ServiceRequest`, `DocumentReference`, `Bundle`\* |
| **Triggerhændelse:** | Henvisningen er accepteret, og afdelingen skal varetage undersøgelse/behandling |
| **Forrige trin:** | ← [2.3 Acceptere en henvisning og booke forløb](#user-story-23-acceptere-en-henvisning-og-booke-forl%C3%B8b) |
| **Næste trin:** | → [5.2 Se mine henvisninger inklusive bilag](#user-story-52-se-mine-henvisninger-inklusive-bilag) *(patienten kan se hvad der er hentet)* |
{: .grid}

### User story 2.11 Se sammenkoblede henvisninger og samme dag under samme tag

> **User story:**  
> Som visitator ønsker jeg at kunne se om flere henvisninger er knyttet sammen og/eller om patienten har behov for at blive booket "samme dag under samme tag",  
> når patienten er henvist til flere specialer/undersøgelser,  
> så jeg kan koordinere bookingen af patienten med de øvrige henvisningsmodtagere.

|---|---|
| **Oprindelse:** | Ny |
| **Primær FHIR-ressource:** | `ServiceRequest` (extension)\* |
| **Triggerhændelse:** | Patienten er henvist til flere specialer/undersøgelser |
| **Forrige trin:** | ← [1.11 Angive behov for samme dag under samme tag](#user-story-111-angive-behov-for-samme-dag-under-samme-tag) ·  <br/>← [1.12 Sammenkoble henvisninger og angive rækkefølge](#user-story-112-sammenkoble-henvisninger-og-angive-r%C3%A6kkef%C3%B8lge) |
| **Næste trin:** | → [2.3 Acceptere en henvisning og booke forløb](#user-story-23-acceptere-en-henvisning-og-booke-forl%C3%B8b) |
{: .grid}

## Udvekslingsdialog (fælles user stories)

Disse user stories forudsætter aktiv kommunikation frem og tilbage mellem henviser og visitator via FHIR-beskeder.

### User story 3.1 Anmode om supplerende oplysninger

> **User story:**  
> Som visitator ønsker jeg at kunne sende en struktureret anmodning om supplerende oplysninger til henviseren,  
> når grundlaget for triage er utilstrækkeligt,  
> så jeg kan træffe en fagligt forsvarlig visitationsafgørelse uden at afvise unødigt.

[![UC-3-1-Anmode-supplement](UC-3-1-Anmode-supplement.svg)](UC-3-1-Anmode-supplement.svg)

Visitatoren mangler oplysninger for at kunne triagere og sender en struktureret anmodning til henviseren om at supplere med konkrete kliniske data, fx blodprøveresultater, BMI, medicinliste eller tidligere forløb.

|---|---|
| **Oprindelse:** | Eksisterende |
| **Primær FHIR-ressource:** | `CommunicationRequest` (fra visitator til henviser) |
| **Triggerhændelse:** | Utilstrækkeligt grundlag for visitationsafgørelse |
| **Forrige trin:** | ← [2.2 Triagere og prioritere](#user-story-22-triagere-og-prioritere-en-henvisning) *(utilstrækkeligt grundlag for triage)* |
| **Næste trin:** | → [3.2 Besvare anmodning om supplement](#user-story-32-besvare-anmodning-om-supplement) |
{: .grid}

### User story 3.2 Besvare anmodning om supplement

> **User story:**  
> Som henviser ønsker jeg at kunne besvare en supplement-anmodning med de efterspurgte kliniske oplysninger,  
> når visitatoren har bedt om yderligere data,  
> så visitatoren hurtigt kan genoptage og afslutte triage-processen.

[![UC-3-2-Besvare-supplement](UC-3-2-Besvare-supplement.svg)](UC-3-2-Besvare-supplement.svg)

Henviseren modtager en supplement-anmodning og besvarer denne ved at sende de efterspurgte oplysninger. Svaret sendes som en `Communication`-ressource med reference til den oprindelige `CommunicationRequest` og til `ServiceRequest`.

|---|---|
| **Oprindelse:** | Eksisterende |
| **Primær FHIR-ressource:** | `Communication` (reply, in-response-to) |
| **Triggerhændelse:** | Modtagelse af CommunicationRequest fra visitatoren |
| **Forrige trin:** | ← [3.1 Anmode om supplerende oplysninger](#user-story-31-anmode-om-supplerende-oplysninger) *(supplement anmodet)* |
| **Næste trin:** | → [2.2 Triagere og prioritere en henvisning](#user-story-22-triagere-og-prioritere-en-henvisning) *(visitatoren genoptager triage med det modtagne supplement)* ·  <br/>→ [3.3 Faglig afklaring i dialog](#user-story-33-faglig-afklaring-i-dialog) *(hvis svaret afføder yderligere spørgsmål)* |
{: .grid}

### User story 3.3 Faglig afklaring i dialog

> **User story:**  
> Som henviser og visitator ønsker vi begge at kunne føre en struktureret faglig dialog om en konkret henvisning,  
> når indikation, egnethed eller behandlingsvalg er uklart,  
> så vi i fællesskab kan nå frem til den rigtige afgørelse for patienten uden at skulle bruge andre kommunikationskanaler.

[![UC-3-3-Faglig-afklaring](UC-3-3-Faglig-afklaring.svg)](UC-3-3-Faglig-afklaring.svg)

Henviser og visitator udveksler kliniske spørgsmål og svar for at afklare indikation, behandlingsegnethed eller alternativ tilgang, uden at dette nødvendigvis afklares i én besked. Dialogen føres som en kæde af `Communication`-ressourcer med indbyrdes referencer. Dialog i forbindelse med udfyldelsen af en endnu ikke færdig henvisning beskrives i [3.7](#user-story-37-skriftlig-dialog-under-udfyldelse-af-henvisning).

|---|---|
| **Oprindelse:** | Eksisterende |
| **Primær FHIR-ressource:** | `Communication` (thread med in-response-to-kæde) |
| **Triggerhændelse:** | Faglig uklarhed der kræver mere end én udveksling |
| **Forrige trin:** | ← [3.2 Besvare anmodning om supplement](#user-story-32-besvare-anmodning-om-supplement) *(svaret afføder yderligere spørgsmål)* |
| **Næste trin:** | → [2.3 Acceptere en henvisning og booke forløb](#user-story-23-acceptere-en-henvisning-og-booke-forl%C3%B8b) *(afklaring munder ud i accept)* ·  <br/>→ [2.4 Afvise en henvisning](#user-story-24-afvise-en-henvisning) *(afklaring munder ud i afvisning)* |
{: .grid}

### User story 3.4 Statusnotifikation til henviser

> **User story:**  
> Som henviser ønsker jeg automatisk at modtage en notifikation,  
> når status på en af mine henvisninger ændrer sig hos visitatoren,  
> så jeg til enhver tid er opdateret om forløbet uden at skulle forespørge aktivt.

[![UC-3-4-Statusnotifikation](UC-3-4-Statusnotifikation.svg)](UC-3-4-Statusnotifikation.svg)

Visitatoren notificerer automatisk henviseren ved statusskift på en afsendt henvisning, fx modtaget, under vurdering, accepteret eller afvist. Notifikationen leveres via FHIR-subscription og indeholder reference til den opdaterede `ServiceRequest`.

|---|---|
| **Oprindelse:** | Eksisterende |
| **Primær FHIR-ressource:** | `SubscriptionNotification`, `ServiceRequest` |
| **Triggerhændelse:** | Ethvert statusskift på en aktiv henvisning hos visitatoren |
| **Forrige trin:** | ← [2.3 Acceptere og booke](#user-story-23-acceptere-en-henvisning-og-booke-forl%C3%B8b) *(accept udløser notifikation)* ·  <br/>← [2.4 Afvise en henvisning](#user-story-24-afvise-en-henvisning) *(afvisning udløser notifikation)* ·  <br/>← [2.5 Videresende](#user-story-25-videresende-til-anden-modtager) *(videresendelse udløser notifikation)* ·  <br/>← [2.6 Ændre prioritet](#user-story-26-%C3%A6ndre-prioritet-p%C3%A5-en-modtaget-henvisning) *(prioritetsændring udløser notifikation)* |
| **Næste trin:** | → [1.6 Modtage afgørelse fra visitatoren](#user-story-16-modtage-afg%C3%B8relse-fra-visitatoren) *(notifikationen udløser håndtering af afgørelsen hos henviseren)* ·  <br/>→ [1.17 Se at patienten er booket](#user-story-117-se-at-patienten-er-booket) |
{: .grid}

### User story 3.5 Aftale om alternativ visitation

> **User story:**  
> Som visitator ønsker jeg at kunne indlede en dialog med henviseren om et alternativt tilbud,  
> når jeg ikke kan imødekomme den primære henvisning,  
> så patienten ikke ender i en blindgyde og vi i fællesskab finder en løsning.

[![UC-3-5-Alternativ-visitation](UC-3-5-Alternativ-visitation.svg)](UC-3-5-Alternativ-visitation.svg)

Henviser og visitator forhandler i fællesskab om et alternativt tilbud, når det primære visitationsspor ikke er muligt. Dialogen foregår via `Communication`, og den resulterende aftale dokumenteres i en `Task` med reference til det alternative tilbud.

|---|---|
| **Oprindelse:** | Eksisterende |
| **Primær FHIR-ressource:** | `Communication`, `Task`, `ServiceRequest` (alternativ) |
| **Triggerhændelse:** | Afvisning kombineret med behov for at finde alternativ løsning for patienten |
| **Forrige trin:** | ← [2.4 Afvise en henvisning](#user-story-24-afvise-en-henvisning) *(afvisning kombineret med søgning efter alternativ)* ·  <br/>← [1.14 Se årsag til afvist henvisning](#user-story-114-se-%C3%A5rsag-til-afvist-henvisning) |
| **Næste trin:** | → [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) *(nyt alternativt tilbud kræver ny henvisning)* ·  <br/>→ [2.3 Acceptere en henvisning og booke forløb](#user-story-23-acceptere-en-henvisning-og-booke-forl%C3%B8b) *(alternativt tilbud accepteres)* |
{: .grid}

### User story 3.6 Korrektionsaftale om fejl i afsendt henvisning

> **User story:**  
> Som visitator ønsker jeg at kunne kontakte henviseren og aftale en korrektion,  
> når jeg opdager en fejl i en modtaget henvisning,  
> så fejlen rettes på en koordineret og sporbar måde uden at vi mister historikken.

[![UC-3-6-Korrektionsaftale](UC-3-6-Korrektionsaftale.svg)](UC-3-6-Korrektionsaftale.svg)

Visitatoren opdager en fejl i en modtaget henvisning, fx forkert CPR-nummer, forkert ydelseskode eller manglende samtykkedokumentation, og indleder en dialog med henviseren om korrektion. Korrektionen aftales via `Communication`-besked og gennemføres med en efterfølgende opdatering af `ServiceRequest`.

|---|---|
| **Oprindelse:** | Eksisterende |
| **Primær FHIR-ressource:** | `Communication`, `ServiceRequest` (korrektion) |
| **Triggerhændelse:** | Fejl opdaget under modtagelse eller triage hos visitatoren |
| **Forrige trin:** | ← [2.4 Afvise en henvisning](#user-story-24-afvise-en-henvisning) *(fejl opdaget, korrektionsdialog indledes)* |
| **Næste trin:** | → [1.3 Ændre en afsendt henvisning](#user-story-13-%C3%A6ndre-en-afsendt-henvisning) *(henviser retter og sender)* ·  <br/>→ [2.2 Triagere og prioritere en henvisning](#user-story-22-triagere-og-prioritere-en-henvisning) *(visitatoren genoptager triage efter korrektion)* |
{: .grid}

### User story 3.7 Skriftlig dialog under udfyldelse af henvisning

> **User story:**  
> Som henviser og visitator ønsker vi begge at kunne kommunikere hurtigt, nemt og direkte på skrift med hinanden,  
> når henviser har spørgsmål til udfyldelsen af henvisningens kliniske indhold, eller har behov for dialog og afklaringer under udfyldelsen,  
> så vi hurtigt kan afklare om alle nødvendige oplysninger er angivet i henvisningen, uden at afklaringerne forsinker henvisningsprocessen.

Dialogen føres, mens henvisningen stadig er under udfyldelse, og knyttes til henvisningsudkastet. Til forskel fra [3.3](#user-story-33-faglig-afklaring-i-dialog) (faglig afklaring af en modtaget henvisning) handler denne user story om afklaring *før* henvisningen er færdig.

|---|---|
| **Oprindelse:** | **Flettet**: to nye user stories (Henviser: "en hurtig og direkte skriftlig dialog med henvisningsmodtager" og Henvisningsmodtager: "kommunikere hurtigt og nemt på skrift med henviser") |
| **Primær FHIR-ressource:** | `Communication`, `ServiceRequest` (draft)\* |
| **Triggerhændelse:** | Spørgsmål eller behov for afklaring under udfyldelsen af henvisningen |
| **Forrige trin:** | ← [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) *(henvisningen er under udfyldelse)* ·  <br/>← [3.8 Dele henvisningsudkast med modtager](#user-story-38-dele-henvisningsudkast-med-modtager) |
| **Næste trin:** | → [1.13 Markere henvisning som færdig](#user-story-113-markere-henvisning-som-f%C3%A6rdig) |
{: .grid}

### User story 3.8 Dele henvisningsudkast med modtager

> **User story:**  
> Som henviser ønsker jeg at henvisningsmodtager kan se henvisningen, selvom den ikke er færdig, og som visitator ønsker jeg at kunne se henvisningen mens den er under udfyldelse,  
> når henviser har behov for dialog og afklaringer under udfyldelsen af henvisningen,  
> så henviser ikke selv behøver at gentage eller formidle den foreløbige henvisningstekst.

|---|---|
| **Oprindelse:** | **Flettet**: to nye user stories (Henviser: "henvisningsmodtager kan se henvisningen, selvom den ikke er færdig" og Henvisningsmodtager: "kunne se henvisningen når den er under udfyldelse") |
| **Primær FHIR-ressource:** | `ServiceRequest` (draft)\* |
| **Triggerhændelse:** | Henviser skal drøfte udfyldelsen af henvisningen med modtager |
| **Forrige trin:** | ← [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) *(udkast oprettet)* |
| **Næste trin:** | → [3.7 Skriftlig dialog under udfyldelse af henvisning](#user-story-37-skriftlig-dialog-under-udfyldelse-af-henvisning) ·  <br/>→ [1.13 Markere henvisning som færdig](#user-story-113-markere-henvisning-som-f%C3%A6rdig) |
{: .grid}

### User story 3.9 Adskilt indbakke til henvisningsdialog

> **User story:**  
> Som henviser ønsker jeg at skriftlig dialog med henvisningsmodtager er adskilt fra den øvrige korrespondance i indbakken i mit journalsystem,  
> når jeg skal skrive med modtager eller visitator under udfyldelsen af henvisningen eller efter henvisningen er modtaget,  
> så skriftlig dialog om henvisninger ikke bliver væk i eller forsinkes af den øvrige korrespondance om og med mine patienter.

|---|---|
| **Oprindelse:** | Ny |
| **Primær FHIR-ressource:** | `Communication` (category)\* |
| **Triggerhændelse:** | Dialog om en henvisning, enten under udfyldelsen eller efter modtagelsen |
| **Forrige trin:** | ← [3.7 Skriftlig dialog under udfyldelse af henvisning](#user-story-37-skriftlig-dialog-under-udfyldelse-af-henvisning) ·  <br/>← [3.3 Faglig afklaring i dialog](#user-story-33-faglig-afklaring-i-dialog) |
| **Næste trin:** | *(Understøtter alle dialog-user stories i sektion 3)* |
{: .grid}

## Centralvisitatorens user stories

Centralvisitatoren modtager færdige henvisninger til en samlet henvisningsenhed og kanaliserer dem videre til de relevante specialenheder.

### User story 4.1 Overblik over færdige henvisninger i centralvisitation

> **User story:**  
> Som centralvisitator ønsker jeg at kunne få overblik over færdige henvisninger adresseret til min henvisningsenhed,  
> når jeg skal kanalisere henvisninger videre til de relevante specialeenheder,  
> så færdige henvisninger ikke forsinkes i centralvisitationen.

|---|---|
| **Oprindelse:** | Ny |
| **Primær FHIR-ressource:** | `ServiceRequest`, `Task`\* |
| **Triggerhændelse:** | Færdige henvisninger er adresseret til centralvisitationens henvisningsenhed |
| **Forrige trin:** | ← [1.13 Markere henvisning som færdig](#user-story-113-markere-henvisning-som-f%C3%A6rdig) |
| **Næste trin:** | → [2.5 Videresende til anden modtager](#user-story-25-videresende-til-anden-modtager) *(henvisningen sendes videre til specialeenheden)* |
{: .grid}

## Patientens user stories

Patienten er ikke aktør i selve henvisningsudvekslingen, men har brug for indsigt i processen og de oplysninger, der udveksles.

### User story 5.1 Se status for min henvisning

> **User story:**  
> Som patient ønsker jeg at kunne se status for min henvisning,  
> når jeg har haft en kontakt med min læge, som er resulteret i opstart af en henvisningsproces,  
> så jeg kan holde mig orienteret om min henvisning uden at skulle ringe til min læge.

|---|---|
| **Oprindelse:** | Ny |
| **Primær FHIR-ressource:** | `ServiceRequest`, `Task`\* |
| **Triggerhændelse:** | Henvisningsproces er startet efter kontakt med lægen |
| **Forrige trin:** | ← [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) |
| **Næste trin:** | → [5.2 Se mine henvisninger inklusive bilag](#user-story-52-se-mine-henvisninger-inklusive-bilag) |
{: .grid}

### User story 5.2 Se mine henvisninger inklusive bilag

> **User story:**  
> Som patient ønsker jeg at kunne se mine henvisninger, inklusive bilag,  
> når min henvisning er accepteret og hentet af henvisningsmodtager,  
> så jeg kender alle oplysninger som er angivet til henvisningsmodtager.

|---|---|
| **Oprindelse:** | Ny |
| **Primær FHIR-ressource:** | `ServiceRequest`, `DocumentReference`\* |
| **Triggerhændelse:** | Henvisningen er accepteret og hentet af henvisningsmodtager |
| **Forrige trin:** | ← [2.10 Hente accepteret henvisning til eget journalsystem](#user-story-210-hente-accepteret-henvisning-til-eget-journalsystem) |
| **Næste trin:** | → [5.3 Se beskeder om mine bookinger](#user-story-53-se-beskeder-om-mine-bookinger) |
{: .grid}

### User story 5.3 Se beskeder om mine bookinger

> **User story:**  
> Som patient ønsker jeg at kunne se de beskeder om mine bookinger, som sendes til henviser,  
> når min henvisning er accepteret og hentet af henvisningsmodtager,  
> så jeg har mulighed for at sammenholde det med mine indkaldelser.

|---|---|
| **Oprindelse:** | Ny |
| **Primær FHIR-ressource:** | `Communication`, `Appointment`\* |
| **Triggerhændelse:** | Henvisningen er accepteret og hentet af henvisningsmodtager, og booking er meddelt henviser |
| **Forrige trin:** | ← [2.3 Acceptere en henvisning og booke forløb](#user-story-23-acceptere-en-henvisning-og-booke-forl%C3%B8b) |
| **Næste trin:** | *(Flowet afsluttes for patienten)* |
{: .grid}

## Administratorens user stories

Administratoren følger henvisningsprocessen på aggregeret niveau, for en eller flere afsendere/modtagere. Al statistik er anonymiseret. User story 6.1 er overordnet, og 6.2-6.5 uddyber de enkelte statistikområder.

### User story 6.1 Adgang til anonymiseret henvisningsstatistik

> **User story:**  
> Som administrator ønsker jeg at have nem adgang til anonymiseret statistik om henvisninger (se user stories herunder),  
> når jeg skal have overblik over henvisningsprocesserne for en eller flere afsendere/modtagere,  
> så der ikke skal bruges tid på manuel optælling af henvisninger eller manuel fremsøgning af data.

|---|---|
| **Oprindelse:** | Ny |
| **Primær FHIR-ressource:** | `Measure`, `MeasureReport`\* |
| **Triggerhændelse:** | Behov for overblik over henvisningsprocesserne |
| **Forrige trin:** | *(Uafhængig af det enkelte henvisningsflow)* |
| **Næste trin:** | → [6.2](#user-story-62-statistik-over-henvisningsstatusser) ·  <br/>→ [6.3](#user-story-63-statistik-over-henvisningsdiagnoser) ·  <br/>→ [6.4](#user-story-64-statistik-over-%C3%A5rsager-til-afviste-henvisninger) ·  <br/>→ [6.5](#user-story-65-statistik-over-videresendte-henvisninger) |
{: .grid}

### User story 6.2 Statistik over henvisningsstatusser

> **User story:**  
> Som administrator ønsker jeg at have nem adgang til anonymiseret statistik om henvisningsstatusser,  
> når jeg skal have overblik over antallet og varigheden af henvisninger med en bestemt status (fx under udarbejdelse, færdig, afvist, videresendt, accepteret) for en eller flere afsendere/modtagere,  
> så der ikke skal bruges tid på manuel optælling af henvisningsstatusser.

|---|---|
| **Oprindelse:** | Ny |
| **Primær FHIR-ressource:** | `Measure`, `MeasureReport`\* |
| **Triggerhændelse:** | Behov for overblik over antal og varighed pr. henvisningsstatus |
| **Forrige trin:** | ← [6.1](#user-story-61-adgang-til-anonymiseret-henvisningsstatistik) |
| **Næste trin:** | *(Statistik, ingen yderligere trin)* |
{: .grid}

### User story 6.3 Statistik over henvisningsdiagnoser

> **User story:**  
> Som administrator ønsker jeg at have nem adgang til anonymiseret statistik om henvisningsdiagnoser,  
> når jeg skal have overblik over antallet af henvisninger med en bestemt diagnose eller diagnosegrupper for en eller flere afsendere/modtagere,  
> så der ikke skal bruges tid på manuel optælling af henvisningsdiagnoser.

|---|---|
| **Oprindelse:** | Ny |
| **Primær FHIR-ressource:** | `Measure`, `MeasureReport`\* |
| **Triggerhændelse:** | Behov for overblik over antal henvisninger pr. diagnose/diagnosegruppe |
| **Forrige trin:** | ← [6.1](#user-story-61-adgang-til-anonymiseret-henvisningsstatistik) |
| **Næste trin:** | *(Statistik, ingen yderligere trin)* |
{: .grid}

### User story 6.4 Statistik over årsager til afviste henvisninger

> **User story:**  
> Som administrator ønsker jeg at have nem adgang til anonymiseret statistik om årsager til afviste henvisninger,  
> når jeg skal undersøge om henvisningsprocessen fungerer bedst muligt,  
> så jeg bedre kan identificere områder som skal justeres for at forbedre henvisningsprocessen.

|---|---|
| **Oprindelse:** | Ny |
| **Primær FHIR-ressource:** | `Measure`, `MeasureReport`\* |
| **Triggerhændelse:** | Undersøgelse af om henvisningsprocessen fungerer bedst muligt |
| **Forrige trin:** | ← [6.1](#user-story-61-adgang-til-anonymiseret-henvisningsstatistik) *(bygger på afvisningsårsager fra [2.4](#user-story-24-afvise-en-henvisning))* |
| **Næste trin:** | *(Statistik, ingen yderligere trin)* |
{: .grid}

### User story 6.5 Statistik over videresendte henvisninger

> **User story:**  
> Som administrator ønsker jeg at have nem adgang til anonymiseret statistik om videresendte henvisninger,  
> når jeg skal undersøge om henvisningsprocessen fungerer bedst muligt,  
> så jeg bedre kan identificere områder som skal justeres for at forbedre henvisningsprocessen.

|---|---|
| **Oprindelse:** | Ny |
| **Primær FHIR-ressource:** | `Measure`, `MeasureReport`\* |
| **Triggerhændelse:** | Undersøgelse af om henvisningsprocessen fungerer bedst muligt |
| **Forrige trin:** | ← [6.1](#user-story-61-adgang-til-anonymiseret-henvisningsstatistik) *(bygger på videresendelser fra [2.5](#user-story-25-videresende-til-anden-modtager))* |
| **Næste trin:** | *(Statistik, ingen yderligere trin)* |
{: .grid}
