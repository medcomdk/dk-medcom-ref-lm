/*
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


/*
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
*/