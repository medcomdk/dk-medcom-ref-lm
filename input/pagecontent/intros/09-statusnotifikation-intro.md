# Entitet: Statusnotifikation

**FSH LogicalModel:** `EhmiLmStatusnotifikation`
**Primær FHIR-ressource:** `SubscriptionNotification` / `SubscriptionStatus`
**User stories:** 1.5, 1.6, 2.6, 3.4

---

## Beskrivelse

`Statusnotifikation` repræsenterer en automatisk push-notifikation der
sendes til en abonnent (typisk henviseren) ved et statusskift på en aktiv
Henvisning. Notifikationen indeholder en reference til den opdaterede
ressource og udløser håndtering hos modtageren.

I FHIR R4 implementeres dette via `Subscription`-ressourcen kombineret
med en notifikations-`Bundle` der transporteres via EHMI. I R4B/R5 er
dette formaliseret som `SubscriptionStatus`.

---

## Attributter

| Attribut | Kardinalitet | Type | Beskrivelse |
|---|---|---|---|
| `notifikationsId` | 1..1 | Identifier | Unik identifikator for notifikationen |
| `type` | 1..1 | code | `handshake` · `heartbeat` · `event-notification` · `query-status` |
| `udloestAfStatus` | 1..1 | code | Den nye status der udløste notifikationen |
| `tidspunkt` | 1..1 | dateTime | Tidspunkt for notifikationen |
| `abonnement` | 1..1 | Reference(Abonnement) | Det abonnement der udløste notifikationen |
| `vedroererHenvisning` | 1..1 | Reference(Henvisning) | Den ændrede Henvisning |
| `modtager` | 1..1 | Reference(Organisation) | Modtagende organisation (abonnenten) |

---

## FHIR-mapping

| Logisk attribut | FHIR-element | Kommentar |
|---|---|---|
| `notifikationsId` | `Bundle.identifier` | Notification-bundle |
| `type` | `SubscriptionStatus.type` | |
| `udloestAfStatus` | `SubscriptionStatus.notificationEvent.focus` | Via ServiceRequest.status |
| `tidspunkt` | `SubscriptionStatus.notificationEvent.timestamp` | |
| `abonnement` | `SubscriptionStatus.subscription` | |
| `vedroererHenvisning` | `SubscriptionStatus.notificationEvent.focus` | Reference til ServiceRequest |
| `modtager` | `Subscription.channel.endpoint` | Abonnentens EHMI-endpoint |

---

## Relaterede entiteter

- **[Abonnement](10-abonnement.html)** — det abonnement der udløser notifikationen
- **[Henvisning](01-henvisning.html)** — den ressource der ændres
- **[Organisation](04-organisation.html)** — modtageren af notifikationen


---

## User stories


### Henviserens user stories


### User story 1.5 Monitorere status på afsendte henvisninger

> **User story:** Som henviser ønsker jeg løbende at kunne se status på mine afsendte og udestående henvisninger, <br/>når jeg har behov for overblik over patienternes videre forløb, <br/>så jeg kan følge op og informere patienterne korrekt.

<p style="display: block;">
<img src="UC-1-5-Monitorere-status.svg" alt="UC-1-5" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
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
<img src="UC-1-6-Modtage-afgoerelse.svg" alt="UC-1-6" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Henviseren modtager visitatorens endelige afgørelse — accept, afvisning eller alternativt tilbud — og integrerer denne i eget journalsystem. Afgørelsen leveres som en `Task`-ressource eller notifikation med reference til den oprindelige `ServiceRequest`.

|---|---|
| **Primær FHIR-ressource:** | `Task`, `SubscriptionNotification` |
| **Triggerhændelse:** | Visitatoren har truffet afgørelse om henvisningen |
| **Forrige trin:** | ← [1.5 Monitorere status](#user-story-12-monitorere-status-på-afsendte-henvisninger) *(statusoverblikket leder hertil)* · <br/>← [3.4 Statusnotifikation](#34-statusnotifikation-til-henviser) *(notifikation udløser håndtering)* |
| **Næste trin:** | → [1.1 Oprette en ny henvisning](#user-story-11-oprette-en-ny-henvisning) *(hvis afgørelsen er en afvisning og patienten skal viderehenvisies)* · *(Flowet afsluttes ved accept)* |
{: .grid}

## Visitatorens user stories

Disse user stories udføres selvstændigt af visitatoren som led i modtagelse og behandling af indkomne henvisninger.


### Visitatorens user stories


### User story 2.6 Ændre prioritet på en modtaget henvisning

> **User story:** Som visitator ønsker jeg at kunne justere prioriteten på en allerede modtaget henvisning, <br/>når ny klinisk information eller ændret kapacitetssituation tilsiger det, <br/>så den kliniske hastegrad afspejles korrekt og henviseren notificeres om ændringen.

<p style="display: block;">
<img src="UC-2-6-Aendre-prioritet.svg" alt="UC-2-6" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Visitatoren revurderer hastegraden for en allerede modtaget henvisning — fx på baggrund af ny klinisk information eller ændret kapacitetssituation. Prioriteten opdateres på `ServiceRequest` og der sendes notifikation til henviseren.

|---|---|
| **Primær FHIR-ressource:** | `ServiceRequest` (priority update), `SubscriptionNotification` |
| **Triggerhændelse:** | Ny information ændrer klinisk hastegrad |
| **Forrige trin:** | ← [2.2 Triagere og prioritere](#user-story-22-triagere-og-prioritere-en-henvisninger) *(prioritetsjustering under triage)* |
| **Næste trin:** | → [3.4 Statusnotifikation til henviser](#34-statusnotifikation-til-henviser) *(henviser notificeres om den ændrede prioritet)* |
{: .grid}

## Udvekslingsdialog (fælles user stories)

Disse user stories forudsætter aktiv kommunikation frem og tilbage mellem henviser og visitator via FHIR-beskeder.


### Udvekslingsdialog


### User story 3.4 Statusnotifikation til henviser

> **User story:** Som henviser ønsker jeg automatisk at modtage en notifikation, <br/>når status på en af mine henvisninger ændrer sig hos visitatoren, <br/>så jeg til enhver tid er opdateret om forløbet uden at skulle forespørge aktivt.

<p style="display: block;">
<img src="UC-3-4-Statusnotifikation.svg" alt="UC-3-4" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Visitatoren notificerer automatisk henviseren ved statusskift på en afsendt henvisning — fx modtaget, under vurdering, accepteret eller afvist. Notifikationen leveres via FHIR-subscription og indeholder reference til den opdaterede `ServiceRequest`.

|---|---|
| **Primær FHIR-ressource:** | `SubscriptionNotification`, `ServiceRequest` |
| **Triggerhændelse:** | Ethvert statusskift på en aktiv henvisning hos visitatoren |
| **Forrige trin:** | ← [2.3 Acceptere og booke](#user-story-23-acceptere-en-henvisning-og-booke-forløb) *(accept udløser notifikation)* · <br/>← [2.4 Afvise en henvisning](#user-story-24-afvise-en-henvisning) *(afvisning udløser notifikation)* · <br/>← [2.6 Ændre prioritet](#user-story-26-ændre-prioritet-på-en-modtaget-henvisning) *(prioritetsændring udløser notifikation)* |
| **Næste trin:** | → [1.6 Modtage afgørelse fra visitatoren](#user-story-16-modtage-afgørelse-fra-visitatoren) *(notifikationen udløser håndtering af afgørelsen hos henviseren)* |
{: .grid}
