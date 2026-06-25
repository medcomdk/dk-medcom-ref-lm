# 07 Booking - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* **07 Booking**

## 07 Booking

# Entitet: Booking

**FSH LogicalModel:** `EhmiLmBooking` **Primær FHIR-ressource:** `Appointment` **User stories:** 2.3

-------

## Beskrivelse

`Booking` repræsenterer en aftalt tid der oprettes af visitatoren som direkte konsekvens af en positiv visitationsafgørelse. Bookingen knyttes til den accept-givne Henvisning og notificerer automatisk patienten og henviseren om det aftalte tidspunkt.

-------

## Attributter

| | | | |
| :--- | :--- | :--- | :--- |
| `bookingId` | 1..1 | Identifier | Unik identifikator for bookingen |
| `status` | 1..1 | code | `proposed`·`booked`·`arrived`·`fulfilled`·`cancelled` |
| `tidspunkt` | 1..1 | dateTime | Det aftalte tidspunkt |
| `varighed` | 0..1 | Duration | Forventet varighed i minutter |
| `fremmoedeType` | 0..1 | CodeableConcept | `fysisk`·`telefonisk`·`video` |
| `lokation` | 0..1 | Reference(Organisation) | Sted for fremmøde |
| `patient` | 1..1 | Reference(Patient) | Patienten der har fået tid |
| `relatertHenvisning` | 1..1 | Reference(Henvisning) | Den henvisning der har udløst bookingen |

-------

## FHIR-mapping

| | | |
| :--- | :--- | :--- |
| `bookingId` | `Appointment.identifier` |   |
| `status` | `Appointment.status` | Bundet til`appointmentstatus`(required) |
| `tidspunkt` | `Appointment.start` |   |
| `varighed` | `Appointment.minutesDuration` |   |
| `fremmoedeType` | `Appointment.appointmentType` |   |
| `lokation` | `Appointment.participant` | `actor`= Location/Organization |
| `patient` | `Appointment.participant` | `actor`= Patient,`required`= required |
| `relatertHenvisning` | `Appointment.basedOn` | Reference til ServiceRequest |

-------

## Relaterede entiteter

* **[Henvisning](StructureDefinition-ehmi-lm-henvisning.md)** — bookingen er resultatet af en accepteret henvisning
* **[Patient](StructureDefinition-ehmi-lm-patient.md)** — patienten der har fået tid
* **[Organisation](StructureDefinition-ehmi-lm-organisation.md)** — stedet for fremmøde
* **[Visitationsafgoerelse](StructureDefinition-ehmi-lm-visitationsafgoerelse.md)** — accept-afgørelsen udløser booking

