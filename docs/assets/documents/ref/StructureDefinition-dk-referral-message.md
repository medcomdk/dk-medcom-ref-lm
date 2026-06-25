# DK Logical Referral Message - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **DK Logical Referral Message**

## Logical Model: DK Logical Referral Message 

| | |
| :--- | :--- |
| *Official URL*:http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/dk-referral-message | *Version*:0.1.0 |
| Draft as of 2026-06-25 | *Computable Name*:DKReferralMessage |

 
Logisk FHIR-model for dansk henvisningsmeddelelse 

**Usages:**

* This Logical Model is not used by any profiles in this Specification

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/dk-medcom-ref-lm|current/StructureDefinition/StructureDefinition-dk-referral-message.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-dk-referral-message.csv), [Excel](StructureDefinition-dk-referral-message.xlsx) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "dk-referral-message",
  "url" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/dk-referral-message",
  "version" : "0.1.0",
  "name" : "DKReferralMessage",
  "title" : "DK Logical Referral Message",
  "status" : "draft",
  "date" : "2026-06-25T17:09:01+02:00",
  "publisher" : "MedCom",
  "contact" : [{
    "name" : "MedCom",
    "telecom" : [{
      "system" : "url",
      "value" : "http://medcom.dk"
    }]
  }],
  "description" : "Logisk FHIR-model for dansk henvisningsmeddelelse",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "DK",
      "display" : "Denmark"
    }]
  }],
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "FHIRMapping",
    "uri" : "FHIR R4"
  }],
  "kind" : "logical",
  "abstract" : false,
  "type" : "http://medcomehmi.dk/ig/dk-medcom-ref-lm/StructureDefinition/dk-referral-message",
  "baseDefinition" : "http://hl7.org/fhir/StructureDefinition/Base",
  "derivation" : "specialization",
  "differential" : {
    "element" : [{
      "id" : "dk-referral-message",
      "path" : "dk-referral-message",
      "short" : "DK Logical Referral Message",
      "definition" : "Logisk FHIR-model for dansk henvisningsmeddelelse",
      "mapping" : [{
        "identity" : "FHIRMapping",
        "map" : "Bundle"
      }]
    },
    {
      "id" : "dk-referral-message.messageId",
      "path" : "dk-referral-message.messageId",
      "short" : "Meddelelses-ID",
      "definition" : "Meddelelses-ID",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.messageTimestamp",
      "path" : "dk-referral-message.messageTimestamp",
      "short" : "Afsendelsestidspunkt",
      "definition" : "Afsendelsestidspunkt",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "dateTime"
      }]
    },
    {
      "id" : "dk-referral-message.sender",
      "path" : "dk-referral-message.sender",
      "short" : "Afsender",
      "definition" : "Afsender",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "BackboneElement"
      }],
      "mapping" : [{
        "identity" : "FHIRMapping",
        "map" : "MessageHeader.sender"
      }]
    },
    {
      "id" : "dk-referral-message.sender.sorId",
      "path" : "dk-referral-message.sender.sorId",
      "short" : "SOR-id",
      "definition" : "SOR-id",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.sender.organizationName",
      "path" : "dk-referral-message.sender.organizationName",
      "short" : "Organisationsnavn",
      "definition" : "Organisationsnavn",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.sender.departmentName",
      "path" : "dk-referral-message.sender.departmentName",
      "short" : "Afdeling",
      "definition" : "Afdeling",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.sender.healthcareProfessional",
      "path" : "dk-referral-message.sender.healthcareProfessional",
      "short" : "Sundhedsperson",
      "definition" : "Sundhedsperson",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.sender.ediIdentifier",
      "path" : "dk-referral-message.sender.ediIdentifier",
      "short" : "EDI-identifikator",
      "definition" : "EDI-identifikator",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.receiver",
      "path" : "dk-referral-message.receiver",
      "short" : "Modtager",
      "definition" : "Modtager",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "BackboneElement"
      }],
      "mapping" : [{
        "identity" : "FHIRMapping",
        "map" : "MessageHeader.destination"
      }]
    },
    {
      "id" : "dk-referral-message.receiver.sorId",
      "path" : "dk-referral-message.receiver.sorId",
      "short" : "SOR-id",
      "definition" : "SOR-id",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.receiver.organizationName",
      "path" : "dk-referral-message.receiver.organizationName",
      "short" : "Organisationsnavn",
      "definition" : "Organisationsnavn",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.receiver.departmentName",
      "path" : "dk-referral-message.receiver.departmentName",
      "short" : "Afdeling",
      "definition" : "Afdeling",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.receiver.healthcareServiceType",
      "path" : "dk-referral-message.receiver.healthcareServiceType",
      "short" : "Speciale/funktion",
      "definition" : "Speciale/funktion",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "CodeableConcept"
      }]
    },
    {
      "id" : "dk-referral-message.patient",
      "path" : "dk-referral-message.patient",
      "short" : "Patient",
      "definition" : "Patient",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "BackboneElement"
      }],
      "mapping" : [{
        "identity" : "FHIRMapping",
        "map" : "Patient"
      }]
    },
    {
      "id" : "dk-referral-message.patient.cpr",
      "path" : "dk-referral-message.patient.cpr",
      "short" : "CPR-nummer",
      "definition" : "CPR-nummer",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.patient.givenName",
      "path" : "dk-referral-message.patient.givenName",
      "short" : "Fornavn",
      "definition" : "Fornavn",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.patient.familyName",
      "path" : "dk-referral-message.patient.familyName",
      "short" : "Efternavn",
      "definition" : "Efternavn",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.patient.birthDate",
      "path" : "dk-referral-message.patient.birthDate",
      "short" : "Fødselsdato",
      "definition" : "Fødselsdato",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "date"
      }]
    },
    {
      "id" : "dk-referral-message.patient.gender",
      "path" : "dk-referral-message.patient.gender",
      "short" : "Køn",
      "definition" : "Køn",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "code"
      }]
    },
    {
      "id" : "dk-referral-message.patient.address",
      "path" : "dk-referral-message.patient.address",
      "short" : "Adresse",
      "definition" : "Adresse",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.patient.phone",
      "path" : "dk-referral-message.patient.phone",
      "short" : "Telefonnummer",
      "definition" : "Telefonnummer",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.referral",
      "path" : "dk-referral-message.referral",
      "short" : "Henvisning",
      "definition" : "Henvisning",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "BackboneElement"
      }],
      "mapping" : [{
        "identity" : "FHIRMapping",
        "map" : "ServiceRequest"
      }]
    },
    {
      "id" : "dk-referral-message.referral.referralIdentifier",
      "path" : "dk-referral-message.referral.referralIdentifier",
      "short" : "Henvisnings-id",
      "definition" : "Henvisnings-id",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.referral.referralType",
      "path" : "dk-referral-message.referral.referralType",
      "short" : "Henvisningstype",
      "definition" : "Henvisningstype",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "CodeableConcept"
      }]
    },
    {
      "id" : "dk-referral-message.referral.status",
      "path" : "dk-referral-message.referral.status",
      "short" : "Status",
      "definition" : "Status",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "code"
      }]
    },
    {
      "id" : "dk-referral-message.referral.priority",
      "path" : "dk-referral-message.referral.priority",
      "short" : "Prioritet",
      "definition" : "Prioritet",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "code"
      }]
    },
    {
      "id" : "dk-referral-message.referral.authoredOn",
      "path" : "dk-referral-message.referral.authoredOn",
      "short" : "Oprettelsestidspunkt",
      "definition" : "Oprettelsestidspunkt",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "dateTime"
      }]
    },
    {
      "id" : "dk-referral-message.referral.clinicalInformation",
      "path" : "dk-referral-message.referral.clinicalInformation",
      "short" : "Kliniske oplysninger",
      "definition" : "Kliniske oplysninger",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.referral.anamnesis",
      "path" : "dk-referral-message.referral.anamnesis",
      "short" : "Anamnese",
      "definition" : "Anamnese",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.referral.objectiveFindings",
      "path" : "dk-referral-message.referral.objectiveFindings",
      "short" : "Objektive fund",
      "definition" : "Objektive fund",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.referral.currentMedication",
      "path" : "dk-referral-message.referral.currentMedication",
      "short" : "Aktuel medicin",
      "definition" : "Aktuel medicin",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.referral.allergies",
      "path" : "dk-referral-message.referral.allergies",
      "short" : "Allergier",
      "definition" : "Allergier",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.referral.requestedService",
      "path" : "dk-referral-message.referral.requestedService",
      "short" : "Ønsket ydelse",
      "definition" : "Ønsket ydelse",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "BackboneElement"
      }]
    },
    {
      "id" : "dk-referral-message.referral.requestedService.specialty",
      "path" : "dk-referral-message.referral.requestedService.specialty",
      "short" : "Speciale",
      "definition" : "Speciale",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "CodeableConcept"
      }]
    },
    {
      "id" : "dk-referral-message.referral.requestedService.serviceCode",
      "path" : "dk-referral-message.referral.requestedService.serviceCode",
      "short" : "Ydelse",
      "definition" : "Ydelse",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "CodeableConcept"
      }]
    },
    {
      "id" : "dk-referral-message.referral.requestedService.requestedExamination",
      "path" : "dk-referral-message.referral.requestedService.requestedExamination",
      "short" : "Ønsket undersøgelse",
      "definition" : "Ønsket undersøgelse",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.referral.requestedService.requestedTreatment",
      "path" : "dk-referral-message.referral.requestedService.requestedTreatment",
      "short" : "Ønsket behandling",
      "definition" : "Ønsket behandling",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.referral.diagnosis",
      "path" : "dk-referral-message.referral.diagnosis",
      "short" : "Diagnoser",
      "definition" : "Diagnoser",
      "min" : 0,
      "max" : "*",
      "type" : [{
        "code" : "BackboneElement"
      }],
      "mapping" : [{
        "identity" : "FHIRMapping",
        "map" : "Condition"
      }]
    },
    {
      "id" : "dk-referral-message.referral.diagnosis.diagnosisCode",
      "path" : "dk-referral-message.referral.diagnosis.diagnosisCode",
      "short" : "Diagnosekode",
      "definition" : "Diagnosekode",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "CodeableConcept"
      }]
    },
    {
      "id" : "dk-referral-message.referral.diagnosis.diagnosisText",
      "path" : "dk-referral-message.referral.diagnosis.diagnosisText",
      "short" : "Diagnosetekst",
      "definition" : "Diagnosetekst",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.referral.reasonForReferral",
      "path" : "dk-referral-message.referral.reasonForReferral",
      "short" : "Henvisningsårsag",
      "definition" : "Henvisningsårsag",
      "min" : 0,
      "max" : "*",
      "type" : [{
        "code" : "BackboneElement"
      }],
      "mapping" : [{
        "identity" : "FHIRMapping",
        "map" : "ServiceRequest.reasonReference"
      }]
    },
    {
      "id" : "dk-referral-message.referral.reasonForReferral.reasonCode",
      "path" : "dk-referral-message.referral.reasonForReferral.reasonCode",
      "short" : "Årsagskode",
      "definition" : "Årsagskode",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "CodeableConcept"
      }]
    },
    {
      "id" : "dk-referral-message.referral.reasonForReferral.reasonText",
      "path" : "dk-referral-message.referral.reasonForReferral.reasonText",
      "short" : "Årsagsbeskrivelse",
      "definition" : "Årsagsbeskrivelse",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.referral.packageCourse",
      "path" : "dk-referral-message.referral.packageCourse",
      "short" : "Pakkeforløb",
      "definition" : "Pakkeforløb",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "BackboneElement"
      }]
    },
    {
      "id" : "dk-referral-message.referral.packageCourse.packageCode",
      "path" : "dk-referral-message.referral.packageCourse.packageCode",
      "short" : "Pakkeforløbskode",
      "definition" : "Pakkeforløbskode",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "CodeableConcept"
      }]
    },
    {
      "id" : "dk-referral-message.referral.packageCourse.packageName",
      "path" : "dk-referral-message.referral.packageCourse.packageName",
      "short" : "Pakkeforløbsnavn",
      "definition" : "Pakkeforløbsnavn",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.referral.treatmentPlan",
      "path" : "dk-referral-message.referral.treatmentPlan",
      "short" : "Behandlingsplan",
      "definition" : "Behandlingsplan",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "BackboneElement"
      }]
    },
    {
      "id" : "dk-referral-message.referral.treatmentPlan.requestedSessions",
      "path" : "dk-referral-message.referral.treatmentPlan.requestedSessions",
      "short" : "Antal sessioner",
      "definition" : "Antal sessioner",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "integer"
      }]
    },
    {
      "id" : "dk-referral-message.referral.treatmentPlan.remainingSessions",
      "path" : "dk-referral-message.referral.treatmentPlan.remainingSessions",
      "short" : "Resterende sessioner",
      "definition" : "Resterende sessioner",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "integer"
      }]
    },
    {
      "id" : "dk-referral-message.referral.treatmentPlan.treatmentFrequency",
      "path" : "dk-referral-message.referral.treatmentPlan.treatmentFrequency",
      "short" : "Behandlingsfrekvens",
      "definition" : "Behandlingsfrekvens",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.referral.attachments",
      "path" : "dk-referral-message.referral.attachments",
      "short" : "Bilag",
      "definition" : "Bilag",
      "min" : 0,
      "max" : "*",
      "type" : [{
        "code" : "BackboneElement"
      }],
      "mapping" : [{
        "identity" : "FHIRMapping",
        "map" : "DocumentReference"
      }]
    },
    {
      "id" : "dk-referral-message.referral.attachments.attachmentType",
      "path" : "dk-referral-message.referral.attachments.attachmentType",
      "short" : "Bilagstype",
      "definition" : "Bilagstype",
      "min" : 1,
      "max" : "1",
      "type" : [{
        "code" : "CodeableConcept"
      }]
    },
    {
      "id" : "dk-referral-message.referral.attachments.title",
      "path" : "dk-referral-message.referral.attachments.title",
      "short" : "Titel",
      "definition" : "Titel",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.referral.attachments.contentType",
      "path" : "dk-referral-message.referral.attachments.contentType",
      "short" : "MIME-type",
      "definition" : "MIME-type",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "code"
      }]
    },
    {
      "id" : "dk-referral-message.referral.attachments.url",
      "path" : "dk-referral-message.referral.attachments.url",
      "short" : "Reference til dokument",
      "definition" : "Reference til dokument",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "uri"
      }]
    },
    {
      "id" : "dk-referral-message.workflow",
      "path" : "dk-referral-message.workflow",
      "short" : "Workflow-information",
      "definition" : "Workflow-information",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "BackboneElement"
      }],
      "mapping" : [{
        "identity" : "FHIRMapping",
        "map" : "Task"
      }]
    },
    {
      "id" : "dk-referral-message.workflow.workflowStatus",
      "path" : "dk-referral-message.workflow.workflowStatus",
      "short" : "Workflowstatus",
      "definition" : "Workflowstatus",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "code"
      }]
    },
    {
      "id" : "dk-referral-message.workflow.referralReceived",
      "path" : "dk-referral-message.workflow.referralReceived",
      "short" : "Modtaget",
      "definition" : "Modtaget",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "boolean"
      }]
    },
    {
      "id" : "dk-referral-message.workflow.referralAccepted",
      "path" : "dk-referral-message.workflow.referralAccepted",
      "short" : "Accepteret",
      "definition" : "Accepteret",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "boolean"
      }]
    },
    {
      "id" : "dk-referral-message.workflow.referralRejected",
      "path" : "dk-referral-message.workflow.referralRejected",
      "short" : "Afvist",
      "definition" : "Afvist",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "boolean"
      }]
    },
    {
      "id" : "dk-referral-message.workflow.bookingStatus",
      "path" : "dk-referral-message.workflow.bookingStatus",
      "short" : "Bookingstatus",
      "definition" : "Bookingstatus",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "code"
      }]
    },
    {
      "id" : "dk-referral-message.provenance",
      "path" : "dk-referral-message.provenance",
      "short" : "Sporbarhed",
      "definition" : "Sporbarhed",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "BackboneElement"
      }],
      "mapping" : [{
        "identity" : "FHIRMapping",
        "map" : "Provenance"
      }]
    },
    {
      "id" : "dk-referral-message.provenance.createdBy",
      "path" : "dk-referral-message.provenance.createdBy",
      "short" : "Oprettet af",
      "definition" : "Oprettet af",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.provenance.createdOrganization",
      "path" : "dk-referral-message.provenance.createdOrganization",
      "short" : "Oprettende organisation",
      "definition" : "Oprettende organisation",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "string"
      }]
    },
    {
      "id" : "dk-referral-message.provenance.lastUpdated",
      "path" : "dk-referral-message.provenance.lastUpdated",
      "short" : "Senest opdateret",
      "definition" : "Senest opdateret",
      "min" : 0,
      "max" : "1",
      "type" : [{
        "code" : "dateTime"
      }]
    }]
  }
}

```
