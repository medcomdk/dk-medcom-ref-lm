# Fhir Henvisning Messaging Cgpt - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* **Fhir Henvisning Messaging Cgpt**

## Fhir Henvisning Messaging Cgpt

## FHIR Messaging for Henvisningshåndtering

Dette dokument beskriver en FHIR Messaging-baseret model for henvisningshåndtering.

### REF-001 – Opret henvisning

 ![](fhir-messaging-diagrams-0.svg) 

**Beskrivelse**

Henviser -> EHMI : REF-001 EHMI -> Visitator

### REF-002 – Supplerende dokumentation

 ![](fhir-messaging-diagrams-1.svg) 

**Beskrivelse**

Henviser -> EHMI : REF-002 EHMI -> Visitator

### REF-003 – Anmodning om supplerende oplysninger

 ![](fhir-messaging-diagrams-2.svg) 

**Beskrivelse**

Visitator -> EHMI : REF-003 EHMI -> Henviser

### REF-004 – Besvarelse af anmodning

 ![](fhir-messaging-diagrams-3.svg) 

**Beskrivelse**

Henviser -> EHMI : REF-004 EHMI -> Visitator

### REF-005 – Accept af henvisning

Accept af henvisning

**Beskrivelse**

Visitator -> EHMI : REF-005 EHMI -> Henviser

### REF-006 – Booking gennemført

Booking gennemført

**Beskrivelse**

Visitator -> EHMI : REF-006 EHMI -> Henviser

### REF-007 – Afvisning

 ![](fhir-messaging-diagrams-6.svg) 

**Beskrivelse**

Visitator -> EHMI : REF-007 EHMI -> Henviser

### REF-008 – Videresendelse

 ![](fhir-messaging-diagrams-7.svg) 

**Beskrivelse**

Visitator -> EHMI : REF-008 EHMI -> Ny Visitator

### REF-009 – Statusopdatering

 ![](fhir-messaging-diagrams-8.svg) 

**Beskrivelse**

Visitator -> EHMI : REF-009 EHMI -> Henviser

### REF-010 – Faglig dialog

 ![](fhir-messaging-diagrams-9.svg) 

**Beskrivelse**

Visitator <-> Henviser via EHMI

### REF-011 – Alternativ visitation

 ![](fhir-messaging-diagrams-10.svg) 

**Beskrivelse**

Visitator <-> Henviser via EHMI

### REF-012 – Korrektion

 ![](fhir-messaging-diagrams-11.svg) 

**Beskrivelse**

Visitator -> Henviser -> Visitator via EHMI

