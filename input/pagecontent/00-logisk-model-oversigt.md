# EHMI Henvisning – Logisk Model: Oversigt

Denne logiske model er udledt af de 18 user stories for FHIR-baseret
henvisningshåndtering og danner det konceptuelle fundament for en
implementering via EHMI og FHIR-meddelelseskommunikation.

Modellen er beskrevet i **FHIR Shorthand (FSH)** i filen
`ehmi-henvisning-logisk-model.fsh` og uddybet i individuelle
markdown-dokumenter for hver entitet.

---

## Entiteter

| # | Entitet | Beskrivelse | Primær FHIR-ressource | User stories |
|---|---|---|---|---|
| 1 | [Henvisning](StructureDefinition-ehmi-lm-henvisning.html) | Klinisk anmodning om viderehenvisning | `ServiceRequest` | 1.1, 1.3, 1.4, 2.3, 2.4, 2.5, 2.6, 3.6 |
| 2 | [Patient](StructureDefinition-ehmi-lm-patient.html) | Den patient der viderehenvises | `Patient` (DkCorePatient) | Alle |
| 3 | [Behandler](StructureDefinition-ehmi-lm-behandler.html) | Henviser eller visitator | `Practitioner` + `PractitionerRole` | Alle |
| 4 | [Organisation](StructureDefinition-ehmi-lm-organisation.html) | Afsendende eller modtagende organisation | `Organization` (DkCoreOrganization) | 1.1, 2.1, 2.5 |
| 5 | [KliniskDokumentation](StructureDefinition-ehmi-lm-klinisk-dokumentation.html) | Supplerende klinisk materiale | `DocumentReference`, `DiagnosticReport`, `Observation` | 1.2 |
| 6 | [Visitationsafgoerelse](StructureDefinition-ehmi-lm-visitationsafgoerelse.html) | Visitatorens formelle afgørelse | `Task` | 1.6, 2.2, 2.3, 2.4, 2.5, 2.6 |
| 7 | [Booking](StructureDefinition-ehmi-lm-booking.html) | Aftalt tid ved accept af henvisning | `Appointment` | 2.3 |
| 8 | [Kommunikationsbesked](StructureDefinition-ehmi-lm-kommunikationsbesked.html) | Struktureret besked i dialogen | `Communication`, `CommunicationRequest` | 3.1, 3.2, 3.3, 3.5, 3.6 |
| 9 | [Statusnotifikation](StructureDefinition-ehmi-lm-statusnotifikation.html) | Automatisk notifikation ved statusændring | `SubscriptionNotification` | 1.5, 1.6, 2.6, 3.4 |
| 10 | [Abonnement](StructureDefinition-ehmi-lm-abonnement.html) | Registrering af notifikationsønsker | `Subscription` | 1.5, 3.4 |
| 11 | [Meddelelseskonvolut](StructureDefinition-ehmi-lm-meddelelseskonvolut.html) | Teknisk FHIR-beskedomslagning via EHMI | `Bundle` (message) + `MessageHeader` | 1.1, 2.1 |

---

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

---

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

---

## FHIR-ressource oversigt

| FHIR-ressource | Logisk entitet | Rolle i flowet |
|---|---|---|
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
| `Bundle` (message) | Meddelelseskonvolut | Transportomslag |
| `MessageHeader` | Meddelelseskonvolut | Routing og hændelsestype |
