<div class="stu-note">
  <p><b>Bemærk: Dette er en disclaimer for denne side om "User stories for FHIR-baseret henvisningshåndtering"</b></p>
  <p>
    Oversigten er en mock-up på user stories og diagrammer og er på ingen måde nødvendigvis fuldt dækkende og fuldt retvisende. Det forsøges til stadighed at blive mere dækkende og mere retvisende.
    <br/>
    Oversigten er delvist udarbejdet sammen med AI-værktøjerne Clause og ChatGPT, så justeringer efter deres forslag må påregnes.
    <br/>
    Oversigten vil være velegnet til en dialog med de rette aktører om henvisningsaktiviteter på hhv Henviser- og Visitator-siden samt dialogen imellem dem.
  </p>
</div>

## User stories for FHIR-baseret henvisningshåndtering

Oversigten beskriver user stories for de to primære roller i et FHIR-baseret henvisningsflow: 
>**Henviser** (den der afsender en henvisning) <br/>**Visitator** (den der modtager og triagerer). 

Derudover beskrives user stories der kun opstår i den fælles udvekslingsdialog mellem de to parter. Al kommunikation foregår via FHIR-baserede meddelelser.

## User story oversigt med FHIR ressource

| User story | FHIR-ressource(r) | Retning |
|---|---|---|
| [Oprette henvisning](#user-story-11-oprette-en-ny-henvisning) | ServiceRequest | Henviser → Visitator |
| [Tilknytte dokumentation](#user-story-12-tilknytte-klinisk-dokumentation) | DiagnosticReport, Media, DocumentReference | Henviser → Visitator |
| [Ændre henvisning](#user-story-13-ændre-en-afsendt-henvisning) | ServiceRequest (revision) | Henviser → Visitator |
| [Tilbagekalde henvisning](#user-story-14-tilbagekalde-en-henvisning) | ServiceRequest (revoked) | Henviser → Visitator |
| [Monitorere status](#user-story-15-monitorere-status-på-afsendte-henvisninger) | Subscription, SubscriptionStatus | Begge |
| [Modtage afgørelse](#user-story-16-modtage-afgørelse-fra-visitatoren) | Task, SubscriptionNotification | Visitator → Henviser |
| [Modtage og kvittere](#user-story-21-modtage-og-kvittere-for-ny-henvisning) | Bundle, MessageHeader | Visitator (intern) |
| [Triagere og prioritere](#user-story-22-triagere-og-prioritere-en-henvisning) | Task | Visitator (intern) |
| [Acceptere og booke](#user-story-23-acceptere-en-henvisning-og-booke-forløb) | ServiceRequest, Appointment | Visitator → Henviser |
| [Afvise henvisning](#user-story-24-afvise-en-henvisning) | Task, ServiceRequest | Visitator → Henviser |
| [Videresende](#user-story-25-videresende-til-anden-modtager) | ServiceRequest (replaces) | Visitator → Ny modtager (Ny Visitator) |
| [Ændre prioritet](#user-story-26-ændre-prioritet-på-en-modtaget-henvisning) | ServiceRequest, SubscriptionNotification | Visitator → Henviser |
| [Anmode om supplement](#user-story-31-anmode-om-supplerende-oplysninger) | CommunicationRequest | Visitator → Henviser |
| [Besvare supplement](#user-story-32-besvare-anmodning-om-supplement) | Communication | Henviser → Visitator |
| [Faglig afklaring](#user-story-33-faglig-afklaring-i-dialog) | Communication (thread) | Begge |
| [Statusnotifikation](#user-story-34-statusnotifikation-til-henviser) | SubscriptionNotification | Visitator → Henviser |
| [Alternativ visitation](#user-story-35-aftale-om-alternativ-visitation) | Communication, Task | Begge |
| [Korrektionsaftale](#user-story-36-korrektionsaftale-om-fejl-i-afsendt-henvisning) | Communication, ServiceRequest | Begge |
{: .grid}

**Diagrammer:** 
> <br/>- Hver user storie refererer til et tilhørende PlantUML-diagram i filen `fhir-henvisning-use-cases-claude2.puml`. <br/>- Filen indeholder 18 `@startuml`-blokke — én per user storie — og kan renderes enkeltvis via PlantUML-CLI (`-p <diagram-id>`) eller i editorer med PlantUML-understøttelse (VS Code, IntelliJ, Confluence o.l.). <br/>- Diagrammerne kan også gengives samlet ved at ekskludere `!include`-direktiverne og blot åbne `.puml`-filen direkte. 

---

## Henviserens user stories

Disse user stories udføres selvstændigt af henviseren uden at kræve aktiv respons fra visitatoren ud over systemkvittering.

### User story 1.1 Oprette en ny henvisning

> **User story:** Som henviser ønsker jeg at kunne oprette og afsende en struktureret henvisning via FHIR, <br/>når jeg har truffet en klinisk beslutning om at viderehenvise en patient, <br/>så visitatoren modtager alle nødvendige oplysninger på et standardiseret format.

<p style="display: block;">
<img src="UC-1-1-Oprette-henvisning.svg" alt="UC-1-1-Oprette-henvisning" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

|---|
| Henviseren udfærdiger og afsender en ny henvisning til et modtagende tilbud. Henvisningen repræsenteres som en `ServiceRequest`-ressource med status `proposed` og sendes i en FHIR-`Bundle`. Henvisningen indeholder patientoplysninger, indikation, hastegrad og ønsket ydelse. |

|---|---|
| **Primær FHIR-ressource:** | `ServiceRequest` |
| **Triggerhændelse:** | Klinisk beslutning om at henvise patient |
| **Næste trin:** |→ [1.2 Tilknytte klinisk dokumentation](#user-story-12-tilknytte-klinisk-dokumentation) *(hvis supplerende materiale er relevant)* · <br/>→ [2.1 Modtage og kvittere for ny henvisning](#user-story-21-modtage-og-kvittere-for-ny-henvisning) *(visitatorsiden modtager)* |
{: .grid}

### User story 1.2 Tilknytte klinisk dokumentation

> **User story:** Som henviser ønsker jeg at kunne vedhæfte relevant klinisk dokumentation til en eksisterende henvisning, <br/>når jeg vurderer at visitatoren har brug for supplerende materiale for at træffe en god afgørelse, <br/>så beslutningsgrundlaget er samlet ét sted.

<p style="display: block;">
<img src="UC-1-2-Tilknytte-dokumentation.svg" alt="UC-1-1-Oprette-henvisning" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

|---|
| Henviseren vedhæfter supplerende klinisk materiale til en eksisterende henvisning — fx laboratoriesvar, billeddiagnostik eller tidligere epikriser. Materialet knyttes til `ServiceRequest`-ressourcen via referencer til `DiagnosticReport`, `Media` eller `DocumentReference`. |

|---|---|
| **Primær FHIR-ressource:** | `DiagnosticReport`, `Media`, `DocumentReference` |
| **Triggerhændelse:** | Behov for at understøtte klinisk beslutningsgrundlag |
| **Forrige trin:** | ← [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) *(hvis supplerende materiale er relevant)* |
| **Næste trin:** | → [2.1 Modtage og kvittere for ny henvisning](#user-story-21-modtage-og-kvittere-for-ny-henvisning) *(visitatoren modtager den berigede henvisning)* |
{: .grid}

### User story 1.3 Ændre en afsendt henvisning

> **User story:** Som henviser ønsker jeg at kunne rette indholdet i en allerede afsendt henvisning, <br/>når jeg opdager en fejl eller patientens kliniske situation ændrer sig, <br/>så visitatoren altid arbejder ud fra korrekte og aktuelle oplysninger.

<p style="display: block;">
<img src="UC-1-3-Aendre-henvisning.svg" alt="UC-1-1-Oprette-henvisning" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Henviseren opdaterer indholdet af en allerede afsendt henvisning — fx korrigerer indikation, hastegrad eller kontaktoplysninger. Opdateringen sker via en opdatering på den eksisterende `ServiceRequest`, og der sættes et revisionsflag så visitatoren notificeres om ændringen.

|---|---|
| **Primær FHIR-ressource:** | `ServiceRequest` (revision) |
| **Triggerhændelse:** | Fejl opdaget eller klinisk situation ændret efter afsendelse |
| **Forrige trin:** | ← [3.6 Korrektionsaftale](#user-story-36-korrektionsaftale-om-fejl-i-afsendt-henvisning) *(visitatoren anmoder om korrektion)* |
| **Næste trin:** | → [2.2 Triagere og prioritere en henvisning](#user-story-22-triagere-og-prioritere-en-henvisning) *(visitatoren modtager ændringsnotifikation og reviagerer)* |
{: .grid}

### User story 1.4 Tilbagekalde en henvisning

> **User story:** Som henviser ønsker jeg at kunne tilbagekalde en afsendt henvisning, <br/>når patienten ikke længere ønsker forløbet eller det kliniske grundlag er bortfaldet, <br/>så visitatoren ikke bruger ressourcer på en henvisning der ikke skal ekspederes.

<p style="display: block;">
<img src="UC-1-4-Tilbagekalde-henvisning.svg" alt="UC-1-1-Oprette-henvisning" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Henviseren annullerer en afsendt henvisning, der endnu ikke er ekspederet. `ServiceRequest`-status sættes til `revoked` og en notifikation sendes til visitatoren.

|---|---|
| **Primær FHIR-ressource:** | `ServiceRequest` (status = revoked) |
| **Triggerhændelse:** | Patienten ønsker ikke forløbet, eller klinisk grundlag er bortfaldet |
| **Forrige trin:** | ← [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) *(afsender ønsker at tilbagekalde)* |
| **Næste trin:** | *(Flowet afsluttes — ingen yderligere behandling påkrævet)* | |
{: .grid}

### User story 1.5 Monitorere status på afsendte henvisninger

> **User story:** Som henviser ønsker jeg løbende at kunne se status på mine afsendte og udestående henvisninger, <br/>når jeg har behov for overblik over patienternes videre forløb, <br/>så jeg kan følge op og informere patienterne korrekt.

<p style="display: block;">
<img src="UC-1-5-Monitorere-status.svg" alt="UC-1-1-Oprette-henvisning" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Henviseren følger løbende op på status for egne udestående henvisninger. Dette kan ske via FHIR-subscription (push) eller ved periodisk polling mod visitatorens FHIR-endpoint.

|---|---|
| **Primær FHIR-ressource:** | `Subscription`, `SubscriptionStatus`, `ServiceRequest` |
| **Triggerhændelse:** | Behov for overblik over egne afsendte henvisninger |
| **Forrige trin:** | ← [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) *(efter afsendelse ønskes overblik)* |
| **Næste trin:** | → [1.6 Modtage afgørelse fra visitatoren](#user-story-16-modtage-afgørelse-fra-visitatoren) *(statusoverblikket leder til modtagelse af den endelige afgørelse)* |
{: .grid}

### User story 1.6 Modtage afgørelse fra visitatoren

> **User story:** Som henviser ønsker jeg automatisk at modtage visitatorens afgørelse i mit journalsystem, <br/>når visitatoren har truffet beslutning om accept, afvisning eller alternativt tilbud, <br/>så jeg hurtigt kan handle og orientere patienten.

<p style="display: block;">
<img src="UC-1-6-Modtage-afgoerelse.svg" alt="UC-1-1-Oprette-henvisning" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Henviseren modtager visitatorens endelige afgørelse — accept, afvisning eller alternativt tilbud — og integrerer denne i eget journalsystem. Afgørelsen leveres som en `Task`-ressource eller notifikation med reference til den oprindelige `ServiceRequest`.

|---|---|
| **Primær FHIR-ressource:** | `Task`, `SubscriptionNotification` |
| **Triggerhændelse:** | Visitatoren har truffet afgørelse om henvisningen |
| **Forrige trin:** | ← [1.5 Monitorere status](#user-story-15-monitorere-status-på-afsendte-henvisninger) *(statusoverblikket leder hertil)* · <br/>← [3.4 Statusnotifikation](#user-story-34-statusnotifikation-til-henviser) *(notifikation udløser håndtering)* |
| **Næste trin:** | → [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) *(hvis afgørelsen er en afvisning og patienten skal viderehenvisies)* · *(Flowet afsluttes ved accept)* |
{: .grid}

## Visitatorens user stories

Disse user stories udføres selvstændigt af visitatoren som led i modtagelse og behandling af indkomne henvisninger.

### User story 2.1 Modtage og kvittere for ny henvisning

> **User story:** Som visitator ønsker jeg automatisk at modtage og kvittere for indkomne henvisninger via FHIR, <br/>når en ny `ServiceRequest` ankommer i mit endpoint, <br/>så afsenderen hurtigt får bekræftet at henvisningen er modtaget korrekt.

<p style="display: block;">
<img src="UC-2-1-Modtage-kvittere.svg" alt="UC-1-1-Oprette-henvisning" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Visitatoren modtager en indkommende FHIR-`Bundle` med en ny `ServiceRequest` og sender en teknisk kvittering (ACK) tilbage til afsendersystemet. Henvisningen registreres i visitationssystemet med status `active` eller `on-hold` afhængigt af triagekapacitet.

|---|---|
| **Primær FHIR-ressource:** | `Bundle`, `MessageHeader`, `ServiceRequest` |
| **Triggerhændelse:** | Indkommende henvisning i FHIR-endpoint |
| **Forrige trin:** | ← [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) *(afsendelse af ny henvisning)* · <br/>← [1.2 Tilknytte klinisk dokumentation](#user-story-12-tilknytte-klinisk-dokumentation) *(beriget henvisning modtages)* · <br/>← [2.5 Videresende](#user-story-25-videresende-til-anden-modtager) *(ny modtager starter modtagelsesflow)* |
| **Næste trin:** | → [2.2 Triagere og prioritere en henvisning](#user-story-22-triagere-og-prioritere-en-henvisning) |
{: .grid}

### User story 2.2 Triagere og prioritere en henvisning

> **User story:** Som visitator ønsker jeg at kunne foretage en struktureret triage af en modtaget henvisning og dokumentere mit udfald, <br/>når en ny eller opdateret henvisning er klar til klinisk vurdering, <br/>så prioriteringen er sporbar og ensartet på tværs af alle indkomne sager.

<p style="display: block;">
<img src="UC-2-2-Triagere-prioritere.svg" alt="UC-1-1-Oprette-henvisning" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Visitatoren vurderer henvisningens faglige indhold, klassificerer hastegrad og prioriterer i forhold til øvrige indkomne henvisninger. Triage-udfaldet dokumenteres i en `Task`-ressource med udfald og begrundelse.

|---|---|
| **Primær FHIR-ressource:** | `Task` (triage-outcome, priority) |
| **Triggerhændelse:** | Ny eller opdateret henvisning klar til klinisk vurdering |
| **Forrige trin:** | ← [2.1 Modtage og kvittere](#user-story-21-modtage-og-kvittere-for-ny-henvisning) *(efter kvittering påbegyndes triage)* · <br/>← [1.3 Ændre en afsendt henvisning](#user-story-13-ændre-en-afsendt-henvisning) *(ændringsnotifikation modtaget)* · <br/>← [3.2 Besvare anmodning om supplement](#user-story-32-besvare-anmodning-om-supplement) *(supplement modtaget, triage genoptages)* · <br/>← [3.6 Korrektionsaftale](#user-story-36-korrektionsaftale-om-fejl-i-afsendt-henvisning) *(triage genoptages efter korrektion)* |
| **Næste trin:** | → [2.3 Acceptere en henvisning og booke forløb](#user-story-23-acceptere-en-henvisning-og-booke-forløb) *(positiv afgørelse)* · <br/>→ [2.4 Afvise en henvisning](#user-story-24-afvise-en-henvisning) *(negativ afgørelse)* · <br/>→ [3.1 Anmode om supplerende oplysninger](#user-story-31-anmode-om-supplerende-oplysninger) *(grundlaget er utilstrækkeligt)* · <br/>→ [2.6 Ændre prioritet](#user-story-26-ændre-prioritet-på-en-modtaget-henvisning) *(prioriteten justeres)* |
{: .grid}

### User story 2.3 Acceptere en henvisning og booke forløb

> **User story:** Som visitator ønsker jeg at kunne acceptere en henvisning og oprette en booking, <br/>når min visitationsafgørelse er positiv, <br/>så patienten får en tid og henviseren automatisk modtager bekræftelsen.

<p style="display: block;">
<img src="UC-2-3-Acceptere-booke.svg" alt="UC-1-1-Oprette-henvisning" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Visitatoren accepterer henvisningen og opretter et forløb. Der bookes en tid, og `ServiceRequest`-status opdateres til `active`. En `Appointment`-ressource oprettes og linkes til henvisningen.

|---|---|
| **Primær FHIR-ressource:** | `ServiceRequest` (active), `Appointment` (booked) |
| **Triggerhændelse:** | Positiv visitationsafgørelse |
| **Forrige trin:** | ← [2.2 Triagere og prioritere](#user-story-22-triagere-og-prioritere-en-henvisning) *(positiv afgørelse)* · <br/>← [3.5 Alternativ visitation](#user-story-35-aftale-om-alternativ-visitation) *(alternativt tilbud accepteres)* · <br/>← [3.3 Faglig afklaring](#user-story-33-faglig-afklaring-i-dialog) *(afklaring munder ud i accept)* |
| **Næste trin:** | → [3.4 Statusnotifikation til henviser](#user-story-34-statusnotifikation-til-henviser) *(henviser notificeres om accept og booking)* |
{: .grid}

### User story 2.4 Afvise en henvisning

> **User story:** Som visitator ønsker jeg at kunne afvise en henvisning med en dokumenteret begrundelse, <br/>når indikationen ikke er opfyldt eller kapaciteten er nået, <br/>så henviseren forstår årsagen og kan tage stilling til næste skridt for patienten.

<p style="display: block;">
<img src="UC-2-4-Afvise-henvisning.svg" alt="UC-1-1-Oprette-henvisning" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Visitatoren afviser henvisningen med en faglig eller kapacitetsmæssig begrundelse. `ServiceRequest`-status sættes til `revoked` eller `completed` med en `Task`-ressource der angiver årsag til afvisning.

|---|---|
| **Primær FHIR-ressource:** | `Task` (declined + reason), `ServiceRequest` |
| **Triggerhændelse:** | Indikation ikke opfyldt, forkert visitationsspor, eller kapacitetsloft nået |
| **Forrige trin:** | ← [2.2 Triagere og prioritere](#user-story-22-triagere-og-prioritere-en-henvisning) *(negativ afgørelse)* · <br/>← [3.3 Faglig afklaring](#user-story-33-faglig-afklaring-i-dialog) *(afklaring munder ud i afvisning)* |
| **Næste trin:** | → [3.4 Statusnotifikation til henviser](#user-story-34-statusnotifikation-til-henviser) *(henviser notificeres om afvisning)* · <br/>→ [3.5 Aftale om alternativ visitation](#user-story-35-aftale-om-alternativ-visitation) *(hvis alternativ løsning bør afsøges)* |
{: .grid}

### User story 2.5 Videresende til anden modtager

> **User story:** Som visitator ønsker jeg at kunne videresende en fejlplaceret henvisning til rette modtager, <br/>når jeg vurderer at et andet tilbud er bedre egnet, <br/>så patienten ikke unødigt forsinkes og henviseren holdes orienteret om omdirigeringen.

<p style="display: block;">
<img src="UC-2-5-Videresende.svg" alt="UC-1-1-Oprette-henvisning" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Visitatoren vurderer at henvisningen hører hjemme et andet sted og videresender. Der oprettes en ny `ServiceRequest` med reference til den originale via `replaces`-attributten, og der sendes notifikation til den oprindelige henviser.

|---|---|
| **Primær FHIR-ressource:** | `ServiceRequest` (replaces), `Task`, `Communication` |
| **Triggerhændelse:** | Forkert modtager eller bedre egnet tilbud identificeret |
| **Forrige trin:** | ← [2.2 Triagere og prioritere](#user-story-22-triagere-og-prioritere-en-henvisning) *(forkert modtager identificeret)* |
| **Næste trin:** | → [2.1 Modtage og kvittere for ny henvisning](#user-story-21-modtage-og-kvittere-for-ny-henvisning) *(ny modtager starter sit eget modtagelsesflow)* · <br/>→ [3.4 Statusnotifikation til henviser](#user-story-34-statusnotifikation-til-henviser) *(den oprindelige henviser orienteres)* |
{: .grid}

### User story 2.6 Ændre prioritet på en modtaget henvisning

> **User story:** Som visitator ønsker jeg at kunne justere prioriteten på en allerede modtaget henvisning, <br/>når ny klinisk information eller ændret kapacitetssituation tilsiger det, <br/>så den kliniske hastegrad afspejles korrekt og henviseren notificeres om ændringen.

<p style="display: block;">
<img src="UC-2-6-Aendre-prioritet.svg" alt="UC-1-1-Oprette-henvisning" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Visitatoren revurderer hastegraden for en allerede modtaget henvisning — fx på baggrund af ny klinisk information eller ændret kapacitetssituation. Prioriteten opdateres på `ServiceRequest` og der sendes notifikation til henviseren.

|---|---|
| **Primær FHIR-ressource:** | `ServiceRequest` (priority update), `SubscriptionNotification` |
| **Triggerhændelse:** | Ny information ændrer klinisk hastegrad |
| **Forrige trin:** | ← [2.2 Triagere og prioritere](#user-story-22-triagere-og-prioritere-en-henvisninger) *(prioritetsjustering under triage)* |
| **Næste trin:** | → [3.4 Statusnotifikation til henviser](#user-story-34-statusnotifikation-til-henviser) *(henviser notificeres om den ændrede prioritet)* |
{: .grid}

## Udvekslingsdialog (fælles user stories)

Disse user stories forudsætter aktiv kommunikation frem og tilbage mellem henviser og visitator via FHIR-beskeder.

### User story 3.1 Anmode om supplerende oplysninger

> **User story:** Som visitator ønsker jeg at kunne sende en struktureret anmodning om supplerende oplysninger til henviseren, <br/>når grundlaget for triage er utilstrækkeligt, <br/>så jeg kan træffe en fagligt forsvarlig visitationsafgørelse uden at afvise unødigt.

<p style="display: block;">
<img src="UC-3-1-Anmode-supplement.svg" alt="UC-1-1-Oprette-henvisning" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Visitatoren mangler oplysninger for at kunne triagere og sender en struktureret anmodning til henviseren om at supplere med konkrete kliniske data — fx blodprøveresultater, BMI, medicinliste eller tidligere forløb.

|---|---|
| **Primær FHIR-ressource:** | `CommunicationRequest` (fra visitator til henviser) |
| **Triggerhændelse:** | Utilstrækkeligt grundlag for visitationsafgørelse |
| **Forrige trin:** | ← [2.2 Triagere og prioritere](#user-story-22-triagere-og-prioritere-en-henvisning) *(utilstrækkeligt grundlag for triage)* |
| **Næste trin:** | → [3.2 Besvare anmodning om supplement](#user-story-32-besvare-anmodning-om-supplement) |
{: .grid}

### User story 3.2 Besvare anmodning om supplement

> **User story:** Som henviser ønsker jeg at kunne besvare en supplement-anmodning med de efterspurgte kliniske oplysninger, <br/>når visitatoren har bedt om yderligere data, <br/>så visitatoren hurtigt kan genoptage og afslutte triage-processen.

<p style="display: block;">
<img src="UC-3-2-Besvare-supplement.svg" alt="UC-1-1-Oprette-henvisning" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Henviseren modtager en supplement-anmodning og besvarer denne ved at sende de efterspurgte oplysninger. Svaret sendes som en `Communication`-ressource med reference til den oprindelige `CommunicationRequest` og til `ServiceRequest`.

|---|---|
| **Primær FHIR-ressource:** | `Communication` (reply, in-response-to) |
| **Triggerhændelse:** | Modtagelse af CommunicationRequest fra visitatoren |
| **Forrige trin:** | ← [3.1 Anmode om supplerende oplysninger](#user-story-31-anmode-om-supplerende-oplysninger) *(supplement anmodet)* |
| **Næste trin:** | → [2.2 Triagere og prioritere en henvisning](#user-story-22-triagere-og-prioritere-en-henvisning) *(visitatoren genoptager triage med det modtagne supplement)* · <br/>→ [3.3 Faglig afklaring i dialog](#user-story-33-faglig-afklaring-i-dialog) *(hvis svaret afføder yderligere spørgsmål)* |
{: .grid}

### User story 3.3 Faglig afklaring i dialog

> **User story:** Som henviser og visitator ønsker vi begge at kunne føre en struktureret faglig dialog om en konkret henvisning, <br/>når indikation, egnethed eller behandlingsvalg er uklart, <br/>så vi i fællesskab kan nå frem til den rigtige afgørelse for patienten uden at skulle bruge andre kommunikationskanaler.

<p style="display: block;">
<img src="UC-3-3-Faglig-afklaring.svg" alt="UC-1-1-Oprette-henvisning" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Henviser og visitator udveksler kliniske spørgsmål og svar for at afklare indikation, behandlingsegnethed eller alternativ tilgang — uden at dette nødvendigvis afklares i én besked. Dialogen føres som en kæde af `Communication`-ressourcer med indbyrdes referencer.

|---|---|
| **Primær FHIR-ressource:** | `Communication` (thread med in-response-to-kæde) |
| **Triggerhændelse:** | Faglig uklarhed der kræver mere end én udveksling |
| **Forrige trin:** | ← [3.2 Besvare anmodning om supplement](#user-story-32-besvare-anmodning-om-supplement) *(svaret afføder yderligere spørgsmål)* |
| **Næste trin:** | → [2.3 Acceptere en henvisning og booke forløb](#user-story-23-acceptere-en-henvisning-og-booke-forløb) *(afklaring munder ud i accept)* · <br/>→ [2.4 Afvise en henvisning](#user-story-24-afvise-en-henvisning) *(afklaring munder ud i afvisning)* |
{: .grid}

### User story 3.4 Statusnotifikation til henviser

> **User story:** Som henviser ønsker jeg automatisk at modtage en notifikation, <br/>når status på en af mine henvisninger ændrer sig hos visitatoren, <br/>så jeg til enhver tid er opdateret om forløbet uden at skulle forespørge aktivt.

<p style="display: block;">
<img src="UC-3-4-Statusnotifikation.svg" alt="UC-1-1-Oprette-henvisning" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Visitatoren notificerer automatisk henviseren ved statusskift på en afsendt henvisning — fx modtaget, under vurdering, accepteret eller afvist. Notifikationen leveres via FHIR-subscription og indeholder reference til den opdaterede `ServiceRequest`.

|---|---|
| **Primær FHIR-ressource:** | `SubscriptionNotification`, `ServiceRequest` |
| **Triggerhændelse:** | Ethvert statusskift på en aktiv henvisning hos visitatoren |
| **Forrige trin:** | ← [2.3 Acceptere og booke](#user-story-23-acceptere-en-henvisning-og-booke-forløb) *(accept udløser notifikation)* · <br/>← [2.4 Afvise en henvisning](#user-story-24-afvise-en-henvisning) *(afvisning udløser notifikation)* · <br/>← [2.6 Ændre prioritet](#user-story-26-ændre-prioritet-på-en-modtaget-henvisning) *(prioritetsændring udløser notifikation)* |
| **Næste trin:** | → [1.6 Modtage afgørelse fra visitatoren](#user-story-16-modtage-afgørelse-fra-visitatoren) *(notifikationen udløser håndtering af afgørelsen hos henviseren)* |
{: .grid}

### User story 3.5 Aftale om alternativ visitation

> **User story:** Som visitator ønsker jeg at kunne indlede en dialog med henviseren om et alternativt tilbud, <br/>når jeg ikke kan imødekomme den primære henvisning, <br/>så patienten ikke ender i en blindgyde og vi i fællesskab finder en løsning.

<p style="display: block;">
<img src="UC-3-5-Alternativ-visitation.svg" alt="UC-1-1-Oprette-henvisning" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Henviser og visitator forhandler i fællesskab om et alternativt tilbud, <br/>når det primære visitationsspor ikke er muligt. Dialogen foregår via `Communication`, og den resulterende aftale dokumenteres i en `Task` med reference til det alternative tilbud.

|---|---|
| **Primær FHIR-ressource:** | `Communication`, `Task`, `ServiceRequest` (alternativ) |
| **Triggerhændelse:** | Afvisning kombineret med behov for at finde alternativ løsning for patienten |
| **Forrige trin:** | ← [2.4 Afvise en henvisning](#user-story-24-afvise-en-henvisning) *(afvisning kombineret med søgning efter alternativ)* |
| **Næste trin:** | → [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) *(nyt alternativt tilbud kræver ny henvisning)* · <br/>→ [2.3 Acceptere en henvisning og booke forløb](#user-story-23-acceptere-en-henvisning-og-booke-forløb) *(alternativt tilbud accepteres)* |
{: .grid}

### User story 3.6 Korrektionsaftale om fejl i afsendt henvisning

> **User story:** Som visitator ønsker jeg at kunne kontakte henviseren og aftale en korrektion, <br/>når jeg opdager en fejl i en modtaget henvisning, <br/>så fejlen rettes på en koordineret og sporbar måde uden at vi mister historikken.

<p style="display: block;">
<img src="UC-3-6-Korrektionsaftale.svg" alt="UC-1-1-Oprette-henvisning" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Visitatoren opdager en fejl i en modtaget henvisning — fx forkert CPR-nummer, forkert ydelseskode eller manglende samtykkedokumentation — og indleder en dialog med henviseren om korrektion. Korrektionen aftales via `Communication`-besked og gennemføres med en efterfølgende opdatering af `ServiceRequest`.

|---|---|
| **Primær FHIR-ressource:** | `Communication`, `ServiceRequest` (korrektion) |
| **Triggerhændelse:** | Fejl opdaget under modtagelse eller triage hos visitatoren |
| **Forrige trin:** | ← [2.4 Afvise en henvisning](#user-story-24-afvise-en-henvisning) *(fejl opdaget, korrektionsdiolog indledes)* |
| **Næste trin:** | → [1.3 Ændre en afsendt henvisning](#user-story-13-ændre-en-afsendt-henvisning) *(henviser retter og sender)* · <br/>→ [2.2 Triagere og prioritere en henvisning](#user-story-22-triagere-og-prioritere-en-henvisning) *(visitatoren genoptager triage efter korrektion)* |
{: .grid}

