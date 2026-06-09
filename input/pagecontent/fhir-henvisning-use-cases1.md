# Use cases for FHIR-baseret henvisningshåndtering

Oversigten beskriver use cases for de to primære roller i et FHIR-baseret henvisningsflow: **henviseren** (den der afsender en henvisning) og **visitatoren** (den der modtager og triagerer). Derudover beskrives use cases der kun opstår i den fælles udvekslingsdialog mellem de to parter. Al kommunikation foregår via FHIR-baserede beskeder.

---

## 1. Henviserens use cases

Disse use cases udføres selvstændigt af henviseren uden at kræve aktiv respons fra visitatoren ud over systemkvittering.

### 1.1 Oprette en ny henvisning

Henviseren udfærdiger og afsender en ny henvisning til et modtagende tilbud. Henvisningen repræsenteres som en `ServiceRequest`-ressource med status `proposed` og sendes i en FHIR-`Bundle`. Henvisningen indeholder patientoplysninger, indikation, hastegrad og ønsket ydelse.

> **User story:** Som henviser ønsker jeg at kunne oprette og afsende en struktureret henvisning via FHIR, når jeg har truffet en klinisk beslutning om at viderehenvise en patient, så visitatoren modtager alle nødvendige oplysninger på et standardiseret format.

**Primær FHIR-ressource:** `ServiceRequest`
**Triggerhændelse:** Klinisk beslutning om at henvise patient

---

### 1.2 Tilknytte klinisk dokumentation

Henviseren vedhæfter supplerende klinisk materiale til en eksisterende henvisning — fx laboratoriesvar, billeddiagnostik eller tidligere epikriser. Materialet knyttes til `ServiceRequest`-ressourcen via referencer til `DiagnosticReport`, `Media` eller `DocumentReference`.

> **User story:** Som henviser ønsker jeg at kunne vedhæfte relevant klinisk dokumentation til en eksisterende henvisning, når jeg vurderer at visitatoren har brug for supplerende materiale for at træffe en god afgørelse, så beslutningsgrundlaget er samlet ét sted.

**Primær FHIR-ressource:** `DiagnosticReport`, `Media`, `DocumentReference`
**Triggerhændelse:** Behov for at understøtte klinisk beslutningsgrundlag

---

### 1.3 Ændre en afsendt henvisning

Henviseren opdaterer indholdet af en allerede afsendt henvisning — fx korrigerer indikation, hastegrad eller kontaktoplysninger. Opdateringen sker via en `PUT`-operation på den eksisterende `ServiceRequest`, og der sættes et revisionsflag så visitatoren notificeres om ændringen.

> **User story:** Som henviser ønsker jeg at kunne rette indholdet i en allerede afsendt henvisning, når jeg opdager en fejl eller patientens kliniske situation ændrer sig, så visitatoren altid arbejder ud fra korrekte og aktuelle oplysninger.

**Primær FHIR-ressource:** `ServiceRequest` (PUT / revision)
**Triggerhændelse:** Fejl opdaget eller klinisk situation ændret efter afsendelse

---

### 1.4 Tilbagekalde en henvisning

Henviseren annullerer en afsendt henvisning, der endnu ikke er ekspederet. `ServiceRequest`-status sættes til `revoked` og en notifikation sendes til visitatoren.

> **User story:** Som henviser ønsker jeg at kunne tilbagekalde en afsendt henvisning, når patienten ikke længere ønsker forløbet eller det kliniske grundlag er bortfaldet, så visitatoren ikke bruger ressourcer på en henvisning der ikke skal ekspederes.

**Primær FHIR-ressource:** `ServiceRequest` (status = revoked)
**Triggerhændelse:** Patienten ønsker ikke forløbet, eller klinisk grundlag er bortfaldet

---

### 1.5 Monitorere status på afsendte henvisninger

Henviseren følger løbende op på status for egne udestående henvisninger. Dette kan ske via FHIR-subscription (push) eller ved periodisk polling mod visitatorens FHIR-endpoint.

> **User story:** Som henviser ønsker jeg løbende at kunne se status på mine afsendte og udestående henvisninger, når jeg har behov for overblik over patienternes videre forløb, så jeg kan følge op og informere patienterne korrekt.

**Primær FHIR-ressource:** `Subscription`, `SubscriptionStatus`, `ServiceRequest`
**Triggerhændelse:** Behov for overblik over egne afsendte henvisninger

---

### 1.6 Modtage afgørelse fra visitatoren

Henviseren modtager visitatorens endelige afgørelse — accept, afvisning eller alternativt tilbud — og integrerer denne i eget journalsystem. Afgørelsen leveres som en `Task`-ressource eller notifikation med reference til den oprindelige `ServiceRequest`.

> **User story:** Som henviser ønsker jeg automatisk at modtage visitatorens afgørelse i mit journalsystem, når visitatoren har truffet beslutning om accept, afvisning eller alternativt tilbud, så jeg hurtigt kan handle og orientere patienten.

**Primær FHIR-ressource:** `Task`, `SubscriptionNotification`
**Triggerhændelse:** Visitatoren har truffet afgørelse om henvisningen

---

## 2. Visitatorens use cases

Disse use cases udføres selvstændigt af visitatoren som led i modtagelse og behandling af indkomne henvisninger.

### 2.1 Modtage og kvittere for ny henvisning

Visitatoren modtager en indkommende FHIR-`Bundle` med en ny `ServiceRequest` og sender en teknisk kvittering (ACK) tilbage til afsendersystemet. Henvisningen registreres i visitationssystemet med status `active` eller `on-hold` afhængigt af triagekapacitet.

> **User story:** Som visitator ønsker jeg automatisk at modtage og kvittere for indkomne henvisninger via FHIR, når en ny `ServiceRequest` ankommer i mit endpoint, så afsenderen hurtigt får bekræftet at henvisningen er modtaget korrekt.

**Primær FHIR-ressource:** `Bundle`, `MessageHeader`, `ServiceRequest`
**Triggerhændelse:** Indkommende henvisning i FHIR-endpoint

---

### 2.2 Triagere og prioritere en henvisning

Visitatoren vurderer henvisningens faglige indhold, klassificerer hastegrad og prioriterer i forhold til øvrige indkomne henvisninger. Triage-udfaldet dokumenteres i en `Task`-ressource med udfald og begrundelse.

> **User story:** Som visitator ønsker jeg at kunne foretage en struktureret triage af en modtaget henvisning og dokumentere mit udfald, når en ny eller opdateret henvisning er klar til klinisk vurdering, så prioriteringen er sporbar og ensartet på tværs af alle indkomne sager.

**Primær FHIR-ressource:** `Task` (triage-outcome, priority)
**Triggerhændelse:** Ny eller opdateret henvisning klar til klinisk vurdering

---

### 2.3 Acceptere en henvisning og booke forløb

Visitatoren accepterer henvisningen og opretter et forløb. Der bookes en tid, og `ServiceRequest`-status opdateres til `active`. En `Appointment`-ressource oprettes og linkes til henvisningen.

> **User story:** Som visitator ønsker jeg at kunne acceptere en henvisning og oprette en booking, når min visitationsafgørelse er positiv, så patienten får en tid og henviseren automatisk modtager bekræftelsen.

**Primær FHIR-ressource:** `ServiceRequest` (active), `Appointment` (booked)
**Triggerhændelse:** Positiv visitationsafgørelse

---

### 2.4 Afvise en henvisning

Visitatoren afviser henvisningen med en faglig eller kapacitetsmæssig begrundelse. `ServiceRequest`-status sættes til `revoked` eller `completed` med en `Task`-ressource der angiver årsag til afvisning.

> **User story:** Som visitator ønsker jeg at kunne afvise en henvisning med en dokumenteret begrundelse, når indikationen ikke er opfyldt eller kapaciteten er nået, så henviseren forstår årsagen og kan tage stilling til næste skridt for patienten.

**Primær FHIR-ressource:** `Task` (declined + reason), `ServiceRequest`
**Triggerhændelse:** Indikation ikke opfyldt, forkert visitationsspor, eller kapacitetsloft nået

---

### 2.5 Videresende til anden modtager

Visitatoren vurderer at henvisningen hører hjemme et andet sted og videresender. Der oprettes en ny `ServiceRequest` med reference til den originale via `replaces`-attributten, og der sendes notifikation til den oprindelige henviser.

> **User story:** Som visitator ønsker jeg at kunne videresende en fejlplaceret henvisning til rette modtager, når jeg vurderer at et andet tilbud er bedre egnet, så patienten ikke unødigt forsinkes og henviseren holdes orienteret om omdirigeringen.

**Primær FHIR-ressource:** `ServiceRequest` (replaces), `Task`, `Communication`
**Triggerhændelse:** Forkert modtager eller bedre egnet tilbud identificeret

---

### 2.6 Ændre prioritet på en modtaget henvisning

Visitatoren revurderer hastegraden for en allerede modtaget henvisning — fx på baggrund af ny klinisk information eller ændret kapacitetssituation. Prioriteten opdateres på `ServiceRequest` og der sendes notifikation til henviseren.

> **User story:** Som visitator ønsker jeg at kunne justere prioriteten på en allerede modtaget henvisning, når ny klinisk information eller ændret kapacitetssituation tilsiger det, så den kliniske hastegrad afspejles korrekt og henviseren notificeres om ændringen.

**Primær FHIR-ressource:** `ServiceRequest` (priority update), `SubscriptionNotification`
**Triggerhændelse:** Ny information ændrer klinisk hastegrad

---

## 3. Udvekslingsdialog (fælles use cases)

Disse use cases forudsætter aktiv kommunikation frem og tilbage mellem henviser og visitator via FHIR-beskeder.

### 3.1 Anmode om supplerende oplysninger

Visitatoren mangler oplysninger for at kunne triagere og sender en struktureret anmodning til henviseren om at supplere med konkrete kliniske data — fx blodprøveresultater, BMI, medicinliste eller tidligere forløb.

> **User story:** Som visitator ønsker jeg at kunne sende en struktureret anmodning om supplerende oplysninger til henviseren, når grundlaget for triage er utilstrækkeligt, så jeg kan træffe en fagligt forsvarlig visitationsafgørelse uden at afvise unødigt.

**Primær FHIR-ressource:** `CommunicationRequest` (fra visitator til henviser)
**Triggerhændelse:** Utilstrækkeligt grundlag for visitationsafgørelse

---

### 3.2 Besvare anmodning om supplement

Henviseren modtager en supplement-anmodning og besvarer denne ved at sende de efterspurgte oplysninger. Svaret sendes som en `Communication`-ressource med reference til den oprindelige `CommunicationRequest` og til `ServiceRequest`.

> **User story:** Som henviser ønsker jeg at kunne besvare en supplement-anmodning med de efterspurgte kliniske oplysninger, når visitatoren har bedt om yderligere data, så visitatoren hurtigt kan genoptage og afslutte triage-processen.

**Primær FHIR-ressource:** `Communication` (reply, in-response-to)
**Triggerhændelse:** Modtagelse af CommunicationRequest fra visitatoren

---

### 3.3 Faglig afklaring i dialog

Henviser og visitator udveksler kliniske spørgsmål og svar for at afklare indikation, behandlingsegnethed eller alternativ tilgang — uden at dette nødvendigvis afklares i én besked. Dialogen føres som en kæde af `Communication`-ressourcer med indbyrdes referencer.

> **User story:** Som henviser og visitator ønsker vi begge at kunne føre en struktureret faglig dialog om en konkret henvisning, når indikation, egnethed eller behandlingsvalg er uklart, så vi i fællesskab kan nå frem til den rigtige afgørelse for patienten uden at skulle bruge andre kommunikationskanaler.

**Primær FHIR-ressource:** `Communication` (thread med in-response-to-kæde)
**Triggerhændelse:** Faglig uklarhed der kræver mere end én udveksling

---

### 3.4 Statusnotifikation til henviser

Visitatoren notificerer automatisk henviseren ved statusskift på en afsendt henvisning — fx modtaget, under vurdering, accepteret eller afvist. Notifikationen leveres via FHIR-subscription og indeholder reference til den opdaterede `ServiceRequest`.

> **User story:** Som henviser ønsker jeg automatisk at modtage en notifikation, når status på en af mine henvisninger ændrer sig hos visitatoren, så jeg til enhver tid er opdateret om forløbet uden at skulle forespørge aktivt.

**Primær FHIR-ressource:** `SubscriptionNotification`, `ServiceRequest`
**Triggerhændelse:** Ethvert statusskift på en aktiv henvisning hos visitatoren

---

### 3.5 Aftale om alternativ visitation

Henviser og visitator forhandler i fællesskab om et alternativt tilbud, når det primære visitationsspor ikke er muligt. Dialogen foregår via `Communication`, og den resulterende aftale dokumenteres i en `Task` med reference til det alternative tilbud.

> **User story:** Som visitator ønsker jeg at kunne indlede en dialog med henviseren om et alternativt tilbud, når jeg ikke kan imødekomme den primære henvisning, så patienten ikke ender i en blindgyde og vi i fællesskab finder en løsning.

**Primær FHIR-ressource:** `Communication`, `Task`, `ServiceRequest` (alternativ)
**Triggerhændelse:** Afvisning kombineret med behov for at finde alternativ løsning for patienten

---

### 3.6 Korrektionsaftale om fejl i afsendt henvisning

Visitatoren opdager en fejl i en modtaget henvisning — fx forkert CPR-nummer, forkert ydelseskode eller manglende samtykkedokumentation — og indleder en dialog med henviseren om korrektion. Korrektionen aftales via `Communication`-besked og gennemføres med en efterfølgende `PUT`-opdatering af `ServiceRequest`.

> **User story:** Som visitator ønsker jeg at kunne kontakte henviseren og aftale en korrektion, når jeg opdager en fejl i en modtaget henvisning, så fejlen rettes på en koordineret og sporbar måde uden at vi mister historikken.

**Primær FHIR-ressource:** `Communication`, `ServiceRequest` (PUT/korrektion)
**Triggerhændelse:** Fejl opdaget under modtagelse eller triage hos visitatoren

---

## Ressourceoversigt

| Use case | FHIR-ressource(r) | Retning |
|---|---|---|
| Oprette henvisning | ServiceRequest | Henviser → Visitator |
| Tilknytte dokumentation | DiagnosticReport, Media, DocumentReference | Henviser → Visitator |
| Ændre henvisning | ServiceRequest (PUT) | Henviser → Visitator |
| Tilbagekalde henvisning | ServiceRequest (revoked) | Henviser → Visitator |
| Monitorere status | Subscription, SubscriptionStatus | Begge |
| Modtage afgørelse | Task, SubscriptionNotification | Visitator → Henviser |
| Modtage og kvittere | Bundle, MessageHeader | Visitator (intern) |
| Triagere og prioritere | Task | Visitator (intern) |
| Acceptere og booke | ServiceRequest, Appointment | Visitator → Henviser |
| Afvise henvisning | Task, ServiceRequest | Visitator → Henviser |
| Videresende | ServiceRequest (replaces) | Visitator → Ny modtager |
| Ændre prioritet | ServiceRequest, SubscriptionNotification | Visitator → Henviser |
| Anmode om supplement | CommunicationRequest | Visitator → Henviser |
| Besvare supplement | Communication | Henviser → Visitator |
| Faglig afklaring | Communication (thread) | Begge |
| Statusnotifikation | SubscriptionNotification | Visitator → Henviser |
| Alternativ visitation | Communication, Task | Begge |
| Korrektionsaftale | Communication, ServiceRequest | Begge |
