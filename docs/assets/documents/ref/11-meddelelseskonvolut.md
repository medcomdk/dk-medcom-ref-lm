# 11 Meddelelseskonvolut - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* **11 Meddelelseskonvolut**

## 11 Meddelelseskonvolut

# Entitet: Meddelelseskonvolut

**FSH LogicalModel:** `EhmiLmMeddelelseskonvolut` **Primær FHIR-ressource:** `Bundle` (type=message) + `MessageHeader` **User stories:** 1.1, 2.1

-------

## Beskrivelse

`Meddelelseskonvolut` repræsenterer den tekniske ompakning der transporterer kliniske FHIR-ressourcer (Henvisning, Visitationsafgørelse mv.) fra afsender til modtager via EHMI og eDelivery (AS4-protokollen).

Bundle-strukturen garanterer atomicitet: alle ressourcer i en meddelelse sendes og behandles samlet. `MessageHeader` er altid første entry og indeholder routing-information (afsender, modtager, EHMI-endpoint) og hændelsestype.

-------

## Attributter

| | | | |
| :--- | :--- | :--- | :--- |
| `meddelelsesId` | 1..1 | id | Unik UUID for denne meddelelse |
| `haendelsestype` | 1..1 | Coding | `ny-henvisning`·`annuller`·`opdater`·`kvittering` |
| `afsendelsestidspunkt` | 1..1 | dateTime | Tidspunkt for afsendelse |
| `afsender` | 1..1 | Reference(Organisation) | Afsendende organisation |
| `modtager` | 1..* | Reference(Organisation) | Modtagende organisation(er) |
| `fokus` | 1..* | Reference | Primær klinisk ressource (Henvisning, Afgørelse mv.) |
| `kildesystem` | 1..1 | string | Afsendende systems tekniske endpoint |

-------

## FHIR-mapping

| | | |
| :--- | :--- | :--- |
| `meddelelsesId` | `Bundle.id`/`MessageHeader.id` | UUID v4 |
| `haendelsestype` | `MessageHeader.eventCoding` | Fra`EHMIMessageEventCS` |
| `afsendelsestidspunkt` | `Bundle.timestamp` |   |
| `afsender` | `MessageHeader.sender` | Reference til DkCoreOrganization |
| `modtager` | `MessageHeader.destination.receiver` | Reference til DkCoreOrganization |
| `fokus` | `MessageHeader.focus` | Reference til ServiceRequest el. Task |
| `kildesystem` | `MessageHeader.source.endpoint` | Teknisk endpoint URL |

-------

## Bundle-struktur

```
Bundle (type: message)
 ├── [0] MessageHeader        ← Altid første entry
 ├── [1] ServiceRequest       ← Primær klinisk payload (Henvisning)
 ├── [2] Patient              ← Den patient der henvises
 ├── [3] Practitioner         ← Henvisende behandler
 ├── [4] PractitionerRole     ← Rolle og organisation
 ├── [5] Organization (afs.)  ← Afsendende organisation
 ├── [6] Organization (mod.)  ← Modtagende organisation
 └── [n] DiagnosticReport/    ← Evt. supplerende dokumentation
         DocumentReference

```

-------

## Relaterede entiteter

* **[Organisation](StructureDefinition-ehmi-lm-organisation.md)** — afsender og modtager
* **[Henvisning](StructureDefinition-ehmi-lm-henvisning.md)** — den primære kliniske payload
* **[Visitationsafgoerelse](StructureDefinition-ehmi-lm-visitationsafgoerelse.md)** — kan transporteres som fokus

