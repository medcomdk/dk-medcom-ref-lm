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

- **[Organisation](StructureDefinition-ehmi-lm-organisation.html)** — abonnenten
- **[Statusnotifikation](StructureDefinition-ehmi-lm-statusnotifikation.html)** — notifikationer udløst af dette abonnement
- **[Henvisning](StructureDefinition-ehmi-lm-henvisning.html)** — den ressource der abonneres på
