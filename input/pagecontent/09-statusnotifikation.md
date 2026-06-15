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

- **[Abonnement](StructureDefinition-ehmi-lm-abonnement.html)** — det abonnement der udløser notifikationen
- **[Henvisning](StructureDefinition-ehmi-lm-henvisning.html)** — den ressource der ændres
- **[Organisation](StructureDefinition-ehmi-lm-organisation.html)** — modtageren af notifikationen
