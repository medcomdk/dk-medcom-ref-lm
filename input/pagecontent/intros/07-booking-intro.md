# Entitet: Booking

**FSH LogicalModel:** `EhmiLmBooking`
**Primær FHIR-ressource:** `Appointment`
**User stories:** 2.3

---

## Beskrivelse

`Booking` repræsenterer en aftalt tid der oprettes af visitatoren som
direkte konsekvens af en positiv visitationsafgørelse. Bookingen knyttes
til den accept-givne Henvisning og notificerer automatisk patienten og
henviseren om det aftalte tidspunkt.

---

## Attributter

| Attribut | Kardinalitet | Type | Beskrivelse |
|---|---|---|---|
| `bookingId` | 1..1 | Identifier | Unik identifikator for bookingen |
| `status` | 1..1 | code | `proposed` · `booked` · `arrived` · `fulfilled` · `cancelled` |
| `tidspunkt` | 1..1 | dateTime | Det aftalte tidspunkt |
| `varighed` | 0..1 | Duration | Forventet varighed i minutter |
| `fremmoedeType` | 0..1 | CodeableConcept | `fysisk` · `telefonisk` · `video` |
| `lokation` | 0..1 | Reference(Organisation) | Sted for fremmøde |
| `patient` | 1..1 | Reference(Patient) | Patienten der har fået tid |
| `relatertHenvisning` | 1..1 | Reference(Henvisning) | Den henvisning der har udløst bookingen |

---

## FHIR-mapping

| Logisk attribut | FHIR-element | Kommentar |
|---|---|---|
| `bookingId` | `Appointment.identifier` | |
| `status` | `Appointment.status` | Bundet til `appointmentstatus` (required) |
| `tidspunkt` | `Appointment.start` | |
| `varighed` | `Appointment.minutesDuration` | |
| `fremmoedeType` | `Appointment.appointmentType` | |
| `lokation` | `Appointment.participant` | `actor` = Location/Organization |
| `patient` | `Appointment.participant` | `actor` = Patient, `required` = required |
| `relatertHenvisning` | `Appointment.basedOn` | Reference til ServiceRequest |

---

## Relaterede entiteter

- **[Henvisning](01-henvisning.html)** — bookingen er resultatet af en accepteret henvisning
- **[Patient](02-patient.html)** — patienten der har fået tid
- **[Organisation](04-organisation.html)** — stedet for fremmøde
- **[Visitationsafgoerelse](06-visitationsafgoerelse.html)** — accept-afgørelsen udløser booking


---

## User stories


### Visitatorens user stories


### User story 2.3 Acceptere en henvisning og booke forløb

> **User story:** Som visitator ønsker jeg at kunne acceptere en henvisning og oprette en booking, <br/>når min visitationsafgørelse er positiv, <br/>så patienten får en tid og henviseren automatisk modtager bekræftelsen.

<p style="display: block;">
<img src="UC-2-3-Acceptere-booke.svg" alt="UC-2-3" width="65%" style="margin-top: 10px; margin-left: 0%; margin-right: 35%;">
</p>
<br clear="all"/>

Visitatoren accepterer henvisningen og opretter et forløb. Der bookes en tid, og `ServiceRequest`-status opdateres til `active`. En `Appointment`-ressource oprettes og linkes til henvisningen.

|---|---|
| **Primær FHIR-ressource:** | `ServiceRequest` (active), `Appointment` (booked) |
| **Triggerhændelse:** | Positiv visitationsafgørelse |
| **Forrige trin:** | ← [2.2 Triagere og prioritere](#user-story-22-triagere-og-prioritere-en-henvisning) *(positiv afgørelse)* · <br/>← [3.5 Alternativ visitation](#35-aftale-om-alternativ-visitation) *(alternativt tilbud accepteres)* · <br/>← [3.3 Faglig afklaring](#user-story-33-faglig-afklaring-i-dialog) *(afklaring munder ud i accept)* |
| **Næste trin:** | → [3.4 Statusnotifikation til henviser](#34-statusnotifikation-til-henviser) *(henviser notificeres om accept og booking)* |
{: .grid}
