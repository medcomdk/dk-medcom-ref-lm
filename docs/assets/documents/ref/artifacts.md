# Artifacts Summary - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* **Artifacts Summary**

## Artifacts Summary

This page provides a list of the FHIR artifacts defined as part of this implementation guide.

### Structures: Logical Models 

These define data models that represent the domain covered by this implementation guide in more business-friendly terms than the underlying FHIR resources.

| | |
| :--- | :--- |
| [Abonnement](StructureDefinition-ehmi-lm-abonnement.md) | Repræsenterer en abonnementsregistrering der definerer hvilke hændelser en abonnent (typisk henviseren) ønsker at modtage notifikationer om. Svarer til FHIR Subscription. |
| [Behandler](StructureDefinition-ehmi-lm-behandler.md) | Repræsenterer en sundhedsprofessionel i rollen som enten henviser eller visitator. Svarer til FHIR Practitioner kombineret med PractitionerRole for at udtrykke rolle og tilknyttet organisation. |
| [Booking](StructureDefinition-ehmi-lm-booking.md) | Repræsenterer en aftalt tid der oprettes ved accept af en henvisning. Knyttes til den accept-givne Henvisning og notificerer automatisk patienten og henviseren. Svarer til FHIR Appointment. |
| [DK Logical Referral Message](StructureDefinition-dk-referral-message.md) | Logisk FHIR-model for dansk henvisningsmeddelelse |
| [EHMI/eDelivery Endpoint – Logisk Model](StructureDefinition-ehmiendpoint.md) | Konceptuel logisk model for et EHMI/eDelivery endpoint i dansk sundhedsvæsen. |
| [Henviser – Logisk Model](StructureDefinition-henviser.md) | Konceptuel logisk model for en Henviser i dansk sundhedsvæsen. |
| [Henvisning](StructureDefinition-ehmi-lm-henvisning.md) | Repræsenterer en klinisk anmodning om at viderehenvise en patient til et specialtilbud eller en ydelse. Svarer til FHIR ServiceRequest. Dækker hele livscyklussen fra oprettelse til afslutning. |
| [Henvisning – Logisk Model](StructureDefinition-henvisning.md) | Konceptuel logisk model for en Henvisning i dansk sundhedsvæsen. |
| [Henvisningsmeddelelse Response – Logisk Model](StructureDefinition-henvisningsmeddelelserespons.md) | Konceptuel logisk model for en henvisningsmeddelelse med response i dansk sundhedsvæsen. Der er brug for udddybning af henvisningen før den kan endeligt triageres |
| [Henvisningsmeddelelse – Logisk Model](StructureDefinition-henvisningsmeddelelse.md) | Konceptuel logisk model for en henvisningsmeddelelse i dansk sundhedsvæsen. |
| [KliniskDokumentation](StructureDefinition-ehmi-lm-klinisk-dokumentation.md) | Repræsenterer supplerende klinisk materiale der knyttes til en Henvisning for at understøtte visitators beslutningsgrundlag. Kan være laboratoriesvar, billeddiagnostik, epikriser eller andre dokumenter. Svarer til FHIR DocumentReference, DiagnosticReport eller Observation. |
| [Kommunikationsbesked](StructureDefinition-ehmi-lm-kommunikationsbesked.md) | Repræsenterer en struktureret besked i den løbende dialog mellem henviser og visitator. Bruges til supplement-anmodninger, faglig afklaring, alternativ visitation og korrektionsaftaler. Svarer til FHIR Communication eller CommunicationRequest. |
| [Kommunikator – Logisk Model](StructureDefinition-kommunikator.md) | Konceptuel logisk model for en Kommunikator i dansk sundhedsvæsen. |
| [Meddelelse – Logisk Model](StructureDefinition-meddelelse.md) | Konceptuel logisk model for en Meddelelse i dansk sundhedsvæsen. |
| [Meddelelseskonvolut](StructureDefinition-ehmi-lm-meddelelseskonvolut.md) | Repræsenterer den tekniske meddelelsesomslag der transporterer kliniske ressourcer (Henvisning, Afgørelse mv.) via EHMI og eDelivery. Svarer til FHIR Bundle (type=message) med MessageHeader som første entry. |
| [Organisation](StructureDefinition-ehmi-lm-organisation.md) | Repræsenterer en sundhedsorganisation der enten afsender eller modtager henvisninger. Svarer til FHIR Organization profileret som DkCoreOrganization med SOR-kode og GLN som primære identifikatorer. |
| [Patient](StructureDefinition-ehmi-lm-patient.md) | Repræsenterer den patient der viderehenvises. Svarer til FHIR Patient profileret som DkCorePatient med dansk CPR-nummer som primær identifikator. |
| [Patient – Logisk Model](StructureDefinition-patient.md) | Konceptuel logisk model for en Patient i dansk sundhedsvæsen. |
| [Statusnotifikation](StructureDefinition-ehmi-lm-statusnotifikation.md) | Repræsenterer en automatisk notifikation der sendes til en abonnent (typisk henviseren) ved statusændring på en aktiv henvisning. Svarer til FHIR SubscriptionNotification / SubscriptionStatus (R4B/R5-mønster implementeret via MedCom-notifikationsmodel i R4). |
| [Triagering – Logisk Model](StructureDefinition-triagering.md) | Konceptuel logisk model for en Triagering i dansk sundhedsvæsen. |
| [Visitationsafgoerelse](StructureDefinition-ehmi-lm-visitationsafgoerelse.md) | Repræsenterer visitatorens formelle beslutning om en indkommende henvisning: accept, afvisning, videresendelse eller prioritetsændring. Svarer til FHIR Task med outcome og begrundelse. |

### Structures: Resource Profiles 

These define constraints on FHIR resources for systems conforming to this implementation guide.

| | |
| :--- | :--- |
| [EHMI Referral Message Response Bundle](StructureDefinition-ehmi-referral-message-response-bundle.md) | FHIR Bundle der repræsenterer en komplet henvisningsmeddelelse med response via EHMI. |
| [EHMI Referral MessageHeader](StructureDefinition-ehmi-referral-message-header.md) | MessageHeader for EHMI-baseret henvisningsmeddelelse. |
| [EHMI Referring Message Bundle](StructureDefinition-ehmi-referral-message-bundle.md) | FHIR Bundle der repræsenterer en komplet henvisningsmeddelelse via EHMI. |
| [EHMI ServiceRequest – Henvisning](StructureDefinition-ehmi-service-request.md) | Kerne-ressource der repræsenterer den kliniske henvisning. |

### Terminology: Value Sets 

These define sets of codes used by systems conforming to this implementation guide.

| | |
| :--- | :--- |
| [EHMI Message Event ValueSet](ValueSet-ehmi-message-event-vs.md) | ValueSet over gyldige meddelelseshaendelser til brug i MessageHeader.eventCoding. |
| [EHMI Referral Code ValueSet](ValueSet-ehmi-referral-code-vs.md) | Ydelseskoder for EHMI-henvisninger – SKS procedurer og SNOMED CT. |

### Terminology: Code Systems 

These define new code systems used by systems conforming to this implementation guide.

| | |
| :--- | :--- |
| [EHMI Message Event Codes](CodeSystem-ehmi-message-event-cs.md) | Koder for meddelelseshaendelser i EHMI-meddelelseskommunikation. |

