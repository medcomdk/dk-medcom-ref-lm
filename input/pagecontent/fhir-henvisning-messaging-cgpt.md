## FHIR Messaging for Henvisningshåndtering

Dette dokument beskriver en FHIR Messaging-baseret model for
henvisningshåndtering.

### REF-001 -- Opret henvisning

<p style="display: block;">
<img src="fhir-messaging-diagrams-0.svg" alt="Opret henvisning" width="30%" style="margin-top: 10px; margin-left: 0%; margin-right: 70%;">
</p>
<br/><br/><br/>

**Beskrivelse**

Henviser -\> EHMI : REF-001 EHMI -\> Visitator

### REF-002 -- Supplerende dokumentation

<p style="display: block;">
<img src="fhir-messaging-diagrams-1.svg" alt="Supplerende dokumentation" width="30%" style="margin-top: 10px; margin-left: 0%; margin-right: 70%;">
</p>
<br/><br/><br/>

**Beskrivelse**

Henviser -\> EHMI : REF-002 EHMI -\> Visitator

### REF-003 -- Anmodning om supplerende oplysninger

<p style="display: block;">
<img src="fhir-messaging-diagrams-2.svg" alt="Anmodning om supplerende oplysninger" width="30%" style="margin-top: 10px; margin-left: 0%; margin-right: 70%;">
</p>
<br clear="all"/>

**Beskrivelse**

Visitator -\> EHMI : REF-003 EHMI -\> Henviser

### REF-004 -- Besvarelse af anmodning

<p style="display: block;">
<img src="fhir-messaging-diagrams-3.svg" alt="Besvarelse af anmodning" width="30%" style="margin-top: 10px; margin-left: 0%; margin-right: 70%;">
</p>
<br/><br/><br/>

**Beskrivelse**

Henviser -\> EHMI : REF-004 EHMI -\> Visitator

### REF-005 -- Accept af henvisning

Accept af henvisning

<p style="display: block;">
<img src="fhir-messaging-diagrams-4.svg" alt="" width="30%" style="margin-top: 10px; margin-left: 0%; margin-right: 70%;">
</p>
<br/><br/><br/>

**Beskrivelse**

Visitator -\> EHMI : REF-005 EHMI -\> Henviser

### REF-006 -- Booking gennemført

Booking gennemført

<p style="display: block;">
<img src="fhir-messaging-diagrams-5.svg" alt="" width="30%" style="margin-top: 10px; margin-left: 0%; margin-right: 70%;">
</p>
<br/><br/><br/>

**Beskrivelse**

Visitator -\> EHMI : REF-006 EHMI -\> Henviser

### REF-007 -- Afvisning

<p style="display: block;">
<img src="fhir-messaging-diagrams-6.svg" alt="Afvisning" width="30%" style="margin-top: 10px; margin-left: 0%; margin-right: 70%;">
</p>
<br/><br/><br/>

**Beskrivelse**

Visitator -\> EHMI : REF-007 EHMI -\> Henviser

### REF-008 -- Videresendelse

<p style="display: block;">
<img src="fhir-messaging-diagrams-7.svg" alt="Videresendelse" width="30%" style="margin-top: 10px; margin-left: 0%; margin-right: 70%;">
</p>
<br/><br/><br/>

**Beskrivelse**

Visitator -\> EHMI : REF-008 EHMI -\> Ny Visitator

### REF-009 -- Statusopdatering

<p style="display: block;">
<img src="fhir-messaging-diagrams-8.svg" alt="Statusopdatering" width="30%" style="margin-top: 10px; margin-left: 0%; margin-right: 70%;">
</p>
<br/><br/><br/>

**Beskrivelse**

Visitator -\> EHMI : REF-009 EHMI -\> Henviser

### REF-010 -- Faglig dialog

<p style="display: block;">
<img src="fhir-messaging-diagrams-9.svg" alt="Faglig dialog" width="30%" style="margin-top: 10px; margin-left: 0%; margin-right: 70%;">
</p>
<br/><br/><br/>

**Beskrivelse**

Visitator \<-\> Henviser via EHMI

### REF-011 -- Alternativ visitation

<p style="display: block;">
<img src="fhir-messaging-diagrams-10.svg" alt="Alternativ visitation" width="30%" style="margin-top: 10px; margin-left: 0%; margin-right: 70%;">
</p>
<br/><br/><br/>

**Beskrivelse**

Visitator \<-\> Henviser via EHMI

### REF-012 -- Korrektion

<p style="display: block;">
<img src="fhir-messaging-diagrams-11.svg" alt="Korrektion" width="30%" style="margin-top: 10px; margin-left: 0%; margin-right: 70%;">
</p>
<br/><br/><br/>

**Beskrivelse**

Visitator -\> Henviser -\> Visitator via EHMI
