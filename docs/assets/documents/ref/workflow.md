# Workflow - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* **Workflow**

## Workflow

## Eksempel på workflow for henvisning med afklaringsdialog

Nedenstående viser et logisk workflow, hvor en henvisning sendes fra en praktiserende læge til en hospitalsafdeling, men hvor manglende information medfører dialog og gensendelse af henvisningen.

Scenariet er modelleret med:

* `ServiceRequest` som henvisning
* `Task` som workflow-objekt
* `Communication` som dialogmeddelelser
* versionsstyring via `basedOn` / `replaces`
* statusændringer gennem workflowet

-------

# Logisk sekvensdiagram

```
Praktiserende læge
    |
    | ServiceRequest REF-001
    v
Kardiologisk afdeling
    |
    | Communication:
    | "Mangler EKG"
    v
Praktiserende læge
    |
    | ServiceRequest REF-002
    | replaces REF-001
    v
Kardiologisk afdeling
    |
    | Henvisning accepteres
    v
Booking / behandling

```

 ![](fhir_referral_messaging_flow.svg) 

-------

-------

# 1. Første henvisning sendes

```
Instance: Referral-001
InstanceOf: ServiceRequest
Usage: #example

* identifier.value = "REF-001"

* status = #active
* intent = #order

* subject.reference = "Patient/p1"

* requester.reference = "Practitioner/gp1"

* performer.reference = "Organization/cardiology-dept"

* code.text = "Henvisning til kardiologisk vurdering"

* reasonCode.text = "Brystsmerter"

* note.text = "Patient oplever intermitterende brystsmerter gennem 3 måneder"

```

-------

# 2. Modtager opretter Task til visitation

```
Instance: ReferralTask-001
InstanceOf: Task
Usage: #example

* status = #in-progress
* intent = #order

* focus.reference = "ServiceRequest/Referral-001"

* businessStatus.text = "Afventer visitation"

* owner.reference = "Organization/cardiology-dept"

```

-------

# 3. Modtager opdager manglende oplysninger

Kardiologisk afdeling mangler EKG-resultater og sender spørgsmål tilbage.

```
Instance: ClarificationRequest-001
InstanceOf: Communication
Usage: #example

* status = #completed

* subject.reference = "Patient/p1"

* about.reference = "ServiceRequest/Referral-001"

* sender.reference = "Organization/cardiology-dept"

* recipient.reference = "Practitioner/gp1"

* payload.contentString =
    "Henvisningen mangler aktuelt EKG samt oplysninger om tidligere hjertesygdom."

```

-------

# 4. Workflowstatus ændres

```
Instance: ReferralTask-001-NeedInfo
InstanceOf: Task
Usage: #example

* basedOn.reference = "Task/ReferralTask-001"

* status = #on-hold

* businessStatus.text = "Afventer yderligere kliniske oplysninger"

```

-------

# 5. Praktiserende læge opdaterer henvisningen

Henvisningen opdateres med yderligere oplysninger.

```
Instance: Referral-002
InstanceOf: ServiceRequest
Usage: #example

* replaces.reference = "ServiceRequest/Referral-001"

* status = #active
* intent = #order

* subject.reference = "Patient/p1"

* requester.reference = "Practitioner/gp1"

* performer.reference = "Organization/cardiology-dept"

* code.text = "Henvisning til kardiologisk vurdering"

* reasonCode.text = "Brystsmerter"

* note[0].text =
    "Patient oplever intermitterende brystsmerter gennem 3 måneder"

* note[1].text =
    "EKG viser sinusrytme med enkelte ventrikulære ekstrasystoler"

* supportingInfo.reference = "Observation/EKG-001"

```

-------

# 6. Praktiserende læge svarer via Communication

```
Instance: ClarificationResponse-001
InstanceOf: Communication
Usage: #example

* status = #completed

* subject.reference = "Patient/p1"

* about.reference = "ServiceRequest/Referral-002"

* sender.reference = "Practitioner/gp1"

* recipient.reference = "Organization/cardiology-dept"

* payload.contentString =
    "Opdateret henvisning vedlagt med EKG-oplysninger."

```

-------

# 7. Modtager accepterer henvisningen

```
Instance: ReferralTask-002
InstanceOf: Task
Usage: #example

* focus.reference = "ServiceRequest/Referral-002"

* status = #accepted

* businessStatus.text = "Henvisning accepteret"

* owner.reference = "Organization/cardiology-dept"

```

-------

# 8. Tid til booking

```
Instance: ReferralTask-003
InstanceOf: Task
Usage: #example

* basedOn.reference = "Task/ReferralTask-002"

* focus.reference = "ServiceRequest/Referral-002"

* status = #in-progress

* businessStatus.text = "Tid bestilles"

```

-------

# Centrale arkitekturmæssige pointer

## Henvisningen er ikke statisk

Henvisningen bliver et dynamisk workflow-objekt fremfor et statisk dokument.

-------

## Dialog kan modelleres eksplicit

FHIR giver mulighed for at modellere:

* spørgsmål
* præciseringer
* afvisninger
* visitation
* bookingdialog

via `Communication`.

-------

## Versionsstyring bliver vigtig

Opdaterede henvisninger bør ikke overskrive historik.

FHIR understøtter dette via:

```
ServiceRequest.replaces

```

eller:

```
Provenance

```

-------

## Workflow kan spores nationalt

Task gør det muligt at følge:

* visitation
* ventetid
* afklaringsrunder
* bookingstatus
* behandlingsstatus

på tværs af organisationer.

-------

# Potentiel EHMI-anvendelse

I EHMI kunne ovenstående udveksles som:

```
FHIR Messaging

```

eller hybridt:

```
Messaging for formel kommunikation
API for workflowopslag

```

Dette giver langt stærkere workflowunderstøttelse end klassiske MedCom XML-meddelelser.

