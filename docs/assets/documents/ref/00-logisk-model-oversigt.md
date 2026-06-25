# 00 Logisk Model Oversigt - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* **00 Logisk Model Oversigt**

## 00 Logisk Model Oversigt

# EHMI Henvisning – Logisk Model: Oversigt

Denne logiske model er udledt af de 18 user stories for FHIR-baseret henvisningshåndtering og danner det konceptuelle fundament for en implementering via EHMI og FHIR-meddelelseskommunikation.

Modellen er beskrevet i **FHIR Shorthand (FSH)** i filen `ehmi-henvisning-logisk-model.fsh` og uddybet i individuelle markdown-dokumenter for hver entitet.

-------

## Entiteter

| | | | | |
| :--- | :--- | :--- | :--- | :--- |
| 1 | [Henvisning](StructureDefinition-ehmi-lm-henvisning.md) | Klinisk anmodning om viderehenvisning | `ServiceRequest` | [1.1](fhir-henvisning-use-cases-v2-claude.md#user-story-11-oprette-en-ny-henvisning),[1.3](fhir-henvisning-use-cases-v2-claude.md#user-story-13-ændre-en-afsendt-henvisning),[1.4](fhir-henvisning-use-cases-v2-claude.md#user-story-14-tilbagekalde-en-henvisning),[2.3](fhir-henvisning-use-cases-v2-claude.md#user-story-23-acceptere-en-henvisning-og-booke-forløb),[2.4](fhir-henvisning-use-cases-v2-claude.md#user-story-24-afvise-en-henvisning),[2.5](fhir-henvisning-use-cases-v2-claude.md#user-story-25-videresende-til-anden-modtager),[2.6](fhir-henvisning-use-cases-v2-claude.md#user-story-26-ændre-prioritet-på-en-modtaget-henvisning),[3.6](fhir-henvisning-use-cases-v2-claude.md#user-story-36-korrektionsaftale-om-fejl-i-afsendt-henvisning) |
| 2 | [Patient](StructureDefinition-ehmi-lm-patient.md) | Den patient der viderehenvises | `Patient`(DkCorePatient) | [Alle](fhir-henvisning-use-cases-v2-claude.md) |
| 3 | [Behandler](StructureDefinition-ehmi-lm-behandler.md) | Henviser eller visitator | `Practitioner`+`PractitionerRole` | [Alle](fhir-henvisning-use-cases-v2-claude.md) |
| 4 | [Organisation](StructureDefinition-ehmi-lm-organisation.md) | Afsendende eller modtagende organisation | `Organization`(DkCoreOrganization) | [1.1](fhir-henvisning-use-cases-v2-claude.md#user-story-11-oprette-en-ny-henvisning),[2.1](fhir-henvisning-use-cases-v2-claude.md#user-story-21-modtage-og-kvittere-for-ny-henvisning),[2.5](fhir-henvisning-use-cases-v2-claude.md#user-story-25-videresende-til-anden-modtager) |
| 5 | [KliniskDokumentation](StructureDefinition-ehmi-lm-klinisk-dokumentation.md) | Supplerende klinisk materiale | `DocumentReference`,`DiagnosticReport`,`Observation` | [1.2](fhir-henvisning-use-cases-v2-claude.md#user-story-12-tilknytte-klinisk-dokumentation) |
| 6 | [Visitationsafgoerelse](StructureDefinition-ehmi-lm-visitationsafgoerelse.md) | Visitatorens formelle afgørelse | `Task` | [1.6](fhir-henvisning-use-cases-v2-claude.md#user-story-16-modtage-afgørelse-fra-visitatoren),[2.2](fhir-henvisning-use-cases-v2-claude.md#user-story-22-triagere-og-prioritere-en-henvisning),[2.3](fhir-henvisning-use-cases-v2-claude.md#user-story-23-acceptere-en-henvisning-og-booke-forløb),[2.4](fhir-henvisning-use-cases-v2-claude.md#user-story-24-afvise-en-henvisning),[2.5](fhir-henvisning-use-cases-v2-claude.md#user-story-25-videresende-til-anden-modtager),[2.6](fhir-henvisning-use-cases-v2-claude.md#user-story-26-ændre-prioritet-på-en-modtaget-henvisning) |
| 7 | [Booking](StructureDefinition-ehmi-lm-booking.md) | Aftalt tid ved accept af henvisning | `Appointment` | [2.3](fhir-henvisning-use-cases-v2-claude.md#user-story-23-acceptere-en-henvisning-og-booke-forløb) |
| 8 | [Kommunikationsbesked](StructureDefinition-ehmi-lm-kommunikationsbesked.md) | Struktureret besked i dialogen | `Communication`,`CommunicationRequest` | [3.1](fhir-henvisning-use-cases-v2-claude.md#user-story-31-anmode-om-supplerende-oplysninger),[3.2](fhir-henvisning-use-cases-v2-claude.md#user-story-32-besvare-anmodning-om-supplement),[3.3](fhir-henvisning-use-cases-v2-claude.md#user-story-33-faglig-afklaring-i-dialog),[3.5](fhir-henvisning-use-cases-v2-claude.md#user-story-35-aftale-om-alternativ-visitation),[3.6](fhir-henvisning-use-cases-v2-claude.md#user-story-36-korrektionsaftale-om-fejl-i-afsendt-henvisning) |
| 9 | [Statusnotifikation](StructureDefinition-ehmi-lm-statusnotifikation.md) | Automatisk notifikation ved statusændring | `SubscriptionNotification` | [1.5](fhir-henvisning-use-cases-v2-claude.md#user-story-15-monitorere-status-på-afsendte-henvisninger),[1.6](fhir-henvisning-use-cases-v2-claude.md#user-story-16-modtage-afgørelse-fra-visitatoren),[2.6](fhir-henvisning-use-cases-v2-claude.md#user-story-26-ændre-prioritet-på-en-modtaget-henvisning),[3.4](fhir-henvisning-use-cases-v2-claude2.md#user-story-34-statusnotifikation-til-henviser) |
| 10 | [Abonnement](StructureDefinition-ehmi-lm-abonnement.md) | Registrering af notifikationsønsker | `Subscription` | [1.5](fhir-henvisning-use-cases-v2-claude.md#user-story-15-monitorere-status-på-afsendte-henvisninger),[3.4](fhir-henvisning-use-cases-v2-claude2.md#user-story-34-statusnotifikation-til-henviser) |
| 11 | [Meddelelseskonvolut](StructureDefinition-ehmi-lm-meddelelseskonvolut.md) | Teknisk FHIR-beskedomslagning via EHMI | `Bundle`(message) +`MessageHeader` | [1.1](fhir-henvisning-use-cases-v2-claude.md#user-story-11-oprette-en-ny-henvisning),[2.1](fhir-henvisning-use-cases-v2-claude.md#user-story-21-modtage-og-kvittere-for-ny-henvisning) |

-------

## Relationsdiagram

```
Meddelelseskonvolut
 └── fokus ──────────────────────► Henvisning
                                      ├── patient ──────► Patient
                                      ├── henviser ─────► Behandler
                                      │                      └── organisation ► Organisation
                                      ├── modtagerOrganisation ► Organisation
                                      ├── dokumentation ──► KliniskDokumentation
                                      └── booking ────────► Booking

Visitationsafgoerelse
 └── vedroererHenvisning ────────► Henvisning
 └── truffetAf ──────────────────► Behandler

Kommunikationsbesked
 └── vedroererHenvisning ────────► Henvisning
 └── svarPaa ────────────────────► Kommunikationsbesked (tråd)
 └── afsender / modtager ────────► Behandler

Statusnotifikation
 └── vedroererHenvisning ────────► Henvisning
 └── abonnement ─────────────────► Abonnement
                                      └── abonnent ──────► Organisation

```

-------

## Livscyklus for en Henvisning

```
[proposed]
    │  1.1 Opret
    ▼
[active] ◄────────────────── 1.3 Ret / 3.6 Korriger
    │
    ├──[on-hold] ◄─────────── 3.1 Supplement afventes
    │      │
    │      └──[active] ◄───── 3.2 Supplement modtaget
    │
    ├──[revoked] ◄──────────── 1.4 Tilbagekald / 2.4 Afvis
    │
    └──[completed] ◄────────── 2.3 Accepter + Book

```

-------

## FHIR-ressource oversigt

| | | |
| :--- | :--- | :--- |
| `ServiceRequest` | Henvisning | Kernedokumentet i hele flowet |
| `Patient` | Patient | Subjekt for henvisningen |
| `Practitioner` | Behandler | Person-identitet |
| `PractitionerRole` | Behandler | Rolle + organisation-tilknytning |
| `Organization` | Organisation | Afsender / modtager |
| `DocumentReference` | KliniskDokumentation | Generiske dokumenter og epikriser |
| `DiagnosticReport` | KliniskDokumentation | Laboratoriesvar og billeddiagnostik |
| `Observation` | KliniskDokumentation | Enkeltmålinger og fund |
| `Task` | Visitationsafgoerelse | Triage-udfald og afgørelser |
| `Appointment` | Booking | Aftalt tid ved accept |
| `Communication` | Kommunikationsbesked | Svar og dialogtråde |
| `CommunicationRequest` | Kommunikationsbesked | Supplement-anmodning |
| `Subscription` | Abonnement | Notifikationsregistrering |
| `SubscriptionStatus` | Statusnotifikation | Notifikationsindhold |
| `Bundle`(message) | Meddelelseskonvolut | Transportomslag |
| `MessageHeader` | Meddelelseskonvolut | Routing og hændelsestype |

