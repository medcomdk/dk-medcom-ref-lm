// ╔══════════════════════════════════════════════════════════════════════╗
// ║  ReferralCommunication.fsh                                          ║
// ║  FHIR Shorthand (FSH) — logisk model for Communication             ║
// ║  brugt til supplerende informationsforespørgsel i et               ║
// ║  EHMI/FHIR-baseret henvisningsflow                                 ║
// ║                                                                      ║
// ║  Profil:   DkReferralInfoRequestCommunication                       ║
// ║  Instans:  ReferralInfoRequestExample                               ║
// ║  Basis:    HL7 FHIR R4 Communication                                ║
// ║  Kontekst: MedCom FHIR / HL7 Denmark                               ║
// ╚══════════════════════════════════════════════════════════════════════╝


// ──────────────────────────────────────────────────────────────────────
// ALIAS-ERKLÆRINGER
// Aliasser holder FSH-koden læsbar og undgår gentagelse af lange URLs.
// ──────────────────────────────────────────────────────────────────────

Alias: $SCT           = http://snomed.info/sct
Alias: $LOINC         = http://loinc.org
Alias: $commCat       = http://terminology.hl7.org/CodeSystem/communication-category
Alias: $MedComCS      = http://medcomfhir.dk/ig/terminology/CodeSystem/medcom-referral-communication-category
Alias: $MedComVS      = http://medcomfhir.dk/ig/terminology/ValueSet/medcom-referral-communication-category
Alias: $SOR           = urn:oid:1.2.208.176.1.1
Alias: $CPR           = urn:oid:1.2.208.176.1.2
Alias: $AuthID        = urn:oid:1.2.208.176.1.3


// ──────────────────────────────────────────────────────────────────────
// CODESYSTEM
// Nationalt MedCom-specifikt codesystem til Communication.category.
// I en rigtig IG ville dette leve i et separat CodeSystem-artefakt;
// det er her samlet for overblikkets skyld.
// ──────────────────────────────────────────────────────────────────────

CodeSystem: MedComReferralCommunicationCategoryCS
Id:         medcom-referral-communication-category
Title:      "MedCom Referral Communication Category Codes"
Description: """
  Koder der klassificerer formålet med en Communication-ressource
  i et FHIR-baseret henvisningsflow.

  Disse koder supplerer HL7's generiske communication-category med
  domænespecifik semantik for det danske sundhedsvæsen.
"""
* #referral-info-request
    """Anmodning om supplerende kliniske oplysninger
    Meddelelse fra modtager til afsender der efterspørger yderligere
     klinisk dokumentation eller undersøgelsesresultater, som er
     nødvendige for at kunne prioritere eller acceptere en henvisning."""
* #referral-info-response
    """Svar med supplerende kliniske oplysninger
    Meddelelse fra afsender til modtager der indeholder de
     efterspurgte supplerende oplysninger som svar på en
     referral-info-request."""
* #referral-administrative
    """Administrativ meddelelse vedrørende en henvisning
    Administrativ kommunikation der ikke bærer klinisk indhold,
     f.eks. ændring af kontaktinformation eller tidsangivelse."""


// ──────────────────────────────────────────────────────────────────────
// VALUESET
// Binder de tilladte category-koder for denne profil.
// ──────────────────────────────────────────────────────────────────────

ValueSet:   MedComReferralCommunicationCategoryVS
Id:         medcom-referral-communication-category
Title:      "MedCom Referral Communication Category Value Set"
Description: """
  Tilladt sæt af kategorikoder for Communication-ressourcer
  i et FHIR-baseret EHMI-henvisningsflow.
"""
* include $MedComCS#referral-info-request
* include $MedComCS#referral-info-response
* include $MedComCS#referral-administrative


// ──────────────────────────────────────────────────────────────────────
// PROFIL: DkReferralInfoRequestCommunication
//
// Beskriver en Communication-ressource der bruges af en modtagende
// enhed til at efterspørge supplerende kliniske oplysninger hos
// en afsendende enhed i forbindelse med behandling af en henvisning.
//
// Centrale designvalg:
//   • basedOn binder Communication til den konkrete ServiceRequest
//   • about binder Communication til den relevante Task-instans
//   • payload kan bære fritekst OG/ELLER strukturerede referencer
//   • sender og recipient er eksplicitte organisatoriske parter
// ──────────────────────────────────────────────────────────────────────

Profile:    DkReferralInfoRequestCommunication
Parent:     Communication
Id:         dk-referral-info-request-communication
Title:      "DK Referral Info Request Communication"
Description: """
  Profil på FHIR R4 Communication til brug ved efterspørgsel af
  supplerende kliniske oplysninger i et EHMI/FHIR-baseret
  henvisningsflow.

  Ressourcen sendes som del af et FHIR message-Bundle med
  MessageHeader.eventCoding = referral-info-request.

  Profilen er baseret på MedCom FHIR-konventioner og
  HL7 Denmark-profiler.
"""

// ── Metadata ──────────────────────────────────────────────────────────

* ^status                     = #active
* ^version                    = "1.0.0"
* ^date                       = "2024-03-01"
* ^publisher                  = "MedCom / HL7 Denmark"
* ^jurisdiction               = urn:iso:std:iso:3166#DK "Denmark"
* ^purpose = """
  Understøtte struktureret udveksling af forespørgsler om supplerende
  kliniske oplysninger mellem sundhedsaktører via EHMI-infrastrukturen.
"""


// ── Identifikator ─────────────────────────────────────────────────────

* identifier    1..* MS
* identifier    ^short  = "Unik identifikator for denne kommunikation"
* identifier    ^comment = """
  Skal bære mindst én identifikator som gør det muligt for
  modtager at referere til denne Communication i et svar.
  Typisk et UUID udstedt af afsender-systemet.
"""

* identifier.system 1..1 MS
* identifier.value  1..1 MS


// ── Status ────────────────────────────────────────────────────────────

* status        1..1 MS
* status        = #completed
* status        ^short  = "Fast: completed — forespørgslen er afsendt"
* status        ^comment = """
  En Communication af typen referral-info-request sættes altid til
  'completed' ved afsendelse, da den udgør en fuldt formuleret og
  transmitteret forespørgsel. Livscyklusstyring sker via Task,
  ikke via Communication.status.
"""


// ── Category ──────────────────────────────────────────────────────────

* category      1..1 MS
* category      from MedComReferralCommunicationCategoryVS (required)
* category      ^short  = "Kategori: referral-info-request"
* category      ^comment = """
  Skal sættes til referral-info-request for denne profil.
  Koden adskiller forespørgslen fra svar (referral-info-response)
  og administrative meddelelser.
"""

* category.coding           1..* MS
* category.coding.system    1..1 MS
* category.coding.code      1..1 MS


// ── Prioritet ─────────────────────────────────────────────────────────

* priority      0..1 MS
* priority      ^short  = "Haster-angivelse for informationsforespørgslen"
* priority      ^comment = """
  Brug 'urgent' hvis manglende oplysninger blokerer for akut
  behandling. Standard er 'routine'.
"""


// ── Subject ───────────────────────────────────────────────────────────

* subject       1..1 MS
* subject       only Reference(Patient)
* subject       ^short  = "Den patient som henvisningen vedrører"
* subject       ^comment = """
  Reference til Patient-ressourcen. Skal anvende dansk CPR-nummer
  (OID: 1.2.208.176.1.2) som primær identifikator i Patient.identifier.
"""


// ── Timing ────────────────────────────────────────────────────────────

* sent          1..1 MS
* sent          ^short  = "Afsendelsestidspunkt (UTC)"
* sent          ^comment = """
  Systemtidsstempel for hvornår forespørgslen blev afsendt.
  Skal angives i UTC (Z-suffix).
"""

* received      0..1 MS
* received      ^short  = "Tidspunkt for kvittering fra modtager"


// ── Sender ────────────────────────────────────────────────────────────

* sender        1..1 MS
* sender        only Reference(Organization or PractitionerRole)
* sender        ^short  = "Modtagende enhed som sender forespørgslen"
* sender        ^comment = """
  Den organisation (typisk hospitalsafdeling eller speciallægepraksis)
  der modtog den oprindelige henvisning og nu efterspørger oplysninger.
  Skal referere til en Organization med gyldig SOR-kode.
"""


// ── Recipient ─────────────────────────────────────────────────────────

* recipient     1..* MS
* recipient     only Reference(PractitionerRole or Organization)
* recipient     ^short  = "Afsendende enhed (den der skal svare)"
* recipient     ^comment = """
  Den praktiserende læge, speciallæge eller organisation der
  sendte den ursprunglige henvisning og nu skal levere de
  efterspurgte oplysninger.
"""


// ── Relationer til ServiceRequest og Task ────────────────────────────

* basedOn       1..1 MS
* basedOn       only Reference(ServiceRequest)
* basedOn       ^short  = "Den henvisning forespørgslen relaterer sig til"
* basedOn       ^comment = """
  PÅKRÆVET reference til den ServiceRequest der er genstand for
  forespørgslen. ServiceRequest.identifier skal benyttes til
  matching på tværs af systemer.
  Alle Communications i samme forløb skal pege på samme ServiceRequest.
"""

* about         0..* MS
* about         only Reference(Task)
* about         ^short  = "Den procesopgave der er sat på hold"
* about         ^comment = """
  Reference til Task-ressourcen hos modtager, der har status
  'on-hold' mens forespørgslen afventer svar. Giver mulighed for
  at koble forespørgslen direkte til statusstyringen.
"""


// ── Payload ───────────────────────────────────────────────────────────

* payload       1..* MS
* payload       ^short  = "Indhold: fritekst og/eller dokumentreferencer"
* payload       ^comment = """
  Payload bør indeholde mindst ét contentString-element med en
  klinisk begrundelse på dansk for hvad der efterspørges og
  hvorfor det er nødvendigt for behandling af henvisningen.

  Yderligere payload-elementer kan referere til:
    • Questionnaire (struktureret indholdsskema)
    • DocumentReference (specifikt ønsket dokument)
    • ActivityDefinition (procedurekrav)
"""

* payload.content[x]   1..1 MS

// Første payload-element: obligatorisk fritekstbegrundelse
* payload ^slicing.discriminator.type  = #type
* payload ^slicing.discriminator.path  = "content[x]"
* payload ^slicing.rules               = #open
* payload ^slicing.description = """
  Payload skives i to slices:
    [0] textContent   — obligatorisk fritekstbegrundelse (contentString)
    [n] docReference  — valgfrie dokumentreferencer (contentReference)
"""

* payload contains
    textContent  1..1 MS and
    docReference 0..* MS

* payload[textContent].contentString    1..1
* payload[textContent]                  ^short = "Klinisk fritekstbegrundelse"
* payload[textContent]                  ^comment = """
  Menneskelig, klinisk formuleret tekst der forklarer:
    1. Præcist hvilke oplysninger der efterspørges
    2. Hvad de konkret skal bruges til i visitationsprocessen
  Sproget skal være dansk. Maks. anbefalet længde: 500 tegn.
"""

* payload[docReference].contentReference only Reference(DocumentReference or Questionnaire)
* payload[docReference]                   ^short = "Reference til ønsket eller vedlagt dokument"
* payload[docReference]                   ^comment = """
  Kan pege på:
    • Et specifikt DocumentReference der ønskes fremsendt
    • En Questionnaire der ønskes udfyldt af afsender
"""


// ── Noten ─────────────────────────────────────────────────────────────

* note          0..* MS
* note          ^short  = "Interne noter fra visitator"
* note          ^comment = """
  Interne noter til eget system. Vil typisk ikke videresendes
  til afsender, men kan bruges til intern dokumentation af
  visitationsbeslutningen.
"""


// ──────────────────────────────────────────────────────────────────────
// INSTANS: ReferralInfoRequestExample
//
// Et komplet eksempel på en Communication-instans der efterspørger
// HbA1c-svar og øjenspejlingsresultat forud for accept af en
// diabetes-relateret øjenspecialist-henvisning.
// ──────────────────────────────────────────────────────────────────────

Instance:   ReferralInfoRequestExample
InstanceOf: DkReferralInfoRequestCommunication
Title:      "Eksempel: Forespørgsel om HbA1c og øjenspejling"
Description: """
  Modtager (Øjenafdelingen, Rigshospitalet) efterspørger to
  manglende kliniske elementer hos afsender (alment praktiserende
  læge) forud for endelig accept af en diabetes-øjenhenvisning:

    1. Seneste HbA1c (maks. 3 måneder gammelt)
    2. Seneste øjenspejlingsresultat

  Task hos modtager er sat til status 'on-hold' med reason
  'info-needed' mens forespørgslen afventer svar.
"""

* identifier[+].system  = "urn:ietf:rfc:3986"
* identifier[=].value   = "urn:uuid:b7e3c1a2-84f2-4d9e-9c1a-2f8e3b7c4d5e"

// Status: afsendt og komplet
* status                = #completed

// Kategori: dette er en informationsforespørgsel
* category[+].coding[+].system  = $MedComCS
* category[=].coding[=].code    = #referral-info-request
* category[=].coding[=].display = "Anmodning om supplerende kliniske oplysninger"

// Prioritet: rutine (ikke akut)
* priority              = #routine

// Afsendelsestidspunkt
* sent                  = "2024-03-15T10:42:00Z"

// Patient
* subject               = Reference(PatientExample)

// Sender: modtagende enhed (øjenafdelingen) sender forespørgslen
* sender                = Reference(ReceiverOrganizationExample)

// Recipient: den praktiserende læge der skal svare
* recipient[+]          = Reference(ReferringPractitionerRoleExample)

// Binding til den konkrete henvisning
* basedOn[+]            = Reference(ReferralServiceRequestExample)

// Binding til Task der er sat på hold
* about[+]              = Reference(ReceiverTaskOnHoldExample)

// ── Payload[0]: fritekstbegrundelse ───────────────────────────────────
* payload[textContent].contentString = """
  Kære kollega,

  Vi har modtaget Deres henvisning af 12. marts 2024 vedrørende
  ovenstående patient til vurdering for diabetisk retinopati.

  For at kunne foretage en korrekt visitering og prioritering
  af forløbet mangler vi følgende:

  1. Seneste HbA1c-svar (må ikke være ældre end 3 måneder).
     Uden dette kan vi ikke vurdere sygdommens aktuelle regulering.

  2. Seneste øjenspejlingssvar fra almen praksis eller
     diabetesambulatoriet, inkl. dato for undersøgelsen.

  Venligst fremsend disse oplysninger via samme kanal.
  Henvisningen afventer disse svar inden endelig accept.

  Med venlig hilsen
  Visitationsteamet, Øjenafdelingen
  Rigshospitalet, afsnit 3452
"""

// ── Payload[1]: struktureret tjekliste (Questionnaire) ────────────────
* payload[docReference].contentReference
    = Reference(DiabetesEyeReferralQuestionnaire)


// ──────────────────────────────────────────────────────────────────────
// STØTTE-INSTANSER
// Minimale eksempler på de ressourcer der refereres til ovenfor.
// I en rigtig IG ville disse leve i separate filer.
// ──────────────────────────────────────────────────────────────────────

Instance:   PatientExample
InstanceOf: Patient
Title:      "Patient: Eksempel"
Usage:      #example

* identifier[+].system  = $CPR
* identifier[=].value   = "0101609995"
* name[+].family        = "Larsen"
* name[=].given[+]      = "Birthe"
* birthDate             = "1960-01-01"
* address[+].line[+]    = "Strandvejen 12"
* address[=].postalCode = "2100"
* address[=].city       = "København Ø"
* address[=].country    = "DK"


Instance:   ReceiverOrganizationExample
InstanceOf: Organization
Title:      "Modtager: Øjenafdelingen, Rigshospitalet"
Usage:      #example

* identifier[+].system  = $SOR
* identifier[=].value   = "6181000016000"
* name                  = "Øjenafdelingen, Rigshospitalet"
* type[+].coding[+].system  = $SOR
* type[=].coding[=].code    = #hospital-department


Instance:   ReferringPractitionerRoleExample
InstanceOf: PractitionerRole
Title:      "Afsender: Alment praktiserende læge"
Usage:      #example

* identifier[+].system  = $AuthID
* identifier[=].value   = "1234567"
* practitioner          = Reference(ReferringPractitionerExample)
* organization          = Reference(ReferringOrganizationExample)
* code[+].coding[+].system  = $SCT
* code[=].coding[=].code    = #158965000
* code[=].coding[=].display = "Medical practitioner"


Instance:   ReferringPractitionerExample
InstanceOf: Practitioner
Title:      "Afsender Practitioner: Dr. Jensen"
Usage:      #example

* identifier[+].system  = $AuthID
* identifier[=].value   = "1234567"
* name[+].family        = "Jensen"
* name[=].given[+]      = "Peter"
* name[=].prefix[+]     = "Dr."


Instance:   ReferringOrganizationExample
InstanceOf: Organization
Title:      "Afsender: Lægepraksis Dr. Jensen"
Usage:      #example

* identifier[+].system  = $SOR
* identifier[=].value   = "543210987654321"
* name                  = "Dr. Jensen Lægepraksis"


Instance:   ReferralServiceRequestExample
InstanceOf: ServiceRequest
Title:      "Henvisning: Diabetes øjenundersøgelse"
Usage:      #example

* identifier[+].system  = "http://example.dk/referral-ids"
* identifier[=].value   = "REF-2024-00487"
* status                = #on-hold
* intent                = #proposal
* category[+].coding[+].system  = $SCT
* category[=].coding[=].code    = #306206005
* category[=].coding[=].display = "Referral to service"
* code.coding[+].system     = $SCT
* code.coding[=].code       = #71493000
* code.coding[=].display    = "Diabetic retinopathy screening"
* priority              = #routine
* subject               = Reference(PatientExample)
* requester             = Reference(ReferringPractitionerRoleExample)
* performer[+]          = Reference(ReceiverOrganizationExample)
* reasonCode[+].coding[+].system  = "urn:oid:1.2.208.176.2.4.12"
* reasonCode[=].coding[=].code    = #DE14
* reasonCode[=].coding[=].display = "Type 2-diabetes"
* authoredOn            = "2024-03-12T08:30:00Z"
* note[+].text = """
  Patienten er 63-årig kvinde med type 2-diabetes siden 2008,
  senest reguleret med metformin og semaglutid. Ønskes vurderet
  for diabetisk retinopati. Visus bilateralt reduceret ved
  seneste kontrol i praksis.
"""


Instance:   ReceiverTaskOnHoldExample
InstanceOf: Task
Title:      "Task hos modtager: on-hold afventer info"
Usage:      #example

* identifier[+].system  = "http://example.dk/task-ids"
* identifier[=].value   = "task-recv-0342"
* status                = #on-hold
* statusReason.text     = "info-needed: HbA1c og øjenspejlingssvar mangler"
* intent                = #order
* focus                 = Reference(ReferralServiceRequestExample)
* for                   = Reference(PatientExample)
* owner                 = Reference(ReceiverOrganizationExample)
* lastModified          = "2024-03-15T10:42:00Z"
* restriction.period.end = "2024-03-29T23:59:59Z"


Instance:   DiabetesEyeReferralQuestionnaire
InstanceOf: Questionnaire
Title:      "Tjekliste: Diabetes øjenhenvisning — supplerende oplysninger"
Usage:      #example

* url       = "http://medcomfhir.dk/questionnaire/diabetes-eye-referral-checklist"
* version   = "1.0"
* status    = #active
* title     = "Supplerende oplysninger: diabetes øjenhenvisning"
* description = """
  Struktureret tjekliste til brug ved indhentning af supplerende
  kliniske oplysninger forud for accept af øjenhenvisning
  hos patienter med diabetes.
"""
* item[+].linkId    = "hba1c"
* item[=].text      = "Seneste HbA1c-svar (dato og værdi)"
* item[=].type      = #string
* item[=].required  = true

* item[+].linkId    = "hba1c-date"
* item[=].text      = "Dato for HbA1c-måling (må ikke være ældre end 3 måneder)"
* item[=].type      = #date
* item[=].required  = true

* item[+].linkId    = "eye-exam"
* item[=].text      = "Øjenspejlingsresultat (beskriv fund bilateralt)"
* item[=].type      = #text
* item[=].required  = true

* item[+].linkId    = "eye-exam-date"
* item[=].text      = "Dato for seneste øjenspejling"
* item[=].type      = #date
* item[=].required  = true

* item[+].linkId    = "current-hba1c-target"
* item[=].text      = "Aktuelt behandlingsmål for HbA1c (mmol/mol)"
* item[=].type      = #decimal
* item[=].required  = false

* item[+].linkId    = "diabetes-duration"
* item[=].text      = "Diabetesvarighed (år)"
* item[=].type      = #integer
* item[=].required  = false

* item[+].linkId    = "nephropathy"
* item[=].text      = "Kendt nefropati?"
* item[=].type      = #boolean
* item[=].required  = false
