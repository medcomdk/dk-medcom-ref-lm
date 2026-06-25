# 06 Visitationsafgoerelse - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* **06 Visitationsafgoerelse**

## 06 Visitationsafgoerelse

# Entitet: Visitationsafgoerelse

**FSH LogicalModel:** `EhmiLmVisitationsafgoerelse` **Primær FHIR-ressource:** `Task` **User stories:** 1.6, 2.2, 2.3, 2.4, 2.5, 2.6

-------

## Beskrivelse

`Visitationsafgoerelse` repræsenterer visitatorens formelle beslutning om en indkommende henvisning. Den dokumenterer udfaldet af triage-processen — accept, afvisning, videresendelse eller prioritetsændring — og udgør den primære mekanisme for at kommunikere afgørelsen tilbage til henviseren.

FHIR `Task` er valgt fordi den understøtter workflow-orienterede opgaver med status, prioritet, udfald og begrundelse.

-------

## Attributter

| | | | |
| :--- | :--- | :--- | :--- |
| `afgoerelseId` | 1..1 | Identifier | Unik identifikator for afgørelsen |
| `type` | 1..1 | code | `accept`·`afvisning`·`videresendelse`·`prioritetsaendring` |
| `status` | 1..1 | code | `requested`·`received`·`accepted`·`rejected`·`completed` |
| `prioritet` | 0..1 | code | `routine`·`urgent`·`asap`·`stat` |
| `begrundelse` | 0..1 | string | Faglig begrundelse for afgørelsen (fri tekst) |
| `aarsagskode` | 0..1 | CodeableConcept | Struktureret årsag (kapacitet, indikation, forkert spor) |
| `truffetDato` | 1..1 | dateTime | Tidspunkt for afgørelsen |
| `truffetAf` | 1..1 | Reference(Behandler) | Visitatoren der har truffet afgørelsen |
| `vedroererHenvisning` | 1..1 | Reference(Henvisning) | Den henvisning afgørelsen vedrører |
| `alternativtTilbud` | 0..1 | Reference(Henvisning) | Alternativt tilbud (ved videresendelse/3.5) |

-------

## FHIR-mapping

| | | |
| :--- | :--- | :--- |
| `afgoerelseId` | `Task.identifier` |   |
| `type` | `Task.code` | Lokalt eller nationalt kodeset |
| `status` | `Task.status` | Bundet til`task-status`(required) |
| `prioritet` | `Task.priority` |   |
| `begrundelse` | `Task.note.text` |   |
| `aarsagskode` | `Task.statusReason` |   |
| `truffetDato` | `Task.executionPeriod.end` |   |
| `truffetAf` | `Task.owner` | Reference til Practitioner/PractitionerRole |
| `vedroererHenvisning` | `Task.focus` | Reference til ServiceRequest |
| `alternativtTilbud` | `Task.output` | Reference til ny/alternativ ServiceRequest |

-------

## Relaterede entiteter

* **[Henvisning](StructureDefinition-ehmi-lm-henvisning.md)** — den afgørelse vedrører
* **[Behandler](StructureDefinition-ehmi-lm-behandler.md)** — visitatoren der afgør
* **[Statusnotifikation](StructureDefinition-ehmi-lm-statusnotifikation.md)** — afgørelsen udløser notifikation
* **[Booking](StructureDefinition-ehmi-lm-booking.md)** — oprettes ved accept

