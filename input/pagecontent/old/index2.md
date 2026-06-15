# Logisk FHIR-model for en henvisningsmeddelelse

## Formål

Denne model beskriver en logisk FHIR-baseret struktur for en moderne henvisningsmeddelelse i sundhedsvæsenet. Modellen er tænkt som et konceptuelt og arkitektonisk udgangspunkt for implementering af henvisninger via EHMI og FHIR-baseret meddelelseskommunikation.

Modellen fokuserer på:

* Klinisk indhold
* Forretningsmæssig struktur
* Meddelelsesindpakning
* Workflow og statusstyring
* Mulighed for både synkrone og asynkrone integrationsmønstre
* Understøttelse af MedCom-lignende henvisningsflows

---

# Overordnet arkitektur

En henvisningsmeddelelse består logisk af:

1. En MessageHeader som transport- og routing-envelope
2. En central ServiceRequest som selve henvisningen
3. Relaterede kliniske og administrative ressourcer
4. Eventuelle bilag og dokumenter
5. Workflow- og sporingsinformation

---

# Central logisk model

```text
MessageHeader
 ├── sender (Organization / Practitioner / Device)
 ├── destination
 ├── eventCoding = referral-message
 ├── focus → ServiceRequest
 └── response / provenance

ServiceRequest (Henvisning)
 ├── status
 ├── intent
 ├── category
 ├── priority
 ├── code
 ├── subject → Patient
 ├── requester → Practitioner / Organization
 ├── performer → Organization / HealthcareService
 ├── encounter → Encounter
 ├── reasonReference → Condition / Observation
 ├── supportingInfo → Observation / QuestionnaireResponse / DocumentReference
 ├── note
 ├── authoredOn
 ├── occurrence[x]
 ├── insurance
 ├── extension: pakkeforløb
 ├── extension: henvisningsdiagnose
 ├── extension: ønsket speciale
 ├── extension: behandlingssessioner
 └── basedOn / replaces

Patient
 ├── CPR
 ├── navn
 ├── adresse
 ├── kontaktinformation
 ├── pårørende
 └── praktiserende læge

Practitioner
 ├── ydernummer
 ├── navn
 ├── autorisation
 └── specialer

Organization
 ├── SOR-id
 ├── lokationsinformation
 ├── organisatorisk type
 └── kontaktoplysninger

Encounter
 ├── henvisende kontakt
 ├── afdeling
 ├── tidspunkt
 └── kontaktårsag

Condition
 ├── diagnose
 ├── klinisk status
 ├── alvorlighed
 └── debut

Observation
 ├── prøvesvar
 ├── målinger
 ├── vitalparametre
 └── screeningsresultater

DocumentReference
 ├── epikriser
 ├── billeddiagnostik
 ├── PDF-bilag
 └── eksterne dokumenter

Task (workflow)
 ├── modtaget
 ├── visiteret
 ├── accepteret
 ├── afvist
 ├── booket
 └── afsluttet
```

---

# Centrale FHIR-ressourcer

| Ressource             | Rolle i henvisningen               |
| --------------------- | ---------------------------------- |
| ServiceRequest        | Selve henvisningen                 |
| MessageHeader         | Meddelelses-envelope               |
| Patient               | Patienten                          |
| Practitioner          | Henvisende kliniker                |
| Organization          | Henvisende/modtagende organisation |
| Encounter             | Klinisk kontakt                    |
| Condition             | Diagnoser og problemstillinger     |
| Observation           | Kliniske observationer             |
| QuestionnaireResponse | Strukturerede spørgeskemaer        |
| DocumentReference     | Bilag og dokumenter                |
| Task                  | Workflow- og processtyring         |
| Provenance            | Sporbarhed                         |
| AuditEvent            | Revision og sikkerhed              |

---

# Logisk informationsmodel

## 1. Meddelelsesniveau

Meddelelsesniveauet håndteres af MessageHeader.

Typiske ansvar:

* Identifikation af meddelelsen
* Routing
* Korrelations-id
* Svarrelationer
* Afsender/modtager
* EHMI transportmetadata

Eksempel:

```text
MessageHeader.event = referral-message
MessageHeader.focus = ServiceRequest/12345
```

---

# 2. Henvisningsniveau

Den egentlige henvisning repræsenteres af ServiceRequest.

## Centrale attributter

| Felt            | Betydning                      |
| --------------- | ------------------------------ |
| status          | Aktiv, completed, revoked osv. |
| intent          | order                          |
| category        | Henvisningstype                |
| priority        | Rutine, akut osv.              |
| code            | Henvisningens kliniske formål  |
| subject         | Patient                        |
| requester       | Henvisende instans             |
| performer       | Modtagende instans             |
| reasonReference | Årsag til henvisning           |
| supportingInfo  | Understøttende information     |
| note            | Kliniske noter                 |

---

# 3. Workflow-model

FHIR giver mulighed for at modellere workflow eksplicit via Task.

## Eksempel på workflow

```text
ServiceRequest
   ↓
Task: modtaget
   ↓
Task: visiteret
   ↓
Task: accepteret
   ↓
Task: booket
   ↓
Task: afsluttet
```

Dette muliggør:

* Visitation
* Fordeling mellem afdelinger
* Ventelistehåndtering
* Statussporing
* Kvitteringer
* Procesmonitorering

---

# 4. Pakkeforløb og behandlingsserier

Danske henvisninger indeholder ofte særlige forretningsregler omkring:

* Kræftpakker
* Speciallægehenvisninger
* Genoptræningsforløb
* Kommunale tilbud
* Sessionstælling

Disse kan modelleres via:

## Extensions

Eksempel:

```text
extension: packageCourse
extension: referralType
extension: sessionCount
extension: sessionRemaining
```

## Eller dedikerede profiler

Eksempel:

* HospitalReferralServiceRequest
* SpecialistReferralServiceRequest
* MunicipalityReferralServiceRequest

---

# 5. Bilag og klinisk dokumentation

FHIR understøtter både:

* Strukturerede data
* Dokumentorienterede bilag
* Hybridmodeller

## Typisk model

```text
ServiceRequest.supportingInfo
    → Observation
    → QuestionnaireResponse
    → DocumentReference
```

DocumentReference kan pege på:

* PDF
* CDA
* billeder
* eksterne repositories
* nationale dokumenttjenester

---

# 6. MedCom- og EHMI-perspektiv

I en EHMI-baseret arkitektur kan henvisningen sendes som:

## FHIR Messaging

```text
Bundle (message)
 ├── MessageHeader
 ├── ServiceRequest
 ├── Patient
 ├── Practitioner
 ├── Organization
 ├── Condition
 ├── Observation
 └── DocumentReference
```

## Alternativt dokumentbaseret

```text
Bundle (document)
```

eller

## API-baseret workflow

```text
RESTful ServiceRequest API
+ Subscription/Task events
```

---

# Eksempel på message bundle

```json
{
  "resourceType": "Bundle",
  "type": "message",
  "entry": [
    {
      "resource": {
        "resourceType": "MessageHeader"
      }
    },
    {
      "resource": {
        "resourceType": "ServiceRequest"
      }
    },
    {
      "resource": {
        "resourceType": "Patient"
      }
    }
  ]
}
```

---

# Forslag til profilhierarki

## Basal profil

```text
DKReferralServiceRequest
```

## Specialiseringer

```text
DKHospitalReferral
DKSpecialistReferral
DKMunicipalityReferral
DKImagingReferral
DKLabReferral
```

---

# Mulige MessageDefinitions

FHIR MessageDefinition kan anvendes som template- og kontraktmekanisme.

Eksempel:

| MessageDefinition            | Formål                |
| ---------------------------- | --------------------- |
| HospitalReferralMessage      | Sygehushenvisning     |
| SpecialistReferralMessage    | Speciallægehenvisning |
| MunicipalityReferralMessage  | Kommunal henvisning   |
| CancerPackageReferralMessage | Pakkeforløb           |

Dette giver:

* Konfigurerbarhed
* Versionsstyring
* Validering
* Forskellige obligatoriske felter
* Forskellige workflows

---

# Arkitekturmæssige styrker

## FHIR-baseret henvisningsmodel giver

### Standardiseret informationsmodel

* International standard
* Genbrug af ressourcer
* Semantisk interoperabilitet

### Workflow-understøttelse

* Task-baseret processtyring
* Sporbarhed
* Kvitteringsflows

### Hybrid dokument/data-model

* Strukturerede data
* Dokumenter
* Bilag
* Links

### Udvidelsesmuligheder

* Nationale profiler
* Extensions
* MessageDefinitions

### Fremtidssikring

* Understøtter både messaging og API
* Kan anvendes i eventbaserede arkitekturer
* Velegnet til EHMI

---

# Arkitekturmæssige udfordringer

## Kompleksitet

FHIR messaging er mere fleksibel — men også mere kompleks — end klassiske MedCom-meddelelser.

## Governance

Kræver stærk governance omkring:

* profiler
* extensions
* kodeværker
* versionsstyring
* workflows

## Workflow-standardisering

Task-baserede flows skal standardiseres nationalt.

## Samspil mellem dokument og struktur

Der skal findes balance mellem:

* PDF/CDA-lignende dokumenter
* fuldt strukturerede data

---

# Anbefalet målarkitektur

## Kort sigt

* FHIR Messaging via EHMI
* MedCom-lignende meddelelsesflows
* Fokus på kompatibilitet

## Mellemlangt sigt

* Task-baseret workflow
* Strukturerede bilag
* Shared Care-modeller

## Langt sigt

* API-baserede henvisninger
* Eventdrevet arkitektur
* Realtidsworkflow
* Shared longitudinal referral state

---

# FHIR Shorthand (FSH) eksempel

Nedenstående viser et eksempel på en logisk dansk henvisningsmodel beskrevet i FHIR Shorthand.

```fsh
Alias: $sct = http://snomed.info/sct
Alias: $loinc = http://loinc.org
Alias: $message-events = http://example.org/fhir/message-events

Profile: DKReferralMessageBundle
Parent: Bundle
Id: dk-referral-message-bundle
Title: "DK Referral Message Bundle"
Description: "FHIR message bundle for dansk henvisningsmeddelelse"

* type = #message
* entry 1..*
* entry.resource 1..
* entry.resource only
    MessageHeader or
    DKReferralServiceRequest or
    Patient or
    Practitioner or
    Organization or
    Encounter or
    Condition or
    Observation or
    DocumentReference or
    Task


Profile: DKReferralMessageHeader
Parent: MessageHeader
Id: dk-referral-message-header
Title: "DK Referral Message Header"

* eventCoding 1..1
* eventCoding = $message-events#referral-message

* sender 1..1
* sender only Reference(Organization)

* source 1..1

* focus 1..1
* focus only Reference(DKReferralServiceRequest)


Profile: DKReferralServiceRequest
Parent: ServiceRequest
Id: dk-referral-service-request
Title: "DK Referral ServiceRequest"
Description: "Dansk logisk model for henvisning"

* status 1..1
* intent 1..1
* subject 1..1
* authoredOn 1..1
* requester 1..1
* code 1..1

* status from RequestStatus (required)
* intent = #order

* category 1..*
* priority 0..1
* encounter 0..1

* subject only Reference(Patient)
* requester only Reference(Practitioner or Organization)
* performer only Reference(Organization or Practitioner)
* encounter only Reference(Encounter)

* reasonReference 0..*
* reasonReference only Reference(Condition or Observation)

* supportingInfo 0..*
* supportingInfo only Reference(
    Observation or
    QuestionnaireResponse or
    DocumentReference
)

* note 0..*
* insurance 0..*

* extension contains
    ReferralSpeciality named referralSpeciality 0..1 and
    ReferralPackageCourse named packageCourse 0..1 and
    ReferralSessionCount named sessionCount 0..1 and
    ReferralRemainingSessions named remainingSessions 0..1


Extension: ReferralSpeciality
Id: referral-speciality
Title: "Referral Speciality"
Description: "Ønsket speciale"

* value[x] only CodeableConcept


Extension: ReferralPackageCourse
Id: referral-package-course
Title: "Referral Package Course"
Description: "Pakkeforløb"

* value[x] only CodeableConcept


Extension: ReferralSessionCount
Id: referral-session-count
Title: "Referral Session Count"
Description: "Antal behandlingssessioner"

* value[x] only integer


Extension: ReferralRemainingSessions
Id: referral-remaining-sessions
Title: "Referral Remaining Sessions"
Description: "Resterende behandlingssessioner"

* value[x] only integer


Profile: DKReferralTask
Parent: Task
Id: dk-referral-task
Title: "DK Referral Workflow Task"

* status 1..1
* intent 1..1
* for 1..1
* focus 1..1

* for only Reference(Patient)
* focus only Reference(DKReferralServiceRequest)

* statusReason 0..1
* businessStatus 0..1


Profile: DKReferralDocumentReference
Parent: DocumentReference
Id: dk-referral-document-reference
Title: "DK Referral DocumentReference"

* status 1..1
* subject 1..1
* content 1..*

* subject only Reference(Patient)


Instance: ExampleReferralMessage
InstanceOf: DKReferralMessageBundle
Usage: #example

* type = #message

* entry[0].resource = ExampleMessageHeader
* entry[1].resource = ExampleServiceRequest


Instance: ExampleMessageHeader
InstanceOf: DKReferralMessageHeader
Usage: #example

* eventCoding = $message-events#referral-message
* focus = Reference(ExampleServiceRequest)


Instance: ExampleServiceRequest
InstanceOf: DKReferralServiceRequest
Usage: #example

* status = #active
* intent = #order
* subject = Reference(ExamplePatient)
* authoredOn = "2026-05-27"
* priority = #routine

* code = $sct#306206005 "Referral to service"

```

---

# Konklusion

En logisk FHIR-model for henvisningsmeddelelser bør centreres omkring:

* ServiceRequest som den kliniske kerneressource
* MessageHeader som transport-envelope
* Task som workflowmekanisme
* SupportingInfo og DocumentReference som klinisk dokumentation
* Nationale profiler og MessageDefinitions som governance- og standardiseringsmekanisme

Modellen giver en stærk platform for fremtidens EHMI-baserede meddelelseskommunikation og muliggør en gradvis overgang fra klassiske dokumentorienterede MedCom-meddelelser til moderne interoperable workflow-baserede integrationsmønstre.
