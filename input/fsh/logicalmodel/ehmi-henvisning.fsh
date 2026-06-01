// ============================================================
// EHMI Referring Message – FHIR Shorthand (FSH)
// Logisk model for FHIR-baseret henvisningsmeddelelse via EHMI
// Baseret på HL7 FHIR R4, dk-core og MedCom FHIR
// ============================================================


// ------------------------------------------------------------
// 1.1 Bundle – Henvisningsmeddelelse
// ------------------------------------------------------------

Profile: EHMIReferralMessageBundle
Parent: Bundle
Id: ehmi-referral-message-bundle
Title: "EHMI Referring Message Bundle"
Description: "FHIR Bundle der repræsenterer en komplet henvisningsmeddelelse via EHMI."

* type = #message
* timestamp 1..1 MS
* entry 1..* MS

// Slicing på entry via profile-discriminator
* entry ^slicing.discriminator.type = #profile
* entry ^slicing.discriminator.path = "resource"
* entry ^slicing.rules = #open
* entry ^slicing.ordered = true

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


Profile: EHMIReferralMessageResponseBundle
Parent: Bundle
Id: ehmi-referral-message-response-bundle
Title: "EHMI Referral Message Response Bundle"
Description: "FHIR Bundle der repræsenterer en komplet henvisningsmeddelelse med response via EHMI."

* type = #message
* timestamp 1..1 MS
* entry 1..* MS

// Slicing på entry via profile-discriminator
* entry ^slicing.discriminator.type = #profile
* entry ^slicing.discriminator.path = "resource"
* entry ^slicing.rules = #open
* entry ^slicing.ordered = true

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


// ------------------------------------------------------------
// 2.2 MessageHeader – Meddelelseskonvolut
// ------------------------------------------------------------

Profile: EHMIReferralMessageHeader
Parent: MessageHeader
Id: ehmi-referral-message-header
Title: "EHMI Referral MessageHeader"
Description: "MessageHeader for EHMI-baseret henvisningsmeddelelse."

* event[x] only Coding
* eventCoding from EHMIMessageEventVS (required)
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


// ------------------------------------------------------------
// 2.3 ServiceRequest – Selve Henvisningen
// ------------------------------------------------------------

Profile: EHMIServiceRequest
Parent: ServiceRequest
Id: ehmi-service-request
Title: "EHMI ServiceRequest – Henvisning"
Description: "Kerne-ressource der repræsenterer den kliniske henvisning."

* status 1..1 MS
// status er bundet til http://hl7.org/fhir/ValueSet/request-status i FHIR-kernen (required)
// Typiske værdier: #active | #on-hold | #revoked | #completed

* intent 1..1 MS
* intent = #order   // Henvisning er en ordre

// Prioritet – bundet til FHIR-kernens request-priority ValueSet
* priority 0..1 MS
* priority from http://hl7.org/fhir/ValueSet/request-priority (required)
// #routine | #urgent | #asap | #stat

// Hvad der henvises til (ydelse/specialale)
* code 1..1 MS
* code from EHMIReferralCodeVS (preferred)
// Fx SKS-koder, SNOMED CT, eller nationale ydelseskoder

// Hvem der henvises
* subject 1..1 MS
* subject only Reference(DkCorePatient)

// Hvornår
* occurrenceDateTime 0..1 MS     // Oensket tidspunkt/frist
* authoredOn 1..1 MS             // Tidspunkt for oprettelse

// Klinisk indikation / diagnose
* reasonCode 0..* MS
* reasonCode from http://hl7.org/fhir/ValueSet/condition-code (preferred)
// SNOMED CT diagnoser via FHIR-kernens condition-code VS

* reasonReference 0..* MS
* reasonReference only Reference(Condition)

// Henvisende behandler – PractitionerRole findes i FHIR-kernen
* requester 1..1 MS
* requester only Reference(DkCorePractitioner or PractitionerRole)

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


// ------------------------------------------------------------
// 2.4 Hændelses-CodeSystem – EHMI Message Events
// ------------------------------------------------------------

CodeSystem: EHMIMessageEventCS
Id: ehmi-message-event-cs
Title: "EHMI Message Event Codes"
Description: "Koder for meddelelseshaendelser i EHMI-meddelelseskommunikation."

* #new-referral       "Ny henvisning"        "Afsendelse af en ny henvisning"
* #cancel-referral    "Annuller henvisning"   "Tilbagetrækning af en tidligere sendt henvisning"
* #update-referral    "Opdater henvisning"    "Rettelse/tilfoejelse til eksisterende henvisning"
* #acknowledge        "Kvittering"           "Teknisk kvittering for modtagelse"


// ------------------------------------------------------------
// 2.4b ValueSet – EHMI Message Events
// ------------------------------------------------------------

ValueSet: EHMIMessageEventVS
Id: ehmi-message-event-vs
Title: "EHMI Message Event ValueSet"
Description: "ValueSet over gyldige meddelelseshaendelser til brug i MessageHeader.eventCoding."

* include codes from system EHMIMessageEventCS


// ------------------------------------------------------------
// 2.5 ValueSet – Ydelseskoder (dansk kontekst)
// ------------------------------------------------------------

ValueSet: EHMIReferralCodeVS
Id: ehmi-referral-code-vs
Title: "EHMI Referral Code ValueSet"
Description: "Ydelseskoder for EHMI-henvisninger – SKS procedurer og SNOMED CT."

* include codes from system http://snomed.info/sct
    where concept is-a #3457005   // "Patientkonsultation" – udgangspunkt for specialehenvisninger
* include codes from system urn:oid:1.2.208.176.2.4
    // SKS procedurekoder (dansk national kodning)

