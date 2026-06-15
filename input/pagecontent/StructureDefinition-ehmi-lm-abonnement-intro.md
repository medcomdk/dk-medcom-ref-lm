# Entitet: Abonnement

**FSH LogicalModel:** `EhmiLmAbonnement`
**Primær FHIR-ressource:** `Subscription`
**User stories:** 1.5, 3.4

---

## Beskrivelse

`Abonnement` repræsenterer en registrering der definerer hvilke
hændelser (statusskift på Henvisninger) en abonnent ønsker at modtage
notifikationer om. Typisk opretter henviserens system et abonnement
umiddelbart efter afsendelse af en Henvisning, og annullerer det ved
modtagelse af den endelige afgørelse.

---

## Attributter

| Attribut | Kardinalitet | Type | Beskrivelse |
|---|---|---|---|
| `abonnementId` | 1..1 | Identifier | Unik identifikator for abonnementet |
| `status` | 1..1 | code | `requested` · `active` · `error` · `off` |
| `kriterie` | 1..1 | string | FHIR-søgekriterium (fx `ServiceRequest?requester=Organization/123`) |
| `kanal` | 1..1 | code | `rest-hook` · `message` · `email` |
| `endpoint` | 1..1 | url | URL/endpoint der modtager notifikationer (EHMI) |
| `abonnent` | 1..1 | Reference(Organisation) | Den organisation der abonnerer |
| `oprettetDato` | 1..1 | dateTime | Tidspunkt for oprettelse |
| `udloeber` | 0..1 | dateTime | Udløbstidspunkt (hvis midlertidigt) |

---

## FHIR-mapping

| Logisk attribut | FHIR-element | Kommentar |
|---|---|---|
| `abonnementId` | `Subscription.id` | |
| `status` | `Subscription.status` | |
| `kriterie` | `Subscription.criteria` | FHIR-søge-URL som string |
| `kanal` | `Subscription.channel.type` | `rest-hook` foretrækkes via EHMI |
| `endpoint` | `Subscription.channel.endpoint` | EHMI AP-adresse |
| `abonnent` | `Subscription.contact` | Reference til Organization |
| `oprettetDato` | `Subscription.meta.lastUpdated` | |
| `udloeber` | `Subscription.end` | |

---

## Relaterede entiteter

- **[Organisation](04-organisation.html)** — abonnenten
- **[Statusnotifikation](09-statusnotifikation.html)** — notifikationer udløst af dette abonnement
- **[Henvisning](01-henvisning.html)** — den ressource der abonneres på


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
| **Forrige trin:** | ← [2.3 Acceptere og booke](#user-story-23-acceptere-en-henvisning-og-booke-forløb) *(accept udløser notifikation)* · <br/>← [2.4 Afvise en henvisning](#user-story-24-afvise-en-henvisning) *(afvisning udløser notifikation)* · <br/>← [2.6 Ændre prioritet](#26-ændre-prioritet-på-en-modtaget-henvisning) *(prioritetsændring udløser notifikation)* |
| **Næste trin:** | → [1.6 Modtage afgørelse fra visitatoren](#user-story-16-modtage-afgørelse-fra-visitatoren) *(notifikationen udløser håndtering af afgørelsen hos henviseren)* |
{: .grid}
