Logical: DKReferralMessage
Id: dk-referral-message
Title: "DK Logical Referral Message"
Description: "Logisk FHIR-model for dansk henvisningsmeddelelse"

* messageId 1..1 string "Meddelelses-ID"
* messageTimestamp 1..1 dateTime "Afsendelsestidspunkt"

* sender 1..1 BackboneElement "Afsender"
  * sorId 1..1 string "SOR-id"
  * organizationName 1..1 string "Organisationsnavn"
  * departmentName 0..1 string "Afdeling"
  * healthcareProfessional 0..1 string "Sundhedsperson"
  * ediIdentifier 0..1 string "EDI-identifikator"

* receiver 1..1 BackboneElement "Modtager"
  * sorId 1..1 string "SOR-id"
  * organizationName 1..1 string "Organisationsnavn"
  * departmentName 0..1 string "Afdeling"
  * healthcareServiceType 0..1 CodeableConcept "Speciale/funktion"

* patient 1..1 BackboneElement "Patient"
  * cpr 1..1 string "CPR-nummer"
  * givenName 1..1 string "Fornavn"
  * familyName 1..1 string "Efternavn"
  * birthDate 0..1 date "Fødselsdato"
  * gender 0..1 code "Køn"
  * address 0..1 string "Adresse"
  * phone 0..1 string "Telefonnummer"

* referral 1..1 BackboneElement "Henvisning"
  * referralIdentifier 1..1 string "Henvisnings-id"
  * referralType 1..1 CodeableConcept "Henvisningstype"
  * status 1..1 code "Status"
  * priority 0..1 code "Prioritet"
  * authoredOn 1..1 dateTime "Oprettelsestidspunkt"

  * clinicalInformation 0..1 string "Kliniske oplysninger"
  * anamnesis 0..1 string "Anamnese"
  * objectiveFindings 0..1 string "Objektive fund"
  * currentMedication 0..1 string "Aktuel medicin"
  * allergies 0..1 string "Allergier"

  * requestedService 1..1 BackboneElement "Ønsket ydelse"
    * specialty 0..1 CodeableConcept "Speciale"
    * serviceCode 0..1 CodeableConcept "Ydelse"
    * requestedExamination 0..1 string "Ønsket undersøgelse"
    * requestedTreatment 0..1 string "Ønsket behandling"

  * diagnosis 0..* BackboneElement "Diagnoser"
    * diagnosisCode 1..1 CodeableConcept "Diagnosekode"
    * diagnosisText 0..1 string "Diagnosetekst"

  * reasonForReferral 0..* BackboneElement "Henvisningsårsag"
    * reasonCode 0..1 CodeableConcept "Årsagskode"
    * reasonText 0..1 string "Årsagsbeskrivelse"

  * packageCourse 0..1 BackboneElement "Pakkeforløb"
    * packageCode 0..1 CodeableConcept "Pakkeforløbskode"
    * packageName 0..1 string "Pakkeforløbsnavn"

  * treatmentPlan 0..1 BackboneElement "Behandlingsplan"
    * requestedSessions 0..1 integer "Antal sessioner"
    * remainingSessions 0..1 integer "Resterende sessioner"
    * treatmentFrequency 0..1 string "Behandlingsfrekvens"

  * attachments 0..* BackboneElement "Bilag"
    * attachmentType 1..1 CodeableConcept "Bilagstype"
    * title 0..1 string "Titel"
    * contentType 0..1 code "MIME-type"
    * url 0..1 uri "Reference til dokument"

* workflow 0..1 BackboneElement "Workflow-information"
  * workflowStatus 0..1 code "Workflowstatus"
  * referralReceived 0..1 boolean "Modtaget"
  * referralAccepted 0..1 boolean "Accepteret"
  * referralRejected 0..1 boolean "Afvist"
  * bookingStatus 0..1 code "Bookingstatus"

* provenance 0..1 BackboneElement "Sporbarhed"
  * createdBy 0..1 string "Oprettet af"
  * createdOrganization 0..1 string "Oprettende organisation"
  * lastUpdated 0..1 dateTime "Senest opdateret"

Mapping: FHIRMapping
Source: DKReferralMessage
Target: "FHIR R4"

* -> "Bundle"
* sender -> "MessageHeader.sender"
* receiver -> "MessageHeader.destination"
* patient -> "Patient"
* referral -> "ServiceRequest"
* referral.diagnosis -> "Condition"
* referral.reasonForReferral -> "ServiceRequest.reasonReference"
* referral.attachments -> "DocumentReference"
* workflow -> "Task"
* provenance -> "Provenance"