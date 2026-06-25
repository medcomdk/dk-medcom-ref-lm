# FHIR Messaging for Henvisningshåndtering

## Arkitekturprincip

Alle udvekslinger sker som FHIR Message Bundles via EHMI. 

## Meddelelseskatalog 

### Henvisning ID=1-version=01 -- Opret henvisning 

**Fokusressource:**
`ServiceRequest`

**Trigger:** Henviser beslutter at henvise patient.

**Ressourcer:** - `Bundle` - `MessageHeader` - `ServiceRequest` -
`Patient` - `Practitioner` - `Organization`

![Opret henvisning](fhir-henvisning-messaging-1.svg)
<br clear="all"/>

### Henvisning ID=1-version=02 -- Supplerende dokumentation

**Fokusressource:** `DocumentReference`

**Trigger:** Henviser fremsender yderligere materiale.

**Ressourcer:** - `Bundle` - `MessageHeader` - `DocumentReference` -
`DiagnosticReport` - `Media`

![Supplerende dokumentation](fhir-henvisning-messaging-2.svg)
<br clear="all"/>

### Henvisning ID=1-version=03 -- Anmodning om supplerende oplysninger

**Fokusressource:** `CommunicationRequest`

**Trigger:** Visitator mangler oplysninger.

**Ressourcer:** - `Bundle` - `MessageHeader` - `CommunicationRequest`

![Anmodning om supplerende oplysninger](fhir-henvisning-messaging-3.svg)
<br clear="all"/>

### Henvisning ID=1-version=04 -- Besvarelse af anmodning

**Fokusressource:** `Communication`

**Trigger:** Henviser besvarer anmodning.

**Ressourcer:** - `Bundle` - `MessageHeader` - `Communication`

![Besvarelse af anmodning](fhir-henvisning-messaging-4.svg)
<br clear="all"/>

### Henvisning ID=1-version=05 -- Accept af henvisning

**Fokusressource:** `Task`

**Trigger:** Visitator accepterer henvisning.

**Ressourcer:** - `Bundle` - `MessageHeader` - `Task`

![Accept af henvisning](fhir-henvisning-messaging-5.svg)
<br clear="all"/>

### Henvisning ID=1-version=06 -- Booking gennemført

**Fokusressource:** `Appointment`

**Trigger:** Tid er booket.

**Ressourcer:** - `Bundle` - `MessageHeader` - `Appointment`

![Booking gennemført](fhir-henvisning-messaging-6.svg)
<br clear="all"/>

### Henvisning ID=1-version=07 -- Afvisning

**Fokusressource:** `Task`

**Trigger:** Henvisningen afvises.

**Ressourcer:** - `Bundle` - `MessageHeader` - `Task`

![Afvisning](fhir-henvisning-messaging-7.svg)
<br clear="all"/>

### Henvisning ID=1-version=08 -- Videresendelse

**Fokusressource:** `ServiceRequest`

**Trigger:** Henvisning videresendes.

**Ressourcer:** - `Bundle` - `MessageHeader` - `ServiceRequest`

![Videresendelse](fhir-henvisning-messaging-8.svg)
<br clear="all"/>

### Henvisning ID=1-version=09 -- Statusopdatering

**Fokusressource:** `Task`

**Trigger:** Status ændres.

**Ressourcer:** - `Bundle` - `MessageHeader` - `Task`

![Statusopdatering](fhir-henvisning-messaging-9.svg)
<br clear="all"/>

### Henvisning ID=1-version=10 -- Faglig dialog

**Fokusressource:** `Communication`

**Trigger:** Behov for dialog.

**Ressourcer:** - `Bundle` - `MessageHeader` - `Communication`

![Faglig dialog](fhir-henvisning-messaging-10.svg)
<br clear="all"/>

### Henvisning ID=1-version=11 -- Alternativ visitation

**Fokusressource:** `Communication`

**Trigger:** Forslag om alternativ visitation.

**Ressourcer:** - `Bundle` - `MessageHeader` - `Communication`

![Alternativ visitation](fhir-henvisning-messaging-11.svg)
<br clear="all"/>

### Henvisning ID=1-version=12 -- Korrektion

**Fokusressource:** `ServiceRequest`

**Trigger:** Korrigering af henvisning.

**Ressourcer:** - `Bundle` - `MessageHeader` - `ServiceRequest`

![Korrektion](fhir-henvisning-messaging-12.svg)
