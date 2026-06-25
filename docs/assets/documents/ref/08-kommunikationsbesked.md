# 08 Kommunikationsbesked - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* **08 Kommunikationsbesked**

## 08 Kommunikationsbesked

# Entitet: Kommunikationsbesked

**FSH LogicalModel:** `EhmiLmKommunikationsbesked` **Primær FHIR-ressource:** `Communication`, `CommunicationRequest` **User stories:** 3.1, 3.2, 3.3, 3.5, 3.6

-------

## Beskrivelse

`Kommunikationsbesked` repræsenterer enhver struktureret besked der udveksles direkte mellem henviser og visitator som led i dialogen om en konkret henvisning. Det dækker fem scenarier:

| | | |
| :--- | :--- | :--- |
| Anmodning om supplement (3.1) | `anmodning` | `CommunicationRequest` |
| Svar på supplement (3.2) | `svar` | `Communication` |
| Faglig afklaringsdialog (3.3) | `afklaring` | `Communication`(tråd) |
| Aftale om alternativ visitation (3.5) | `afklaring` | `Communication` |
| Korrektionsaftale (3.6) | `korrektionsaftale` | `Communication` |

Dialogtråde (3.3) modelleres som kæder af `Communication`-ressourcer bundet sammen via `inResponseTo`-feltet.

-------

## Attributter

| | | | |
| :--- | :--- | :--- | :--- |
| `beskedId` | 1..1 | Identifier | Unik identifikator for beskeden |
| `type` | 1..1 | code | `anmodning`·`svar`·`afklaring`·`notifikation`·`korrektionsaftale` |
| `status` | 1..1 | code | `preparation`·`in-progress`·`completed`·`entered-in-error` |
| `emne` | 0..1 | string | Kort emne eller titel |
| `indhold` | 1..1 | string | Beskedens tekstindhold |
| `sendt` | 1..1 | dateTime | Afsendelsestidspunkt |
| `afsender` | 1..1 | Reference(Behandler) | Den der har afsendt beskeden |
| `modtager` | 1..* | Reference(Behandler) | Den eller de der modtager beskeden |
| `svarPaa` | 0..1 | Reference(Kommunikationsbesked) | Reference til den besked der besvares |
| `vedroererHenvisning` | 1..1 | Reference(Henvisning) | Den henvisning kommunikationen vedrører |
| `bilag` | 0..* | Reference(KliniskDokumentation) | Eventuelle vedlagte dokumenter |

-------

## FHIR-mapping

| | | |
| :--- | :--- | :--- |
| `beskedId` | `Communication.identifier` |   |
| `type` | `Communication.category` | Lokalt kodeset for beskedtype |
| `status` | `Communication.status` |   |
| `emne` | `Communication.topic` |   |
| `indhold` | `Communication.payload.contentString` |   |
| `sendt` | `Communication.sent` |   |
| `afsender` | `Communication.sender` |   |
| `modtager` | `Communication.recipient` |   |
| `svarPaa` | `Communication.inResponseTo` | Knytter tråden (3.3) |
| `vedroererHenvisning` | `Communication.basedOn` | Reference til ServiceRequest |
| `bilag` | `Communication.payload` | `contentReference`til DocumentReference |

For supplement-**anmodninger** (3.1) anvendes `CommunicationRequest` hvor `CommunicationRequest.basedOn` refererer til `ServiceRequest`.

-------

## Relaterede entiteter

* **[Henvisning](StructureDefinition-ehmi-lm-henvisning.md)** — alle beskeder vedrører en konkret henvisning
* **[Behandler](StructureDefinition-ehmi-lm-behandler.md)** — afsender og modtager
* **[KliniskDokumentation](StructureDefinition-ehmi-lm-klinisk-dokumentation.md)** — vedlagte bilag

