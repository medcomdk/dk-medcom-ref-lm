# Fhir Henvisning Use Cases Claude - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* **Fhir Henvisning Use Cases Claude**

## Fhir Henvisning Use Cases Claude

# Use Cases for FHIR-baseret Henvisningshåndtering

> **FHIR R4 · Henvisningsworkflow**

Oversigt over use cases for de to primære roller — **henviseren** og **visitatoren** — samt de fælles use cases der opstår i udvekslingsdialogen mellem dem. Al kommunikation foregår via FHIR-baserede beskeder.

-------

## Sektion 1 — Henviserens use cases

Udføres selvstændigt af henviseren uden at kræve aktiv respons fra visitatoren ud over systemkvittering.

-------

### 1.1 Oprette en ny henvisning

Henviseren udfærdiger og afsender en ny henvisning til et modtagende tilbud. Henvisningen repræsenteres som en `ServiceRequest`-ressource med status `proposed` og sendes i en FHIR-`Bundle`. Henvisningen indeholder patientoplysninger, indikation, hastegrad og ønsket ydelse.

> **Som henviser ønsker jeg at kunne oprette og afsende en struktureret henvisning via FHIR, 
når jeg har truffet en klinisk beslutning om at viderehenvise en patient, 
så visitatoren modtager alle nødvendige oplysninger på et standardiseret format.**

| | |
| :--- | :--- |
| **Ressource** | `ServiceRequest`status=proposed |
| **Trigger** | Klinisk beslutning om at henvise patient |
| **Næste trin** | →[1.2 Tilknytte dok.](#12-tilknytte-klinisk-dokumentation)·→[2.1 Modtage](#21-modtage-og-kvittere-for-ny-henvisning) |

-------

### 1.2 Tilknytte klinisk dokumentation

Henviseren vedhæfter supplerende klinisk materiale til en eksisterende henvisning — fx laboratoriesvar, billeddiagnostik eller tidligere epikriser. Materialet knyttes til `ServiceRequest`-ressourcen via referencer til `DiagnosticReport`, `Media` eller `DocumentReference`.

> **Som henviser ønsker jeg at kunne vedhæfte relevant klinisk dokumentation til en eksisterende henvisning, 
når jeg vurderer at visitatoren har brug for supplerende materiale for at træffe en god afgørelse, 
så beslutningsgrundlaget er samlet ét sted.**

| | |
| :--- | :--- |
| **Ressource** | `DiagnosticReport`·`Media`·`DocumentReference` |
| **Trigger** | Behov for at understøtte klinisk beslutningsgrundlag |
| **Næste trin** | →[2.1 Modtage](#21-modtage-og-kvittere-for-ny-henvisning) |

-------

### 1.3 Ændre en afsendt henvisning

Henviseren opdaterer indholdet af en allerede afsendt henvisning — fx korrigerer indikation, hastegrad eller kontaktoplysninger. Opdateringen sker via en `PUT`-operation på den eksisterende `ServiceRequest`, og der sættes et revisionsflag så visitatoren notificeres.

> **Som henviser ønsker jeg at kunne rette indholdet i en allerede afsendt henvisning, 
når jeg opdager en fejl eller patientens kliniske situation ændrer sig, 
så visitatoren altid arbejder ud fra korrekte og aktuelle oplysninger.**

| | |
| :--- | :--- |
| **Ressource** | `ServiceRequest`(PUT / revision) |
| **Trigger** | Fejl opdaget eller klinisk situation ændret efter afsendelse |
| **Næste trin** | →[2.2 Triagere](#22-triagere-og-prioritere-en-henvisning) |

-------

### 1.4 Tilbagekalde en henvisning

Henviseren annullerer en afsendt henvisning der endnu ikke er ekspederet. `ServiceRequest`-status sættes til `revoked` og en notifikation sendes til visitatoren.

> **Som henviser ønsker jeg at kunne tilbagekalde en afsendt henvisning, 
når patienten ikke længere ønsker forløbet eller det kliniske grundlag er bortfaldet, 
så visitatoren ikke bruger ressourcer på en henvisning der ikke skal ekspederes.**

| | |
| :--- | :--- |
| **Ressource** | `ServiceRequest`status=revoked |
| **Trigger** | Patienten ønsker ikke forløbet, eller klinisk grundlag er bortfaldet |
| **Næste trin** | ✓ Flowet afsluttes |

-------

### 1.5 Monitorere status på afsendte henvisninger

Henviseren følger løbende op på status for egne udestående henvisninger. Dette kan ske via FHIR-subscription (push) eller ved periodisk polling mod visitatorens FHIR-endpoint.

> **Som henviser ønsker jeg løbende at kunne se status på mine afsendte og udestående henvisninger, 
når jeg har behov for overblik over patienternes videre forløb, 
så jeg kan følge op og informere patienterne korrekt.**

| | |
| :--- | :--- |
| **Ressource** | `Subscription`·`SubscriptionStatus`·`ServiceRequest` |
| **Trigger** | Behov for overblik over egne afsendte henvisninger |
| **Næste trin** | →[1.6 Modtage afgørelse](#16-modtage-afgørelse-fra-visitatoren) |

-------

### 1.6 Modtage afgørelse fra visitatoren

Henviseren modtager visitatorens endelige afgørelse — accept, afvisning eller alternativt tilbud — og integrerer denne i eget journalsystem. Afgørelsen leveres som en `Task`-ressource eller notifikation med reference til den oprindelige `ServiceRequest`.

> **Som henviser ønsker jeg automatisk at modtage visitatorens afgørelse i mit journalsystem, 
når visitatoren har truffet beslutning om accept, afvisning eller alternativt tilbud, 
så jeg hurtigt kan handle og orientere patienten.**

| | |
| :--- | :--- |
| **Ressource** | `Task`·`SubscriptionNotification` |
| **Trigger** | Visitatoren har truffet afgørelse om henvisningen |
| **Næste trin** | →[1.1 Ny henvisning](#11-oprette-en-ny-henvisning)· Accept → afslut |

-------

## Sektion 2 — Visitatorens use cases

Udføres selvstændigt af visitatoren som led i modtagelse og behandling af indkomne henvisninger.

-------

### 2.1 Modtage og kvittere for ny henvisning

Visitatoren modtager en indkommende FHIR-`Bundle` med en ny `ServiceRequest` og sender en teknisk kvittering (ACK) tilbage til afsendersystemet. Henvisningen registreres med status `active` eller `on-hold` afhængigt af triagekapacitet.

> **Som visitator ønsker jeg automatisk at modtage og kvittere for indkomne henvisninger via FHIR, 
når en ny ServiceRequest ankommer i mit endpoint, 
så afsenderen hurtigt får bekræftet at henvisningen er modtaget korrekt.**

| | |
| :--- | :--- |
| **Ressource** | `Bundle`·`MessageHeader`·`ServiceRequest` |
| **Trigger** | Indkommende henvisning i FHIR-endpoint |
| **Næste trin** | →[2.2 Triagere](#22-triagere-og-prioritere-en-henvisning) |

-------

### 2.2 Triagere og prioritere en henvisning

Visitatoren vurderer henvisningens faglige indhold, klassificerer hastegrad og prioriterer i forhold til øvrige indkomne henvisninger. Triage-udfaldet dokumenteres i en `Task`-ressource med udfald og begrundelse.

> **Som visitator ønsker jeg at kunne foretage en struktureret triage af en modtaget henvisning og dokumentere mit udfald, 
når en ny eller opdateret henvisning er klar til klinisk vurdering, 
så prioriteringen er sporbar og ensartet på tværs af alle indkomne sager.**

| | |
| :--- | :--- |
| **Ressource** | `Task`(triage-outcome, priority) |
| **Trigger** | Ny eller opdateret henvisning klar til klinisk vurdering |
| **Næste trin** | →[2.3 Acceptere](#23-acceptere-en-henvisning-og-booke-forløb)·→[2.4 Afvise](#24-afvise-en-henvisning)·→[3.1 Supplement](#31-anmode-om-supplerende-oplysninger)·→[2.6 Prioritet](#26-ændre-prioritet-på-en-modtaget-henvisning) |

-------

### 2.3 Acceptere en henvisning og booke forløb

Visitatoren accepterer en henvist patient og opretter en aftale i planlægningssystemet. `ServiceRequest`-status opdateres til `active`, og en `Appointment`-ressource oprettes med tid, sted og behandler. Henviseren notificeres automatisk.

> **Som visitator ønsker jeg at kunne acceptere en godkendt henvisning og oprette en booking til patienten, 
når triage er afsluttet og kapacitet er til stede, 
så patienten hurtigt modtager en bekræftet aftale og henviseren holdes orienteret.**

| | |
| :--- | :--- |
| **Ressource** | `ServiceRequest`(active) ·`Appointment` |
| **Trigger** | Positiv triage-afgørelse og tilgængelig kapacitet |
| **Næste trin** | →[3.4 Statusnotifikation](#34-statusnotifikation-til-henviser)·→[1.6 Afgørelse](#16-modtage-afgørelse-fra-visitatoren) |

-------

### 2.4 Afvise en henvisning

Visitatoren afviser en modtaget henvisning og dokumenterer årsagen. `ServiceRequest`-status sættes til `revoked` og der oprettes en `Task` med afvisningskode og begrundelse. Henviseren notificeres.

> **Som visitator ønsker jeg at kunne afvise en henvisning med en klar begrundelse, 
når det vurderes at tilbuddet ikke er egnet for patienten, 
så henviseren kan agere hurtigt og patienten ikke ender i en blindgyde.**

| | |
| :--- | :--- |
| **Ressource** | `Task`(rejection) ·`ServiceRequest`(revoked) |
| **Trigger** | Negativ triage-afgørelse eller kapacitetsmangel |
| **Næste trin** | →[3.5 Alternativ visitation](#35-aftale-om-alternativ-visitation)·→[1.6 Afgørelse](#16-modtage-afgørelse-fra-visitatoren) |

-------

### 2.5 Videresende en henvisning

Visitatoren videresender en fejlplaceret eller omdirigeret henvisning til en mere egnet modtager. Den nye `ServiceRequest` oprettes med `replaces`-reference til den originale, og der sendes notifikation til den oprindelige henviser.

> **Som visitator ønsker jeg at kunne videresende en fejlplaceret henvisning til rette modtager, 
når jeg vurderer at et andet tilbud er bedre egnet, 
så patienten ikke unødigt forsinkes og henviseren holdes orienteret om omdirigeringen.**

| | |
| :--- | :--- |
| **Ressource** | `ServiceRequest`(replaces) ·`Task`·`Communication` |
| **Trigger** | Forkert modtager eller bedre egnet tilbud identificeret |
| **Næste trin** | →[2.1 Ny modtager](#21-modtage-og-kvittere-for-ny-henvisning)·→[3.4 Notifikation](#34-statusnotifikation-til-henviser) |

-------

### 2.6 Ændre prioritet på en modtaget henvisning

Visitatoren revurderer hastegraden for en allerede modtaget henvisning — fx på baggrund af ny klinisk information eller ændret kapacitetssituation. Prioriteten opdateres på `ServiceRequest` og der sendes notifikation til henviseren.

> **Som visitator ønsker jeg at kunne justere prioriteten på en allerede modtaget henvisning, 
når ny klinisk information eller ændret kapacitetssituation tilsiger det, 
så den kliniske hastegrad afspejles korrekt og henviseren notificeres om ændringen.**

| | |
| :--- | :--- |
| **Ressource** | `ServiceRequest`(priority update) ·`SubscriptionNotification` |
| **Trigger** | Ny information ændrer klinisk hastegrad |
| **Næste trin** | →[3.4 Statusnotifikation](#34-statusnotifikation-til-henviser) |

-------

## Sektion 3 — Udvekslingsdialog

Use cases der forudsætter aktiv kommunikation frem og tilbage mellem henviser og visitator via FHIR-beskeder.

-------

### 3.1 Anmode om supplerende oplysninger

Visitatoren mangler oplysninger for at kunne triagere og sender en struktureret anmodning til henviseren om at supplere med konkrete kliniske data — fx blodprøveresultater, BMI, medicinliste eller tidligere forløb.

> **Som visitator ønsker jeg at kunne sende en struktureret anmodning om supplerende oplysninger til henviseren, 
når grundlaget for triage er utilstrækkeligt, 
så jeg kan træffe en fagligt forsvarlig visitationsafgørelse uden at afvise unødigt.**

| | |
| :--- | :--- |
| **Ressource** | `CommunicationRequest`(visitator → henviser) |
| **Trigger** | Utilstrækkeligt grundlag for visitationsafgørelse |
| **Næste trin** | →[3.2 Besvare](#32-besvare-anmodning-om-supplement) |

-------

### 3.2 Besvare anmodning om supplement

Henviseren modtager en supplement-anmodning og besvarer denne ved at sende de efterspurgte oplysninger. Svaret sendes som en `Communication`-ressource med reference til den oprindelige `CommunicationRequest` og til `ServiceRequest`.

> **Som henviser ønsker jeg at kunne besvare en supplement-anmodning med de efterspurgte kliniske oplysninger, 
når visitatoren har bedt om yderligere data, 
så visitatoren hurtigt kan genoptage og afslutte triage-processen.**

| | |
| :--- | :--- |
| **Ressource** | `Communication`(reply, in-response-to) |
| **Trigger** | Modtagelse af CommunicationRequest fra visitatoren |
| **Næste trin** | →[2.2 Triagere](#22-triagere-og-prioritere-en-henvisning)·→[3.3 Faglig dialog](#33-faglig-afklaring-i-dialog) |

-------

### 3.3 Faglig afklaring i dialog

Henviser og visitator udveksler kliniske spørgsmål og svar for at afklare indikation, behandlingsegnethed eller alternativ tilgang. Dialogen føres som en kæde af `Communication`-ressourcer med indbyrdes referencer.

> **Som henviser og visitator ønsker vi begge at kunne føre en struktureret faglig dialog om en konkret henvisning, 
når indikation, egnethed eller behandlingsvalg er uklart, 
så vi i fællesskab kan nå frem til den rigtige afgørelse for patienten uden at skulle bruge andre kommunikationskanaler.**

| | |
| :--- | :--- |
| **Ressource** | `Communication`(thread, in-response-to-kæde) |
| **Trigger** | Faglig uklarhed der kræver mere end én udveksling |
| **Næste trin** | →[2.3 Acceptere](#23-acceptere-en-henvisning-og-booke-forløb)·→[2.4 Afvise](#24-afvise-en-henvisning) |

-------

### 3.4 Statusnotifikation til henviser

Visitatoren notificerer automatisk henviseren ved statusskift på en afsendt henvisning — fx modtaget, under vurdering, accepteret eller afvist. Notifikationen leveres via FHIR-subscription og indeholder reference til den opdaterede `ServiceRequest`.

> **Som henviser ønsker jeg automatisk at modtage en notifikation, 
når status på en af mine henvisninger ændrer sig hos visitatoren, 
så jeg til enhver tid er opdateret om forløbet uden at skulle forespørge aktivt.**

| | |
| :--- | :--- |
| **Ressource** | `SubscriptionNotification`·`ServiceRequest` |
| **Trigger** | Ethvert statusskift på en aktiv henvisning hos visitatoren |
| **Næste trin** | →[1.6 Modtage afgørelse](#16-modtage-afgørelse-fra-visitatoren) |

-------

### 3.5 Aftale om alternativ visitation

Henviser og visitator forhandler i fællesskab om et alternativt tilbud, 
når det primære visitationsspor ikke er muligt. Dialogen foregår via `Communication`, og den resulterende aftale dokumenteres i en `Task` med reference til det alternative tilbud.

> **Som visitator ønsker jeg at kunne indlede en dialog med henviseren om et alternativt tilbud, 
når jeg ikke kan imødekomme den primære henvisning, 
så patienten ikke ender i en blindgyde og vi i fællesskab finder en løsning.**

| | |
| :--- | :--- |
| **Ressource** | `Communication`·`Task`·`ServiceRequest`(alternativ) |
| **Trigger** | Afvisning kombineret med behov for at finde alternativ løsning for patienten |
| **Næste trin** | →[1.1 Ny henvisning](#11-oprette-en-ny-henvisning)·→[2.3 Acceptere](#23-acceptere-en-henvisning-og-booke-forløb) |

-------

### 3.6 Korrektionsaftale om fejl i afsendt henvisning

Visitatoren opdager en fejl i en modtaget henvisning — fx forkert CPR-nummer, forkert ydelseskode eller manglende samtykkedokumentation — og indleder en dialog med henviseren om korrektion. Korrektionen aftales via `Communication`-besked og gennemføres med en efterfølgende `PUT`-opdatering af `ServiceRequest`.

> **Som visitator ønsker jeg at kunne kontakte henviseren og aftale en korrektion, 
når jeg opdager en fejl i en modtaget henvisning, 
så fejlen rettes på en koordineret og sporbar måde uden at vi mister historikken.**

| | |
| :--- | :--- |
| **Ressource** | `Communication`·`ServiceRequest`(PUT/korrektion) |
| **Trigger** | Fejl opdaget under modtagelse eller triage hos visitatoren |
| **Næste trin** | →[1.3 Ændre](#13-ændre-en-afsendt-henvisning)·→[2.2 Triagere](#22-triagere-og-prioritere-en-henvisning) |

-------

## Ressourceoversigt

| | | | |
| :--- | :--- | :--- | :--- |
| `1.1` | Oprette henvisning | `ServiceRequest` | Henviser → Visitator |
| `1.2` | Tilknytte dokumentation | `DiagnosticReport`,`Media`,`DocumentReference` | Henviser → Visitator |
| `1.3` | Ændre henvisning | `ServiceRequest`(PUT) | Henviser → Visitator |
| `1.4` | Tilbagekalde henvisning | `ServiceRequest`(revoked) | Henviser → Visitator |
| `1.5` | Monitorere status | `Subscription`,`SubscriptionStatus` | Begge |
| `1.6` | Modtage afgørelse | `Task`,`SubscriptionNotification` | Visitator → Henviser |
| `2.1` | Modtage og kvittere | `Bundle`,`MessageHeader` | Visitator (intern) |
| `2.2` | Triagere og prioritere | `Task` | Visitator (intern) |
| `2.3` | Acceptere og booke | `ServiceRequest`,`Appointment` | Visitator → Henviser |
| `2.4` | Afvise henvisning | `Task`,`ServiceRequest` | Visitator → Henviser |
| `2.5` | Videresende | `ServiceRequest`(replaces) | Visitator → Ny modtager |
| `2.6` | Ændre prioritet | `ServiceRequest`,`SubscriptionNotification` | Visitator → Henviser |
| `3.1` | Anmode om supplement | `CommunicationRequest` | Visitator → Henviser |
| `3.2` | Besvare supplement | `Communication` | Henviser → Visitator |
| `3.3` | Faglig afklaring | `Communication`(thread) | Begge |
| `3.4` | Statusnotifikation | `SubscriptionNotification` | Visitator → Henviser |
| `3.5` | Alternativ visitation | `Communication`,`Task` | Begge |
| `3.6` | Korrektionsaftale | `Communication`,`ServiceRequest` | Begge |

