# FHIR-baseret Logisk Model: Henvisningsmeddelelse (EHMI)

> **Formål:** Konceptuelt og arkitektonisk udgangspunkt for implementering af
> sundhedsfaglige henvisninger via EHMI og FHIR-baseret meddelelseskommunikation.
> Baseret på HL7 FHIR R4 og dansk profileringstradition (dk-core, MedCom FHIR).

---

## 1. Overordnet arkitektur

En FHIR-baseret henvisningsmeddelelse struktureres som en **FHIR Bundle** af typen
`message`. Bundlen indeholder en **MessageHeader** som første entry, efterfulgt af
de kliniske og administrative ressourcer der udgør selve henvisningen.

```
Bundle (type: message)
 ├── MessageHeader              ← Meddelelseskonvolut (afsender, modtager, hændelse)
 ├── ServiceRequest             ← Selve henvisningen (kernen)
 ├── Patient                   ← Patienten der henvises
 ├── Practitioner               ← Henvisende læge/behandler
 ├── PractitionerRole           ← Henviserens rolle og organisation
 ├── Organization (afsender)   ← Afsendende organisation (praksis/hospital)
 ├── Organization (modtager)   ← Modtagende organisation (speciallæge/hospital)
 ├── Encounter (valgfri)       ← Aktuel kontekst/konsultation
 ├── Condition (valgfri)       ← Diagnose/problemstilling
 ├── Observation (valgfri)     ← Relevante fund/målinger
 └── DocumentReference (valgfri) ← Vedlagte dokumenter/bilag
```

---

## 2. FHIR Shorthand (FSH) – Logiske profiler

### 2.1 Bundle – Henvisningsmeddelelse

```fsh
Profile: EHMIReferralMessageBundle
Parent: Bundle
Id: ehmi-referral-message-bundle
Title: "EHMI Referring Message Bundle"
Description: "FHIR Bundle der repræsenterer en komplet henvisningsmeddelelse via EHMI."

* type = #message
* timestamp 1..1 MS
* entry 1..* MS

// Første entry SKAL være MessageHeader
* entry[0].resource only EHMIReferralMessageHeader
* entry[0] 1..1

// ServiceRequest er påkrævet
* entry ^slicing.discriminator.type = #type
* entry ^slicing.discriminator.path = "resource"
* entry ^slicing.rules = #open

* entry contains
    messageHeader 1..1 and
    serviceRequest 1..1 and
    patient 1..1 and
    referringPractitioner 1..1 and
    referringOrganization 1..1 and
    receivingOrganization 1..1

* entry[messageHeader].resource only EHMIReferralMessageHeader
* entry[serviceRequest].resource only EHMIServiceRequest
* entry[patient].resource only DkCorePatient
* entry[referringPractitioner].resource only DkCorePractitioner
* entry[referringOrganization].resource only DkCoreOrganization
* entry[receivingOrganization].resource only DkCoreOrganization
```

---

### 2.2 MessageHeader – Meddelelseskonvolut

```fsh
Profile: EHMIReferralMessageHeader
Parent: MessageHeader
Id: ehmi-referral-message-header
Title: "EHMI Referral MessageHeader"
Description: "MessageHeader for EHMI-baseret henvisningsmeddelelse."

* event[x] only Coding
* eventCoding = EHMIMessageEventCS#new-referral "Ny henvisning"
* eventCoding 1..1 MS

// Afsender
* sender 1..1 MS
* sender only Reference(DkCoreOrganization)

// Modtager
* destination 1..* MS
* destination.receiver 1..1 MS
* destination.receiver only Reference(DkCoreOrganization)
* destination.endpoint 1..1 MS   // EHMI endpoint (SOR/GLN/eDelivery)

// Kildesystem
* source 1..1 MS
* source.endpoint 1..1 MS        // Afsenders tekniske endpoint

// Reference til ServiceRequest som fokus
* focus 1..* MS
* focus only Reference(EHMIServiceRequest)

// Meddelelsens unikke id
* id 1..1 MS                     // UUID v4

// Metadata
* meta.profile 1..* MS
```

---

### 2.3 ServiceRequest – Selve Henvisningen

```fsh
Profile: EHMIServiceRequest
Parent: ServiceRequest
Id: ehmi-service-request
Title: "EHMI ServiceRequest – Henvisning"
Description: "Kerne-ressource der repræsenterer den kliniske henvisning."

* status 1..1 MS
* status from ServiceRequestStatusVS (required)
// Typiske værdier: #active | #on-hold | #revoked | #completed

* intent 1..1 MS
* intent = #order   // Henvisning er en ordre

// Prioritet
* priority 0..1 MS
* priority from RequestPriorityVS (required)
// #routine | #urgent | #asap | #stat

// Hvad der henvises til (ydelse/specialale)
* code 1..1 MS
* code from EHMIReferralCodeVS (preferred)
// Fx SKS-koder, SNOMED CT, eller nationale ydelseskoder

// Hvem der henvises
* subject 1..1 MS
* subject only Reference(DkCorePatient)

// Hvornår
* occurrenceDateTime 0..1 MS     // Ønsket tidspunkt/frist
* authoredOn 1..1 MS             // Tidspunkt for oprettelse

// Klinisk indikation / diagnose
* reasonCode 0..* MS
* reasonCode from SCTDiagnosisVS (preferred)   // SNOMED CT diagnoser

* reasonReference 0..* MS
* reasonReference only Reference(Condition)

// Henvisende behandler
* requester 1..1 MS
* requester only Reference(DkCorePractitioner or DkCorePractitionerRole)

// Modtager/udfører
* performer 0..* MS
* performer only Reference(DkCoreOrganization or DkCorePractitioner)

// Klinisk note / henvisningstekst (fri tekst)
* note 0..* MS

// Vedlagte oplysninger
* supportingInfo 0..* MS
* supportingInfo only Reference(Observation or Condition or DocumentReference)

// Relevant kontekst (konsultation)
* encounter 0..1 MS
* encounter only Reference(Encounter)

// Identifikation
* identifier 1..* MS             // Lokalt journal-/henvisningsnummer
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open

* identifier contains
    localId 1..1 and
    sorReferralId 0..1

* identifier[localId].system = "http://example.dk/fhir/NamingSystem/local-referral-id"
* identifier[sorReferralId].system = "https://www.esundhed.dk/NamingSystem/SOR-referral"
```

---

### 2.4 Hændelses-CodeSystem – EHMI Message Events

```fsh
CodeSystem: EHMIMessageEventCS
Id: ehmi-message-event-cs
Title: "EHMI Message Event Codes"
Description: "Koder for meddelelseshændelser i EHMI-meddelelseskommunikation."

* #new-referral       "Ny henvisning"        "Afsendelse af en ny henvisning"
* #cancel-referral    "Annuller henvisning"   "Tilbagetrækning af en tidligere sendt henvisning"
* #update-referral    "Opdater henvisning"    "Rettelse/tilføjelse til eksisterende henvisning"
* #acknowledge        "Kvittering"           "Teknisk kvittering for modtagelse"
```

---

### 2.5 ValueSet – Prioritet og Status (dansk kontekst)

```fsh
ValueSet: EHMIReferralPriorityVS
Id: ehmi-referral-priority-vs
Title: "EHMI Referring Priority"
Description: "Prioriteter for EHMI-henvisninger."

* include codes from system http://hl7.org/fhir/request-priority
    where concept is-a #routine
* include codes from system http://hl7.org/fhir/request-priority
    where concept is-a #urgent
```

---

### 2.6 Logical Model – Konceptuel oversigt (FSH LogicalModel)

```fsh
Logical: EHMIReferralLogicalModel
Id: ehmi-referral-logical-model
Title: "EHMI Henvisning – Logisk Model"
Description: "Konceptuel logisk model for en henvisningsmeddelelse i dansk sundhedsvæsen."

* meddelelse 1..1 BackboneElement "Meddelelseskonvolut"
  * messageId 1..1 id "Unik meddelelsesidentifikator (UUID)"
  * timestamp 1..1 dateTime "Afsendelsestidspunkt"
  * hændelse 1..1 Coding "Hændelsestype (ny/annuller/opdater)"
  * afsender 1..1 BackboneElement "Afsendende organisation"
    * sorKode 1..1 string "SOR-kode for afsender"
    * navn 1..1 string "Organisationsnavn"
    * yder 0..1 string "Ydernummer (hvis relevant)"
  * modtager 1..* BackboneElement "Modtagende organisation"
    * sorKode 1..1 string "SOR-kode for modtager"
    * navn 1..1 string "Organisationsnavn"
    * ehmiEndpoint 1..1 url "EHMI/eDelivery endpoint"

* patient 1..1 BackboneElement "Patient"
  * cpr 1..1 string "CPR-nummer"
  * navn 1..1 HumanName "Fulde navn"
  * adresse 0..1 Address "Bopælsadresse"
  * telefon 0..1 ContactPoint "Kontakttelefon"

* henvisning 1..1 BackboneElement "Klinisk Henvisning (ServiceRequest)"
  * id 1..1 id "Henvisningsidentifikator"
  * oprettetDato 1..1 dateTime "Dato for oprettelse"
  * prioritet 1..1 code "routine | urgent | asap | stat"
  * ydelseskode 1..1 CodeableConcept "Kode for ønsket ydelse/specialale"
  * indikation 1..* BackboneElement "Klinisk indikation"
    * diagnose 0..1 CodeableConcept "Diagnosekode (SKS/SNOMED CT)"
    * friTekst 0..1 string "Uddybende klinisk tekst"
  * anamnese 0..1 string "Relevant sygehistorie"
  * aktuelleProblemer 0..* CodeableConcept "Aktuelle problemstillinger"
  * medicin 0..1 string "Aktuel medicinliste (reference eller fri tekst)"
  * paraklinik 0..* BackboneElement "Vedlagte undersøgelser"
    * type 1..1 code "observation | documentReference"
    * reference 1..1 Reference "Reference til FHIR-ressource"
  * ønsketTidspunkt 0..1 dateTime "Ønsket tidspunkt for undersøgelse"

* henviser 1..1 BackboneElement "Henvisende behandler"
  * autorisationsId 1..1 string "Autorisations-ID"
  * navn 1..1 HumanName "Behandlerens navn"
  * speciale 0..1 CodeableConcept "Speciale/rolle"
  * kontakt 0..1 ContactPoint "Direkte kontakt til henviser"
```

---

## 3. Nøglebindinger og nationale identifikatorer

| Element | Identifier / System | Kilde |
|---|---|---|
| Patient | CPR | `urn:oid:1.2.208.176.1.2` |
| Organisation | SOR-kode | `https://www.esundhed.dk/NamingSystem/SOR` |
| Behandler | Autorisations-ID | `https://www.esundhed.dk/NamingSystem/AuthorizationIdentifier` |
| Ydernummer | Ydernummer | `https://www.esundhed.dk/NamingSystem/Ydernummer` |
| Diagnose | SKS / SNOMED CT | `https://www.esundhed.dk/NamingSystem/SKS` / `http://snomed.info/sct` |
| Ydelse | SKS procedure / MedCom | National ydelseskodning |
| Endpoint | EHMI / eDelivery | AP/SMP-opslag via EHMI |

---

## 4. EHMI Meddelelsesflow

```
Afsender (EPJ/PAS)
   │
   ├─ [1] Opret Bundle (message)
   │       └─ MessageHeader + ServiceRequest + Patient + ...
   │
   ├─ [2] Valider mod EHMI FHIR-profiler
   │
   ├─ [3] Opslagsservice → SMP (find modtagers endpoint via SOR)
   │
   ├─ [4] Afsend via EHMI / eDelivery (AS4)
   │
   └─ [5] Modtag $process-message kvittering
           └─ Bundle (type: message) med acknowledge-hændelse

Modtager (EPJ/PAS/Speciallægesystem)
   │
   ├─ [6] Modtag og valider Bundle
   ├─ [7] Udtræk ServiceRequest og opret lokal sag
   └─ [8] Send kvittering (acknowledge) retur
```

---

## 5. Centrale designprincipper

- **FHIR R4** som teknisk fundament, med MedCom FHIR og dk-core profiler som basis
- **Bundle/message** mønster sikrer atomicitet – alle ressourcer sendes samlet
- **SOR** som autoritativ kilde til organisations- og endpoint-opslag via EHMI's SMP
- **eDelivery (AS4)** som transportlag – EHMI håndterer adressering og sikkerhed
- **$process-message** operationen anvendes til modtagelse og kvittering
- **Versionshistorik** sikres via `Bundle.meta.lastUpdated` og `identifier` på `ServiceRequest`
- **Udvidelsespunkter** via FHIR extensions for dansk-specifikke behov (fx henvisningstype, hastegrad, triage-kategori)

---

## 6. Anbefalede næste skridt

1. **Profilering** – Udarbejd formelle CapabilityStatements for afsender og modtager
2. **Terminologi** – Afstem nationale kodninger (SKS, SNOMED CT, lokale) med Sundhedsdatastyrelsen
3. **Validering** – Implementer FHIR Validator med EHMI IG som grundlag
4. **Pilottest** – Afprøv via EHMI testmiljø med udvalgte EPJ-leverandører
5. **Implementeringsguide (IG)** – Publicer som HL7 FHIR Implementation Guide via Simplifier.net
