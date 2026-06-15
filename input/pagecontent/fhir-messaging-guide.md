# FHIR Messaging for Henvisningshåndtering

## Arkitekturprincip

Alle udvekslinger sker som FHIR Message Bundles via EHMI. \##
Meddelelseskatalog \## REF-001 -- Opret henvisning **Fokusressource:**
`ServiceRequest`

**Trigger:** Henviser beslutter at henvise patient.

**Ressourcer:** - `Bundle` - `MessageHeader` - `ServiceRequest` -
`Patient` - `Practitioner` - `Organization`

![Opret henvisning](svg/ref001-create.svg)

## REF-002 -- Supplerende dokumentation

**Fokusressource:** `DocumentReference`

**Trigger:** Henviser fremsender yderligere materiale.

**Ressourcer:** - `Bundle` - `MessageHeader` - `DocumentReference` -
`DiagnosticReport` - `Media`

![Supplerende dokumentation](svg/ref002-supplement.svg)

## REF-003 -- Anmodning om supplerende oplysninger

**Fokusressource:** `CommunicationRequest`

**Trigger:** Visitator mangler oplysninger.

**Ressourcer:** - `Bundle` - `MessageHeader` - `CommunicationRequest`

![Anmodning om supplerende oplysninger](svg/ref003-request.svg)

## REF-004 -- Besvarelse af anmodning

**Fokusressource:** `Communication`

**Trigger:** Henviser besvarer anmodning.

**Ressourcer:** - `Bundle` - `MessageHeader` - `Communication`

![Besvarelse af anmodning](svg/ref004-response.svg)

## REF-005 -- Accept af henvisning

**Fokusressource:** `Task`

**Trigger:** Visitator accepterer henvisning.

**Ressourcer:** - `Bundle` - `MessageHeader` - `Task`

![Accept af henvisning](svg/ref005-accept.svg)

## REF-006 -- Booking gennemført

**Fokusressource:** `Appointment`

**Trigger:** Tid er booket.

**Ressourcer:** - `Bundle` - `MessageHeader` - `Appointment`

![Booking gennemført](svg/ref006-booking.svg)

## REF-007 -- Afvisning

**Fokusressource:** `Task`

**Trigger:** Henvisningen afvises.

**Ressourcer:** - `Bundle` - `MessageHeader` - `Task`

![Afvisning](svg/ref007-reject.svg)

## REF-008 -- Videresendelse

**Fokusressource:** `ServiceRequest`

**Trigger:** Henvisning videresendes.

**Ressourcer:** - `Bundle` - `MessageHeader` - `ServiceRequest`

![Videresendelse](svg/ref008-forward.svg)

## REF-009 -- Statusopdatering

**Fokusressource:** `Task`

**Trigger:** Status ændres.

**Ressourcer:** - `Bundle` - `MessageHeader` - `Task`

![Statusopdatering](svg/ref009-status.svg)

## REF-010 -- Faglig dialog

**Fokusressource:** `Communication`

**Trigger:** Behov for dialog.

**Ressourcer:** - `Bundle` - `MessageHeader` - `Communication`

![Faglig dialog](svg/ref010-dialog.svg)

## REF-011 -- Alternativ visitation

**Fokusressource:** `Communication`

**Trigger:** Forslag om alternativ visitation.

**Ressourcer:** - `Bundle` - `MessageHeader` - `Communication`

![Alternativ visitation](svg/ref011-alternative.svg)

## REF-012 -- Korrektion

**Fokusressource:** `ServiceRequest`

**Trigger:** Korrigering af henvisning.

**Ressourcer:** - `Bundle` - `MessageHeader` - `ServiceRequest`

![Korrektion](svg/ref012-correction.svg)
