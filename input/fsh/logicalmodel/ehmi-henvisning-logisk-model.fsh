// ============================================================
// EHMI Henvisning – Logisk Model (FSH)
// Udledt af 18 user stories for FHIR-baseret henvisningshåndtering
// Dækker rollerne: Henviser, Visitator, Fælles udvekslingsdialog
// Baseret på HL7 FHIR R4 · dk-core · MedCom FHIR
// ============================================================

// ============================================================
// ENTITET 1: Henvisning
// Kerne-entiteten. Repræsenterer den kliniske anmodning om
// viderehenvisning fra henviser til visitator.
// Primær FHIR-ressource: ServiceRequest
// User stories: 1.1, 1.3, 1.4, 2.3, 2.4, 2.5, 2.6, 3.6
// ============================================================

Logical: Henvisning
Id: ehmi-lm-henvisning
Title: "Henvisning"
Description: """
Repræsenterer en klinisk anmodning om at viderehenvise en patient
til et specialtilbud eller en ydelse. Svarer til FHIR ServiceRequest.
Dækker hele livscyklussen fra oprettelse til afslutning.
"""

* henvisningsId          1..1 Identifier    "Unik identifikator for henvisningen"
* status                 1..1 code          "proposed | active | on-hold | revoked | completed"
* prioritet              1..1 code          "routine | urgent | asap | stat"
* oprettetDato           1..1 dateTime      "Tidspunkt for oprettelse af henvisningen"
* aendretDato            0..1 dateTime      "Tidspunkt for seneste rettelse (revision)"
* ydelseskode            1..1 CodeableConcept "Ønsket ydelse eller specialale (SKS/SNOMED CT)"
* indikation             1..* CodeableConcept "Klinisk indikation / diagnose (SKS/SNOMED CT)"
* kliniskNote            0..1 string        "Fri tekst: anamnese, aktuelle problemer, begrundelse"
* oensketTidspunkt       0..1 dateTime      "Ønsket tidspunkt for undersøgelse eller behandling"
* erstattetAf            0..1 Reference(Henvisning) "Reference til ny/revideret henvisning (replaces)"
* patient                1..1 Reference(Patient)    "Den patient der henvises"
* henviser               1..1 Reference(Behandler)  "Den behandler der opretter og afsender"
* afsenderOrganisation   1..1 Reference(Organisation) "Afsendende organisation (klinik/praksis)"
* modtagerOrganisation   1..1 Reference(Organisation) "Modtagende organisation (visitator)"
* dokumentation          0..* Reference(KliniskDokumentation) "Vedlagte kliniske bilag og resultater"
* booking                0..1 Reference(Booking)    "Tilknyttet booking ved accept"

// FHIR-mapping
* ^mapping[0].identity = "fhir-r4"
* ^mapping[0].uri = "http://hl7.org/fhir"
* henvisningsId          ^mapping[0].map = "ServiceRequest.identifier"
* status                 ^mapping[0].map = "ServiceRequest.status"
* prioritet              ^mapping[0].map = "ServiceRequest.priority"
* oprettetDato           ^mapping[0].map = "ServiceRequest.authoredOn"
* aendretDato            ^mapping[0].map = "ServiceRequest.meta.lastUpdated"
* ydelseskode            ^mapping[0].map = "ServiceRequest.code"
* indikation             ^mapping[0].map = "ServiceRequest.reasonCode"
* kliniskNote            ^mapping[0].map = "ServiceRequest.note.text"
* oensketTidspunkt       ^mapping[0].map = "ServiceRequest.occurrenceDateTime"
* erstattetAf            ^mapping[0].map = "ServiceRequest.replaces"
* patient                ^mapping[0].map = "ServiceRequest.subject"
* henviser               ^mapping[0].map = "ServiceRequest.requester"
* afsenderOrganisation   ^mapping[0].map = "ServiceRequest.requester (Organization)"
* modtagerOrganisation   ^mapping[0].map = "ServiceRequest.performer"
* dokumentation          ^mapping[0].map = "ServiceRequest.supportingInfo"
* booking                ^mapping[0].map = "ServiceRequest.basedOn (Appointment)"


// ============================================================
// ENTITET 2: Patient
// Den patient der er genstand for henvisningen.
// Primær FHIR-ressource: Patient (DkCorePatient)
// User stories: 1.1 (alle stories implicit)
// ============================================================

Logical: Patient
Id: ehmi-lm-patient
Title: "Patient"
Description: """
Repræsenterer den patient der viderehenvises. Svarer til FHIR Patient
profileret som DkCorePatient med dansk CPR-nummer som primær identifikator.
"""

* cpr                    1..1 Identifier    "CPR-nummer (dansk national patientidentifikator)"
* navn                   1..1 HumanName     "Fulde navn"
* foedselsdato           0..1 date          "Fødselsdato"
* koen                   0..1 code          "Køn: male | female | other | unknown"
* adresse                0..1 Address       "Bopælsadresse"
* telefon                0..* ContactPoint  "Kontakttelefon(er)"
* kontaktperson          0..* BackboneElement "Pårørende eller anden kontakt"
  * navn                 1..1 HumanName     "Kontaktpersonens navn"
  * relation             1..1 CodeableConcept "Relation til patient (pårørende, værge mv.)"
  * telefon              0..1 ContactPoint  "Kontaktpersonens telefon"

// FHIR-mapping
* ^mapping[0].identity = "fhir-r4"
* ^mapping[0].uri = "http://hl7.org/fhir"
* cpr                    ^mapping[0].map = "Patient.identifier (urn:oid:1.2.208.176.1.2)"
* navn                   ^mapping[0].map = "Patient.name"
* foedselsdato           ^mapping[0].map = "Patient.birthDate"
* koen                   ^mapping[0].map = "Patient.gender"
* adresse                ^mapping[0].map = "Patient.address"
* telefon                ^mapping[0].map = "Patient.telecom"
* kontaktperson          ^mapping[0].map = "Patient.contact"


// ============================================================
// ENTITET 3: Behandler
// Den sundhedsprofessionelle der opretter og afsender en
// henvisning, eller som modtager og behandler den.
// Primær FHIR-ressource: Practitioner + PractitionerRole
// User stories: 1.1, 1.2, 1.3, 1.4, 2.x
// ============================================================

Logical: Behandler
Id: ehmi-lm-behandler
Title: "Behandler"
Description: """
Repræsenterer en sundhedsprofessionel i rollen som enten
henviser eller visitator. Svarer til FHIR Practitioner kombineret
med PractitionerRole for at udtrykke rolle og tilknyttet organisation.
"""

* autorisationsId        1..1 Identifier    "Autorisations-ID (Sundhedsstyrelsen)"
* navn                   1..1 HumanName     "Fulde navn"
* speciale               0..1 CodeableConcept "Fagligt speciale (SKS-klassifikation)"
* rolle                  1..1 CodeableConcept "Rolle i flowet: henviser | visitator"
* organisation           1..1 Reference(Organisation) "Tilknyttet organisation"
* direkteKontakt         0..1 ContactPoint  "Direkte kontaktoplysning (telefon/sikker mail)"

// FHIR-mapping
* ^mapping[0].identity = "fhir-r4"
* ^mapping[0].uri = "http://hl7.org/fhir"
* autorisationsId        ^mapping[0].map = "Practitioner.identifier (Autorisations-ID)"
* navn                   ^mapping[0].map = "Practitioner.name"
* speciale               ^mapping[0].map = "PractitionerRole.specialty"
* rolle                  ^mapping[0].map = "PractitionerRole.code"
* organisation           ^mapping[0].map = "PractitionerRole.organization"
* direkteKontakt         ^mapping[0].map = "Practitioner.telecom"


// ============================================================
// ENTITET 4: Organisation
// Afsendende eller modtagende organisation i henvisningsflowet.
// Primær FHIR-ressource: Organization (DkCoreOrganization)
// User stories: 1.1, 2.1, 2.5
// ============================================================

Logical: Organisation
Id: ehmi-lm-organisation
Title: "Organisation"
Description: """
Repræsenterer en sundhedsorganisation der enten afsender eller modtager
henvisninger. Svarer til FHIR Organization profileret som DkCoreOrganization
med SOR-kode og GLN som primære identifikatorer.
"""

* sorKode                1..1 Identifier    "SOR-kode (Sundhedsorganisationsregisteret)"
* glnNummer              0..1 Identifier    "GLN-nummer (Global Location Number)"
* ydernummer             0..1 Identifier    "Ydernummer (praksis-identifikator)"
* navn                   1..1 string        "Organisationens navn"
* type                   1..1 CodeableConcept "Type: hospital | praksis | speciallaegepraksis | ..."
* adresse                0..1 Address       "Organisationens adresse"
* ehmiEndpoint           1..1 url           "EHMI/eDelivery endpoint (AP-adresse)"
* overordnetOrganisation 0..1 Reference(Organisation) "Overordnet organisation (fx region)"

// FHIR-mapping
* ^mapping[0].identity = "fhir-r4"
* ^mapping[0].uri = "http://hl7.org/fhir"
* sorKode                ^mapping[0].map = "Organization.identifier (SOR)"
* glnNummer              ^mapping[0].map = "Organization.identifier (GLN)"
* ydernummer             ^mapping[0].map = "Organization.identifier (Ydernummer)"
* navn                   ^mapping[0].map = "Organization.name"
* type                   ^mapping[0].map = "Organization.type"
* adresse                ^mapping[0].map = "Organization.address"
* ehmiEndpoint           ^mapping[0].map = "Organization.endpoint (EHMI)"
* overordnetOrganisation ^mapping[0].map = "Organization.partOf"


// ============================================================
// ENTITET 5: KliniskDokumentation
// Supplerende klinisk materiale der vedhæftes en henvisning.
// Primær FHIR-ressource: DocumentReference, DiagnosticReport, Observation
// User stories: 1.2
// ============================================================

Logical: KliniskDokumentation
Id: ehmi-lm-klinisk-dokumentation
Title: "KliniskDokumentation"
Description: """
Repræsenterer supplerende klinisk materiale der knyttes til en
Henvisning for at understøtte visitators beslutningsgrundlag.
Kan være laboratoriesvar, billeddiagnostik, epikriser eller andre dokumenter.
Svarer til FHIR DocumentReference, DiagnosticReport eller Observation.
"""

* dokumentId             1..1 Identifier    "Unik identifikator for dokumentet"
* type                   1..1 CodeableConcept "Dokumenttype: labsvar | billeddiagnostik | epikrise | medicin | andet"
* titel                  0..1 string        "Dokumentets titel eller emne"
* dato                   1..1 dateTime      "Dato/tidspunkt for dokumentet"
* indhold                0..1 Attachment    "Selve dokumentindholdet (base64 eller URL)"
* forfatter              0..1 Reference(Behandler) "Den der har udstedt/registreret dokumentet"
* relatertHenvisning     1..1 Reference(Henvisning) "Den henvisning dokumentet er knyttet til"

// FHIR-mapping
* ^mapping[0].identity = "fhir-r4"
* ^mapping[0].uri = "http://hl7.org/fhir"
* dokumentId             ^mapping[0].map = "DocumentReference.identifier | DiagnosticReport.identifier"
* type                   ^mapping[0].map = "DocumentReference.type | DiagnosticReport.code"
* titel                  ^mapping[0].map = "DocumentReference.description"
* dato                   ^mapping[0].map = "DocumentReference.date | DiagnosticReport.effectiveDateTime"
* indhold                ^mapping[0].map = "DocumentReference.content.attachment"
* forfatter              ^mapping[0].map = "DocumentReference.author | DiagnosticReport.performer"
* relatertHenvisning     ^mapping[0].map = "ServiceRequest.supportingInfo"


// ============================================================
// ENTITET 6: Visitationsafgoerelse
// Visitatorens formelle afgørelse om en modtaget henvisning.
// Primær FHIR-ressource: Task
// User stories: 2.2, 2.3, 2.4, 2.5, 2.6, 1.6
// ============================================================

Logical: Visitationsafgoerelse
Id: ehmi-lm-visitationsafgoerelse
Title: "Visitationsafgoerelse"
Description: """
Repræsenterer visitatorens formelle beslutning om en indkommende
henvisning: accept, afvisning, videresendelse eller prioritetsændring.
Svarer til FHIR Task med outcome og begrundelse.
"""

* afgoerelseId           1..1 Identifier    "Unik identifikator for afgørelsen"
* type                   1..1 code          "accept | afvisning | videresendelse | prioritetsaendring"
* status                 1..1 code          "requested | received | accepted | rejected | completed"
* prioritet              0..1 code          "routine | urgent | asap | stat"
* begrundelse            0..1 string        "Faglig begrundelse for afgørelsen"
* aarsagskode            0..1 CodeableConcept "Struktureret årsag (fx kapacitet, indikation, forkert spor)"
* truffetDato            1..1 dateTime      "Tidspunkt for afgørelsen"
* truffetAf              1..1 Reference(Behandler) "Visitatoren der har truffet afgørelsen"
* vedroererHenvisning    1..1 Reference(Henvisning) "Den henvisning afgørelsen vedrører"
* alternativtTilbud      0..1 Reference(Henvisning) "Reference til alternativt tilbud (ved videresendelse)"

// FHIR-mapping
* ^mapping[0].identity = "fhir-r4"
* ^mapping[0].uri = "http://hl7.org/fhir"
* afgoerelseId           ^mapping[0].map = "Task.identifier"
* type                   ^mapping[0].map = "Task.code"
* status                 ^mapping[0].map = "Task.status"
* prioritet              ^mapping[0].map = "Task.priority"
* begrundelse            ^mapping[0].map = "Task.note.text"
* aarsagskode            ^mapping[0].map = "Task.statusReason"
* truffetDato            ^mapping[0].map = "Task.executionPeriod.end"
* truffetAf              ^mapping[0].map = "Task.owner"
* vedroererHenvisning    ^mapping[0].map = "Task.focus (ServiceRequest)"
* alternativtTilbud      ^mapping[0].map = "Task.output (ServiceRequest reference)"


// ============================================================
// ENTITET 7: Booking
// Repræsenterer en aftalt tid tilknyttet en accepteret henvisning.
// Primær FHIR-ressource: Appointment
// User stories: 2.3
// ============================================================

Logical: Booking
Id: ehmi-lm-booking
Title: "Booking"
Description: """
Repræsenterer en aftalt tid der oprettes ved accept af en henvisning.
Knyttes til den accept-givne Henvisning og notificerer automatisk
patienten og henviseren. Svarer til FHIR Appointment.
"""

* bookingId              1..1 Identifier    "Unik identifikator for bookingen"
* status                 1..1 code          "proposed | booked | arrived | fulfilled | cancelled"
* tidspunkt              1..1 dateTime      "Det aftalte tidspunkt"
* varighed               0..1 Duration      "Forventet varighed"
* fremmoedeType          0..1 CodeableConcept "Fremmødetype: fysisk | telefonisk | video"
* lokation               0..1 Reference(Organisation) "Sted for fremmødet"
* patient                1..1 Reference(Patient)      "Patienten der har fået tid"
* relatertHenvisning     1..1 Reference(Henvisning)   "Den henvisning der har udløst bookingen"

// FHIR-mapping
* ^mapping[0].identity = "fhir-r4"
* ^mapping[0].uri = "http://hl7.org/fhir"
* bookingId              ^mapping[0].map = "Appointment.identifier"
* status                 ^mapping[0].map = "Appointment.status"
* tidspunkt              ^mapping[0].map = "Appointment.start"
* varighed               ^mapping[0].map = "Appointment.minutesDuration"
* fremmoedeType          ^mapping[0].map = "Appointment.appointmentType"
* lokation               ^mapping[0].map = "Appointment.participant (Location/Organization)"
* patient                ^mapping[0].map = "Appointment.participant (Patient)"
* relatertHenvisning     ^mapping[0].map = "Appointment.basedOn (ServiceRequest)"


// ============================================================
// ENTITET 8: Kommunikationsbesked
// Struktureret besked udvekslet mellem henviser og visitator.
// Primær FHIR-ressource: Communication, CommunicationRequest
// User stories: 3.1, 3.2, 3.3, 3.4, 3.5, 3.6
// ============================================================

Logical: Kommunikationsbesked
Id: ehmi-lm-kommunikationsbesked
Title: "Kommunikationsbesked"
Description: """
Repræsenterer en struktureret besked i den løbende dialog mellem
henviser og visitator. Bruges til supplement-anmodninger, faglig
afklaring, alternativ visitation og korrektionsaftaler.
Svarer til FHIR Communication eller CommunicationRequest.
"""

* beskedId               1..1 Identifier    "Unik identifikator for beskeden"
* type                   1..1 code          "anmodning | svar | afklaring | notifikation | korrektionsaftale"
* status                 1..1 code          "preparation | in-progress | completed | entered-in-error"
* emne                   0..1 string        "Kort emne eller titel"
* indhold                1..1 string        "Beskedens tekstindhold"
* sendt                  1..1 dateTime      "Afsendelsestidspunkt"
* afsender               1..1 Reference(Behandler)  "Den der har afsendt beskeden"
* modtager               1..* Reference(Behandler)  "Den eller de der modtager beskeden"
* svarPaa                0..1 Reference(Kommunikationsbesked) "Reference til den besked der besvares"
* vedroererHenvisning    1..1 Reference(Henvisning)  "Den henvisning kommunikationen vedrører"
* bilag                  0..* Reference(KliniskDokumentation) "Eventuelle vedlagte dokumenter"

// FHIR-mapping
* ^mapping[0].identity = "fhir-r4"
* ^mapping[0].uri = "http://hl7.org/fhir"
* beskedId               ^mapping[0].map = "Communication.identifier"
* type                   ^mapping[0].map = "Communication.category | CommunicationRequest.category"
* status                 ^mapping[0].map = "Communication.status"
* emne                   ^mapping[0].map = "Communication.topic"
* indhold                ^mapping[0].map = "Communication.payload.contentString"
* sendt                  ^mapping[0].map = "Communication.sent"
* afsender               ^mapping[0].map = "Communication.sender"
* modtager               ^mapping[0].map = "Communication.recipient"
* svarPaa                ^mapping[0].map = "Communication.inResponseTo"
* vedroererHenvisning    ^mapping[0].map = "Communication.basedOn (ServiceRequest)"
* bilag                  ^mapping[0].map = "Communication.payload (Attachment/Reference)"


// ============================================================
// ENTITET 9: Statusnotifikation
// Automatisk notifikation ved statusændring på en henvisning.
// Primær FHIR-ressource: SubscriptionNotification, SubscriptionStatus
// User stories: 1.5, 1.6, 2.6, 3.4
// ============================================================

Logical: Statusnotifikation
Id: ehmi-lm-statusnotifikation
Title: "Statusnotifikation"
Description: """
Repræsenterer en automatisk notifikation der sendes til en abonnent
(typisk henviseren) ved statusændring på en aktiv henvisning.
Svarer til FHIR SubscriptionNotification / SubscriptionStatus (R4B/R5-mønster
implementeret via MedCom-notifikationsmodel i R4).
"""

* notifikationsId        1..1 Identifier    "Unik identifikator for notifikationen"
* type                   1..1 code          "handshake | heartbeat | event-notification | query-status"
* udloestAfStatus        1..1 code          "Den nye status der udløste notifikationen"
* tidspunkt              1..1 dateTime      "Tidspunkt for notifikationen"
* abonnement             1..1 Reference(Abonnement)  "Det abonnement der udløste notifikationen"
* vedroererHenvisning    1..1 Reference(Henvisning)  "Den ændrede henvisning"
* modtager               1..1 Reference(Organisation) "Modtagende organisation (abonnenten)"

// FHIR-mapping
* ^mapping[0].identity = "fhir-r4"
* ^mapping[0].uri = "http://hl7.org/fhir"
* notifikationsId        ^mapping[0].map = "Bundle.identifier (notification-bundle)"
* type                   ^mapping[0].map = "SubscriptionStatus.type"
* udloestAfStatus        ^mapping[0].map = "SubscriptionStatus.notificationEvent.focus (ServiceRequest.status)"
* tidspunkt              ^mapping[0].map = "SubscriptionStatus.notificationEvent.timestamp"
* abonnement             ^mapping[0].map = "SubscriptionStatus.subscription"
* vedroererHenvisning    ^mapping[0].map = "SubscriptionStatus.notificationEvent.focus"
* modtager               ^mapping[0].map = "Subscription.channel.endpoint (abonnentens endpoint)"


// ============================================================
// ENTITET 10: Abonnement
// Registrering af hvilke statusændringer en part ønsker at
// modtage notifikationer om.
// Primær FHIR-ressource: Subscription
// User stories: 1.5, 3.4
// ============================================================

Logical: Abonnement
Id: ehmi-lm-abonnement
Title: "Abonnement"
Description: """
Repræsenterer en abonnementsregistrering der definerer hvilke
hændelser en abonnent (typisk henviseren) ønsker at modtage
notifikationer om. Svarer til FHIR Subscription.
"""

* abonnementId           1..1 Identifier    "Unik identifikator for abonnementet"
* status                 1..1 code          "requested | active | error | off"
* kriterie               1..1 string        "FHIR søgekriterium (fx ServiceRequest?requester=...)"
* kanal                  1..1 code          "Leveringskanal: rest-hook | message | email"
* endpoint               1..1 url           "URL/endpoint der modtager notifikationer (EHMI)"
* abonnent               1..1 Reference(Organisation) "Den organisation der abonnerer"
* oprettetDato           1..1 dateTime      "Tidspunkt for oprettelse af abonnementet"
* udloeber               0..1 dateTime      "Udløbstidspunkt (hvis midlertidigt)"

// FHIR-mapping
* ^mapping[0].identity = "fhir-r4"
* ^mapping[0].uri = "http://hl7.org/fhir"
* abonnementId           ^mapping[0].map = "Subscription.id"
* status                 ^mapping[0].map = "Subscription.status"
* kriterie               ^mapping[0].map = "Subscription.criteria"
* kanal                  ^mapping[0].map = "Subscription.channel.type"
* endpoint               ^mapping[0].map = "Subscription.channel.endpoint"
* abonnent               ^mapping[0].map = "Subscription.contact (Organization)"
* oprettetDato           ^mapping[0].map = "Subscription.meta.lastUpdated"
* udloeber               ^mapping[0].map = "Subscription.end"


// ============================================================
// ENTITET 11: Meddelelseskonvolut
// Den tekniske FHIR-beskedomslagning (transport) der bærer
// en eller flere kliniske ressourcer via EHMI.
// Primær FHIR-ressource: Bundle (type=message) + MessageHeader
// User stories: 1.1, 2.1
// ============================================================

Logical: Meddelelseskonvolut
Id: ehmi-lm-meddelelseskonvolut
Title: "Meddelelseskonvolut"
Description: """
Repræsenterer den tekniske meddelelsesomslag der transporterer
kliniske ressourcer (Henvisning, Afgørelse mv.) via EHMI og eDelivery.
Svarer til FHIR Bundle (type=message) med MessageHeader som første entry.
"""

* meddelelsesId          1..1 id            "Unik UUID for denne meddelelse"
* haendelsestype         1..1 Coding         "Hændelsestype: ny-henvisning | annuller | opdater | kvittering"
* afsendelsestidspunkt   1..1 dateTime      "Tidspunkt for afsendelse"
* afsender               1..1 Reference(Organisation) "Afsendende organisation"
* modtager               1..* Reference(Organisation) "Modtagende organisation(er)"
* fokus                  1..* Reference     "Primær klinisk ressource (Henvisning, Afgørelse mv.)"
* kildesystem            1..1 string        "Afsendende systems endpoint (teknisk)"

// FHIR-mapping
* ^mapping[0].identity = "fhir-r4"
* ^mapping[0].uri = "http://hl7.org/fhir"
* meddelelsesId          ^mapping[0].map = "Bundle.id | MessageHeader.id"
* haendelsestype         ^mapping[0].map = "MessageHeader.eventCoding"
* afsendelsestidspunkt   ^mapping[0].map = "Bundle.timestamp"
* afsender               ^mapping[0].map = "MessageHeader.sender"
* modtager               ^mapping[0].map = "MessageHeader.destination.receiver"
* fokus                  ^mapping[0].map = "MessageHeader.focus"
* kildesystem            ^mapping[0].map = "MessageHeader.source.endpoint"
