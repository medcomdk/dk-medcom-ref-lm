# User stories for FHIR-baseret henvisningshåndtering

> **Bemærk:** Dette dokument er en videreudvikling af den tidligere oversigt over user stories for FHIR-baseret henvisningshåndtering. Oversigten er et arbejdsgrundlag til dialog og kvalificering med de relevante aktører. Den er ikke i sig selv en fuldstændig kravspecifikation eller en endelig fastlæggelse af FHIR-implementeringen.
>
> Dokumentet samler de oprindelige user stories med en ny række behov fra henviser-, visitations-, patient- og administrationsperspektiv. Hvor nye behov i væsentlig grad dækkes af en eksisterende user story, er de indarbejdet dér og markeret med **[Flettet sammen med …]**. Behov, der tilfører en selvstændig funktion eller arbejdsgang, er oprettet som nye user stories.
>
> FHIR-ressourcerne er angivet som et foreløbigt bud på relevante ressourcer og relationer. Den konkrete profilering, statusmodel, identifikationsstrategi, sikkerhed og meddelelsesstruktur skal fastlægges i den videre modellering.

## User stories for FHIR-baseret henvisningshåndtering

Oversigten beskriver user stories for de centrale aktører i et FHIR-baseret henvisningsflow:

- **Henviser** – den sundhedsperson eller organisatoriske enhed, der opretter og afsender henvisningen.
- **Centralvisitator** – en funktion, der fordeler færdige henvisninger til relevante specialer eller enheder.
- **Henvisningsmodtager/visitator** – den enhed, der modtager, vurderer og visiterer henvisningen.
- **Patient** – den person, som henvisningen vedrører, og som har behov for indsigt i henvisningsforløbet.
- **Administrator** – en person eller organisatorisk funktion, der har behov for overblik og statistik over henvisningsprocesserne.
- **Fælles udvekslingsdialog** – aktiviteter, hvor henviser og modtager kommunikerer om en konkret henvisning.

User stories er grupperet efter aktør og arbejdsgang. En user story kan involvere flere aktører, selv om den er placeret under den rolle, der primært har behovet.

## User story-oversigt med foreløbig FHIR-ressource

| User story | Primære FHIR-ressourcer (foreløbigt) | Retning/aktør |
|---|---|---|
| 1.1 Oprette og færdigmelde en henvisning | `ServiceRequest`, `Bundle`, `Task` | Henviser → modtager |
| 1.2 Tilknytte klinisk dokumentation og bilag | `DocumentReference`, `Binary`, `DiagnosticReport`, `Media`, `ServiceRequest` | Henviser → modtager |
| 1.3 Ændre en afsendt eller afvist henvisning | `ServiceRequest`, `Task`, `Provenance` | Henviser → modtager |
| 1.4 Tilbagekalde en henvisning | `ServiceRequest`, `Task` | Henviser → modtager |
| 1.5 Monitorere status på afsendte henvisninger | `ServiceRequest`, `Task`, `Subscription`, `SubscriptionStatus` | Henviser |
| 1.6 Modtage afgørelse og status fra visitatoren | `Task`, `SubscriptionNotification`, `ServiceRequest` | Modtager → henviser |
| 1.7 Finde relevant tilbud og vejledning | `HealthcareService`, `Organization`, `Location`, `Endpoint`, `PlanDefinition`/relevant vejledningsindhold | Henviser |
| 1.8 Få hjælp til at udfylde henvisningen | `ServiceRequest`, relevante kliniske ressourcer og vejledningsindhold | Henviser |
| 1.9 Importere oplysninger fra patientjournalen | Relevante kliniske ressourcer, `ServiceRequest` | Henviser |
| 1.10 Se og drøfte et henvisningsudkast | `ServiceRequest`, `Communication` | Henviser ↔ modtager |
| 1.11 Holde henvisningsdialog adskilt fra øvrig korrespondance | `Communication`, `CommunicationRequest`, `ServiceRequest` | Begge |
| 1.12 Knytte flere henvisninger sammen og koordinere booking | `ServiceRequest`, `Appointment`, `Task` | Henviser ↔ modtagere |
| 2.1 Modtage og kvittere for ny henvisning | `Bundle`, `MessageHeader`, `ServiceRequest` | Modtager |
| 2.2 Triagere og prioritere en henvisning | `Task`, `ServiceRequest` | Modtager |
| 2.3 Acceptere en henvisning og booke forløb | `ServiceRequest`, `Appointment`, `Task` | Modtager → henviser |
| 2.4 Afvise en henvisning med begrundelse | `Task`, `ServiceRequest`, `Communication` | Modtager → henviser |
| 2.5 Videresende til anden modtager | `ServiceRequest`, `Task`, `Communication` | Modtager → ny modtager/henviser |
| 2.6 Ændre prioritet på en modtaget henvisning | `ServiceRequest`, `Task`, `SubscriptionNotification` | Modtager → henviser |
| 2.7 Hente accepteret henvisning og bilag til eget journalsystem | `ServiceRequest`, `DocumentReference`, `Binary`, relevante kliniske ressourcer | Modtager |
| 2.8 Koordinere sammenhængende henvisninger og bookinger | `ServiceRequest`, `Appointment`, `Task` | Modtager(e) |
| 2.9 Orientere henviser om booking | `Appointment`, `Task`, `SubscriptionNotification`/`Communication` | Modtager → henviser |
| 2.10 Vedligeholde henvisningsvejledninger og patientforløbsbeskrivelser | Relevant publicerings-/vejledningsindhold, evt. `PlanDefinition` | Modtager/ansvarlig organisation |
| 2.11 Få overblik over færdige henvisninger i centralvisitationen | `ServiceRequest`, `Task`, `Organization`, `HealthcareService` | Centralvisitator |
| 3.1 Anmode om supplerende oplysninger | `CommunicationRequest`, `ServiceRequest` | Modtager → henviser |
| 3.2 Besvare anmodning om supplement | `Communication`, `ServiceRequest` | Henviser → modtager |
| 3.3 Faglig afklaring i dialog | `Communication`, `ServiceRequest` | Begge |
| 3.4 Statusnotifikation til henviser | `SubscriptionNotification`, `Task`, `ServiceRequest` | Modtager → henviser |
| 3.5 Aftale om alternativ visitation | `Communication`, `Task`, `ServiceRequest` | Begge |
| 3.6 Aftale og gennemføre korrektion | `Communication`, `ServiceRequest`, `Task` | Begge |
| 4.1 Se status på egen henvisning | Patientrettet visning baseret på `ServiceRequest`, `Task` og `Appointment` | Patient |
| 4.2 Se egne henvisninger og tilhørende bilag | Patientrettet visning baseret på `ServiceRequest`, `DocumentReference` m.fl. | Patient |
| 4.3 Se beskeder om bookinger | Patientrettet visning baseret på `Appointment` og relevante meddelelser | Patient |
| 5.1 Se anonymiseret statistik om henvisningsforløb | Aftalt analyse-/rapporteringsmodel | Administrator |
| 5.2 Se anonymiseret statistik om henvisningsstatus | Aftalt analyse-/rapporteringsmodel | Administrator |
| 5.3 Se anonymiseret statistik om henvisningsdiagnoser | Aftalt analyse-/rapporteringsmodel | Administrator |
| 5.4 Se anonymiseret statistik om afvisningsårsager | Aftalt analyse-/rapporteringsmodel | Administrator |
| 5.5 Se anonymiseret statistik om videresendte henvisninger | Aftalt analyse-/rapporteringsmodel | Administrator |

## Henviserens user stories

Disse user stories beskriver henviserens arbejde med at oprette, kvalificere, afsende og følge op på henvisninger. Flere af aktiviteterne kan foregå i henviserens eget journalsystem, som bør understøtte genbrug af allerede registrerede oplysninger.

### User story 1.1 Oprette og færdigmelde en henvisning

> **User story:**
>
> Som henviser ønsker jeg at kunne oprette og afsende en struktureret henvisning via FHIR,
> når jeg har truffet en klinisk beslutning om at viderehenvise en patient,
> så modtageren får de nødvendige oplysninger på et standardiseret format, og visitationsprocessen kan begynde.

Henviseren opretter en henvisning til et relevant undersøgelses- eller behandlingstilbud. Henvisningen repræsenteres som en `ServiceRequest` og sendes i en FHIR-`Bundle`. Henviseren skal kunne arbejde med henvisningen, indtil den er klar til afsendelse, og tydeligt kunne markere, at den er færdigudfyldt. Først når henvisningen er færdigmeldt og afsendt, skal modtagerens egentlige visitationsproces kunne igangsættes.

Henvisningsprocessen bør opleves ensartet på tværs af henviserens og modtagerens roller, specialer og geografiske placering. Lokale arbejdsgange kan have betydning for det konkrete tilbud, men bør ikke medføre unødigt forskellige grundlæggende henvisningsprocesser.

**Nye behov indarbejdet:** digital henvisning til specialiseret undersøgelse/behandling; en ensartet national henvisningsproces; tydelig markering af, at henvisningen er færdig.

| Element | Beskrivelse |
|---|---|
| Primær FHIR-ressource | `ServiceRequest`, `Bundle`, evt. `Task` |
| Triggerhændelse | Klinisk beslutning om at henvise patienten |
| Forrige trin | → 1.7 Finde relevant tilbud og vejledning; → 1.8 Få hjælp til at udfylde henvisningen; → 1.2 Tilknytte klinisk dokumentation (hvis relevant) |
| Næste trin | → 2.1 Modtage og kvittere for ny henvisning |

### User story 1.2 Tilknytte klinisk dokumentation og bilag

> **User story:**
>
> Som henviser ønsker jeg at kunne knytte relevant klinisk dokumentation og filer til en henvisning,
> når modtageren har brug for supplerende materiale for at kunne vurdere patientens behov,
> så beslutningsgrundlaget er samlet og tilgængeligt sammen med henvisningen.

Henviseren vedhæfter eller refererer til supplerende klinisk materiale, fx laboratoriesvar, billeddiagnostik, tidligere epikriser eller andre dokumenter. Materialet kan allerede findes struktureret i journalsystemet eller foreligge som særskilte filer. Systemet bør understøtte, at relevante oplysninger og filer kan tilknyttes uden unødvendig manuel genindtastning.

**Flettet sammen med:** den oprindelige user story 1.2 *Tilknytte klinisk dokumentation*. Det nye behov om at vedhæfte filer er indarbejdet her.

| Element | Beskrivelse |
|---|---|
| Primære FHIR-ressourcer | `DocumentReference`, `Binary`, `DiagnosticReport`, `Media`, `ServiceRequest` |
| Triggerhændelse | Behov for at understøtte henvisningen med supplerende klinisk dokumentation |
| Forrige trin | ← 1.1 Oprette og færdigmelde en henvisning |
| Næste trin | → 2.1 Modtage og kvittere for ny henvisning |

### User story 1.3 Ændre en afsendt eller afvist henvisning

> **User story:**
>
> Som henviser ønsker jeg at kunne rette indholdet i en allerede afsendt henvisning,
> når jeg opdager en fejl, modtager en afvisning med ønske om supplerende oplysninger, eller patientens kliniske situation ændrer sig,
> så modtageren kan arbejde videre på et korrekt og opdateret grundlag.

Henviseren skal kunne korrigere en henvisning, der er sendt, men endnu ikke er endeligt håndteret, når det er tilladt i henvisningsforløbets aktuelle status. Hvis henvisningen er afvist på grund af manglende oplysninger, skal henviseren kunne tilrette den og færdigmelde/afsende den igen. Ændringer skal kunne spores, og modtageren skal kunne se, hvad der er ændret.

**Flettet sammen med:** den oprindelige user story 1.3 *Ændre en afsendt henvisning*. Det nye behov om at tilrette og genfremsende en afvist henvisning er indarbejdet her.

| Element | Beskrivelse |
|---|---|
| Primære FHIR-ressourcer | `ServiceRequest`, `Task`, `Provenance` |
| Triggerhændelse | Fejl, ændret klinisk situation eller modtaget afvisning med behov for korrektion |
| Forrige trin | ← 2.4 Afvise en henvisning med begrundelse; ← 3.6 Aftale og gennemføre korrektion |
| Næste trin | → 2.2 Triagere og prioritere en henvisning |

### User story 1.4 Tilbagekalde en henvisning

> **User story:**
>
> Som henviser ønsker jeg at kunne tilbagekalde en afsendt henvisning,
> når patienten ikke længere ønsker forløbet, eller det kliniske grundlag er bortfaldet,
> så modtageren ikke bruger ressourcer på en henvisning, der ikke længere skal ekspederes.

Henviseren annullerer en afsendt henvisning, der endnu kan tilbagekaldes i henvisningsforløbets aktuelle status. Modtageren orienteres om tilbagekaldelsen, og det skal fremgå, at henvisningen ikke længere skal behandles.

| Element | Beskrivelse |
|---|---|
| Primære FHIR-ressourcer | `ServiceRequest`, `Task` |
| Triggerhændelse | Patienten ønsker ikke længere forløbet, eller det kliniske grundlag er bortfaldet |
| Forrige trin | ← 1.1 Oprette og færdigmelde en henvisning |
| Næste trin | Flowet afsluttes, hvis tilbagekaldelsen kan gennemføres |

### User story 1.5 Monitorere status på afsendte henvisninger

> **User story:**
>
> Som henviser ønsker jeg løbende at kunne se status på mine afsendte og udestående henvisninger,
> når jeg har behov for overblik over patienternes videre forløb,
> så jeg kan følge op og informere patienterne korrekt.

Henviseren kan følge status for egne henvisninger, fx under udarbejdelse, færdig/afsendt, modtaget, under visitation, afvist, videresendt, accepteret og booket. Status kan formidles ved notifikationer eller ved opslag i modtagersystemet.

**Flettet sammen med:** den oprindelige user story 1.5 *Monitorere status på afsendte henvisninger*. De nye behov om at kunne se, om henvisningen er accepteret, afvist eller videresendt, dækkes af denne user story og de tilhørende afgørelses- og statusnotifikationer.

| Element | Beskrivelse |
|---|---|
| Primære FHIR-ressourcer | `ServiceRequest`, `Task`, `Subscription`, `SubscriptionStatus` |
| Triggerhændelse | Behov for overblik over egne afsendte henvisninger |
| Forrige trin | ← 1.1 Oprette og færdigmelde en henvisning |
| Næste trin | → 1.6 Modtage afgørelse og status fra visitatoren |

### User story 1.6 Modtage afgørelse og status fra visitatoren

> **User story:**
>
> Som henviser ønsker jeg automatisk at modtage afgørelser og relevante statusoplysninger om mine henvisninger i mit journalsystem,
> når modtageren har modtaget, afvist, accepteret eller videresendt en henvisning, eller når patienten er blevet booket,
> så jeg hurtigt kan handle og orientere patienten om det videre forløb.

Henviseren modtager relevante hændelser fra modtageren. Det skal som minimum være muligt at se, om henvisningen er modtaget, accepteret, afvist eller videresendt, og – når det er relevant – hvorfor den er afvist, hvor den er videresendt til, og om patienten er booket til en eller flere kontakter.

Notifikationerne skal indeholde en entydig reference til henvisningen og de oplysninger, der er nødvendige for at forstå hændelsen. Detaljer om afgørelser og booking kan vises ved opslag på den tilhørende henvisning eller aftale.

**Flettet sammen med:** den oprindelige user story 1.6 *Modtage afgørelse fra visitatoren* og 3.4 *Statusnotifikation til henviser*. De nye behov om afvisning, afvisningsårsag, accept, videresendelse og booking er indarbejdet her.

| Element | Beskrivelse |
|---|---|
| Primære FHIR-ressourcer | `Task`, `SubscriptionNotification`, `ServiceRequest`, `Appointment`, `Communication` |
| Triggerhændelse | Modtageren registrerer en relevant statusændring eller afgørelse |
| Forrige trin | ← 2.3 Acceptere en henvisning og booke forløb; ← 2.4 Afvise en henvisning med begrundelse; ← 2.5 Videresende til anden modtager |
| Næste trin | Henviser følger op, informerer patienten eller foretager en korrigerende handling |

### User story 1.7 Finde relevant tilbud og henvisningsvejledning

> **User story:**
>
> Som henviser ønsker jeg hjælp til at finde det rette specialiserede undersøgelses- eller behandlingstilbud og den tilhørende henvisningsvejledning,
> når jeg har beskrevet patientens symptomer og problemstillinger,
> så jeg hurtigere kan finde et relevant tilbud i patientens nærområde og henvise på et korrekt grundlag.

Henviserens journalsystem bør kunne understøtte søgning og valg af relevante tilbud på baggrund af henvisningens kliniske indhold, patientens behov og geografiske forhold. Det skal være muligt at finde den relevante patientforløbsbeskrivelse eller henvisningsvejledning, fx via information, der også er tilgængelig på sundhed.dk.

Funktionen skal hjælpe henviseren med at finde et relevant tilbud, men den kliniske beslutning om henvisning og valg af tilbud ligger fortsat hos henviseren.

| Element | Beskrivelse |
|---|---|
| Mulige FHIR-ressourcer | `HealthcareService`, `Organization`, `Location`, `Endpoint` samt relevant vejledningsindhold |
| Triggerhændelse | Henviseren har identificeret et behov for specialiseret undersøgelse eller behandling |
| Forrige trin | Klinisk vurdering og beskrivelse af patientens problemstilling |
| Næste trin | → 1.8 Få hjælp til at udfylde henvisningen; → 1.1 Oprette og færdigmelde en henvisning |

### User story 1.8 Få hjælp til at udfylde henvisningen

> **User story:**
>
> Som henviser ønsker jeg hjælp til at udfylde henvisningen med de relevante oplysninger fra henvisningsvejledningen eller patientforløbsbeskrivelsen,
> når jeg har beskrevet grundlaget for henvisningen og patientens symptomer eller problemstillinger,
> så jeg undgår dobbeltarbejde og får medtaget de oplysninger, som modtageren har brug for.

Henviserens system bør kunne vise relevante udfyldningskrav og vejledning i den konkrete henvisningssituation. Oplysninger, som allerede er beskrevet i henviserens notat eller findes andre steder i journalen, bør så vidt muligt kunne genbruges eller foreslås overført til de relevante felter.

Funktionen skal understøtte kvaliteten af henvisningen og reducere behovet for, at modtageren efterfølgende anmoder om supplerende oplysninger.

| Element | Beskrivelse |
|---|---|
| Mulige FHIR-ressourcer | `ServiceRequest` og relevante kliniske ressourcer samt vejledningsindhold |
| Triggerhændelse | Henviseren påbegynder udfyldelse af en henvisning |
| Forrige trin | → 1.7 Finde relevant tilbud og henvisningsvejledning |
| Næste trin | → 1.1 Oprette og færdigmelde en henvisning |

### User story 1.9 Importere oplysninger fra patientjournalen

> **User story:**
>
> Som henviser ønsker jeg at kunne genbruge relevante oplysninger og data fra patientens journal i henvisningen,
> når jeg skal udfylde oplysninger, som allerede findes i journalsystemet,
> så jeg sparer tid og undgår manuel genindtastning og risiko for fejl.

Henviserens system bør kunne hente eller overføre relevante oplysninger fra journalen til henvisningen. Det kan fx være diagnoser, medicinoplysninger, laboratoriesvar, tidligere undersøgelser og relevante kontakter. Henviseren skal kunne kontrollere, hvilke oplysninger der medsendes, og sikre, at de er relevante og aktuelle.

| Element | Beskrivelse |
|---|---|
| Mulige FHIR-ressourcer | `ServiceRequest` samt relevante ressourcer, fx `Condition`, `MedicationStatement`, `Observation`, `DiagnosticReport` og `Encounter` |
| Triggerhændelse | Henviseren udfylder henvisningen med oplysninger, der allerede findes i journalen |
| Forrige trin | → 1.8 Få hjælp til at udfylde henvisningen |
| Næste trin | → 1.1 Oprette og færdigmelde en henvisning; → 1.2 Tilknytte klinisk dokumentation |

### User story 1.10 Se og drøfte et henvisningsudkast

> **User story:**
>
> Som henviser ønsker jeg at kunne give henvisningsmodtageren adgang til at se en henvisning, mens den stadig er under udarbejdelse,
> når jeg har behov for at drøfte henvisningens kliniske indhold,
> så jeg ikke skal kopiere eller gentage tekst, der allerede fremgår af henvisningsudkastet.

Henviser og modtager skal kunne se den relevante version af henvisningsudkastet i forbindelse med en faglig afklaring. Det skal være tydeligt, at henvisningen endnu ikke er færdigmeldt eller afsendt, og at modtageren derfor ikke skal opfatte den som en færdig henvisning til visitation.

**Nyt selvstændigt behov.** Det supplerer den oprindelige dialog-user story 3.3, fordi det specifikt handler om adgang til selve udkastet og ikke kun om udveksling af beskeder.

| Element | Beskrivelse |
|---|---|
| Mulige FHIR-ressourcer | `ServiceRequest`, `Communication` |
| Triggerhændelse | Henviser ønsker at drøfte et udkast med modtageren |
| Forrige trin | → 1.1 Oprette og færdigmelde en henvisning |
| Næste trin | → 3.3 Faglig afklaring i dialog; → 1.1 Færdigmelde henvisningen |

### User story 1.11 Holde henvisningsdialog adskilt fra øvrig korrespondance

> **User story:**
>
> Som henviser ønsker jeg, at skriftlig dialog om en konkret henvisning er tydeligt adskilt fra den øvrige korrespondance i mit journalsystems indbakke,
> når jeg kommunikerer med modtager eller visitator under udfyldelsen eller efter afsendelsen af henvisningen,
> så henvisningsrelaterede beskeder ikke bliver væk i eller forsinkes af anden patientkorrespondance.

Dialogen skal være knyttet til den konkrete henvisning og kunne genfindes i sammenhæng med henvisningsforløbet. Det skal være muligt at skelne mellem henvisningsdialog og øvrig korrespondance om patienten.

**Nyt selvstændigt behov.** Den oprindelige user story 3.3 beskriver den faglige dialog, mens denne user story præciserer behovet for organisatorisk og brugergrænseflademæssig adskillelse i indbakken.

| Element | Beskrivelse |
|---|---|
| Mulige FHIR-ressourcer | `Communication`, `CommunicationRequest`, `ServiceRequest` |
| Triggerhændelse | Der opstår skriftlig dialog om en konkret henvisning |
| Forrige trin | → 1.10 Se og drøfte et henvisningsudkast; → 3.1 Anmode om supplerende oplysninger |
| Næste trin | → 3.2 Besvare anmodning om supplement; → 3.3 Faglig afklaring i dialog |

### User story 1.12 Knytte flere henvisninger sammen og koordinere booking

> **User story:**
>
> Som henviser ønsker jeg at kunne sammenkoble flere henvisninger for samme patient og angive deres indbyrdes rækkefølge eller bookingmæssige sammenhæng,
> når patienten skal henvises til flere specialer eller undersøgelser for samme problemstilling,
> så patientens undersøgelser og konsultationer kan planlægges i den rigtige rækkefølge og om muligt samme dag og samme sted.

Henviseren skal kunne angive, at flere henvisninger vedrører samme problemstilling, og om der er en bestemt rækkefølge eller tidsmæssig sammenhæng mellem de ønskede undersøgelser og kontakter. Det skal også kunne angives, hvis patienten har behov for at få flere kontakter gennemført samme dag og under samme tag, fx af hensyn til transport eller andre praktiske forhold.

Modtagerne skal kunne se sammenhængen, så booking kan koordineres på tværs af relevante enheder. Sammenkoblingen må ikke betyde, at de enkelte henvisningers faglige indhold eller ansvar bliver uklart.

**Nyt selvstændigt behov.** Dette er et udvidet koordineringsbehov, som ikke er dækket af de oprindelige user stories.

| Element | Beskrivelse |
|---|---|
| Mulige FHIR-ressourcer | `ServiceRequest`, `Task`, `Appointment` og relevante relationer mellem henvisninger |
| Triggerhændelse | Patienten skal henvises til flere relaterede undersøgelser eller specialer |
| Forrige trin | → 1.1 Oprette og færdigmelde henvisninger |
| Næste trin | → 2.8 Koordinere sammenhængende henvisninger og bookinger |

## Centralvisitatorens user stories

Disse user stories beskriver den centrale fordelingsfunktion, hvor færdige henvisninger kanaliseres videre til de relevante specialer eller enheder.

### User story 2.11 Få overblik over færdige henvisninger i centralvisitationen

> **User story:**
>
> Som centralvisitator ønsker jeg at få et samlet overblik over færdigmeldte henvisninger, der er adresseret til min henvisningsenhed,
> når jeg skal fordele henvisningerne til relevante specialer eller enheder,
> så færdige henvisninger ikke forsinkes i centralvisitationen.

Centralvisitator skal kunne se de henvisninger, der er færdigmeldt og afventer fordeling. Overblikket skal gøre det muligt at identificere henvisningens destination, relevante oplysninger og eventuelle særlige forhold, fx sammenkædning med andre henvisninger eller behov for koordinering.

Centralvisitator skal kunne kanalisere henvisningen videre til den relevante specialenhed uden at ændre det kliniske indhold eller miste sporbarheden i henvisningsforløbet.

| Element | Beskrivelse |
|---|---|
| Mulige FHIR-ressourcer | `ServiceRequest`, `Task`, `Organization`, `HealthcareService` |
| Triggerhændelse | En henvisning er færdigmeldt og adresseret til en enhed med central visitation |
| Forrige trin | ← 1.1 Oprette og færdigmelde en henvisning |
| Næste trin | → 2.1 Modtage og kvittere for ny henvisning; → 2.2 Triagere og prioritere en henvisning |

## Henvisningsmodtagerens/visitatorens user stories

Disse user stories beskriver modtagerens arbejde med at modtage, vurdere, visitere og planlægge patientens videre forløb.

### User story 2.1 Modtage og kvittere for ny henvisning

> **User story:**
>
> Som henvisningsmodtager ønsker jeg automatisk at modtage og kvittere for indkomne henvisninger via FHIR,
> når en ny færdigmeldt `ServiceRequest` ankommer til mit endpoint,
> så henviseren hurtigt får bekræftet, at henvisningen er modtaget korrekt, og jeg kan påbegynde håndteringen.

Modtageren modtager en FHIR-`Bundle` med henvisningen og tilhørende dokumentation. Systemet sender en teknisk kvittering for modtagelsen. Det skal være muligt at skelne mellem teknisk modtagelse og en faglig accept af henvisningen. En teknisk kvittering betyder således ikke, at henvisningen er visiteret eller accepteret.

Modtageren skal kunne se henvisningen, både når den er færdigmeldt og – hvis der er etableret en dialog om et udkast – når den stadig er under udarbejdelse. Udkast og færdige henvisninger skal fremstå tydeligt forskellige.

**Flettet sammen med:** den oprindelige user story 2.1 *Modtage og kvittere for ny henvisning*. Det nye behov om at kunne se den færdige henvisning er dækket her; adgang til udkast er særskilt beskrevet i 1.10.

| Element | Beskrivelse |
|---|---|
| Primære FHIR-ressourcer | `Bundle`, `MessageHeader`, `ServiceRequest` |
| Triggerhændelse | Færdigmeldt henvisning modtages i FHIR-endpoint |
| Forrige trin | ← 1.1 Oprette og færdigmelde en henvisning; ← 1.2 Tilknytte klinisk dokumentation; ← 2.5 Videresende til anden modtager |
| Næste trin | → 2.2 Triagere og prioritere en henvisning |

### User story 2.2 Triagere og prioritere en henvisning

> **User story:**
>
> Som visitator ønsker jeg at kunne foretage en struktureret triage af en modtaget henvisning og dokumentere mit udfald,
> når en ny eller opdateret henvisning er klar til klinisk vurdering,
> så prioriteringen er sporbar og ensartet, og patienten hurtigst muligt kan komme videre i sit forløb.

Visitatoren vurderer henvisningens faglige indhold, kontrollerer om den er tilstrækkeligt oplyst og klassificerer hastegrad og prioritet. Triage-udfaldet dokumenteres, så det er muligt at følge, hvad der er vurderet, og hvilke beslutninger der er truffet.

Modtageren skal kunne modtage fyldestgørende henvisninger og have adgang til de oplysninger og bilag, der er nødvendige for vurderingen.

| Element | Beskrivelse |
|---|---|
| Primære FHIR-ressourcer | `Task`, `ServiceRequest` |
| Triggerhændelse | Ny eller opdateret henvisning er klar til klinisk vurdering |
| Forrige trin | ← 2.1 Modtage og kvittere for ny henvisning; ← 1.3 Ændre en afsendt eller afvist henvisning; ← 3.2 Besvare anmodning om supplement; ← 3.6 Aftale og gennemføre korrektion |
| Næste trin | → 2.3 Acceptere en henvisning og booke forløb; → 2.4 Afvise en henvisning med begrundelse; → 3.1 Anmode om supplerende oplysninger; → 2.6 Ændre prioritet |

### User story 2.3 Acceptere en henvisning og booke forløb

> **User story:**
>
> Som henvisningsmodtager ønsker jeg at kunne acceptere en henvisning og oprette en booking,
> når min visitationsafgørelse er positiv, og min afdeling skal varetage patientens undersøgelse eller behandling,
> så patientens videre forløb kan planlægges, og henviseren orienteres om, at henvisningen er accepteret.

Visitatoren accepterer henvisningen og opretter eller igangsætter et patientforløb. Accepten skal registreres som en faglig afgørelse, der kan skelnes fra den tekniske modtagelseskvittering. Hvis der bookes en tid, oprettes eller refereres der til en `Appointment`, som knyttes til henvisningen.

Accepten kan være relevant for beregning af frister, herunder eventuelle frister i forbindelse med behandlingsgaranti. Den konkrete startbegivenhed og fristberegning skal fastlægges i de relevante regler og arbejdsgange.

**Flettet sammen med:** den oprindelige user story 2.3 *Acceptere en henvisning og booke forløb*. Det nye behov om eksplicit at kunne angive accept er indarbejdet her.

| Element | Beskrivelse |
|---|---|
| Primære FHIR-ressourcer | `ServiceRequest`, `Task`, `Appointment` |
| Triggerhændelse | Positiv visitationsafgørelse |
| Forrige trin | ← 2.2 Triagere og prioritere en henvisning; ← 3.3 Faglig afklaring i dialog; ← 3.5 Aftale om alternativ visitation |
| Næste trin | → 2.9 Orientere henviser om booking; → 3.4 Statusnotifikation til henviser |

### User story 2.4 Afvise en henvisning med begrundelse

> **User story:**
>
> Som henvisningsmodtager ønsker jeg at kunne afvise en færdig henvisning og angive en tydelig årsag,
> når der mangler nødvendige oplysninger, indikationen ikke er opfyldt, eller min afdeling ikke kan tilbyde den relevante undersøgelse eller behandling,
> så henviseren kan foretage den rette handling, og patienten kan komme videre i sit forløb.

Visitatoren afviser henvisningen og registrerer en begrundelse, der kan forstås og anvendes af henviseren. Afvisningsårsagen bør kunne angives struktureret, eventuelt suppleret med en forklarende tekst. Det skal være tydeligt, om afvisningen skyldes manglende oplysninger, manglende indikation, forkert modtager, kapacitet eller andre forhold.

Afvisningen skal formidles til henviseren, så denne kan vurdere, om henvisningen skal korrigeres, sendes til en anden modtager eller håndteres på anden måde.

**Flettet sammen med:** den oprindelige user story 2.4 *Afvise en henvisning*. De nye behov om at kunne afvise og angive årsagen til afvisningen er indarbejdet her.

| Element | Beskrivelse |
|---|---|
| Primære FHIR-ressourcer | `Task`, `ServiceRequest`, `Communication` |
| Triggerhændelse | Henvisningen kan ikke accepteres på det foreliggende grundlag |
| Forrige trin | ← 2.2 Triagere og prioritere en henvisning; ← 3.3 Faglig afklaring i dialog |
| Næste trin | → 1.6 Modtage afgørelse og status fra visitatoren; → 1.3 Ændre en afsendt eller afvist henvisning; → 3.5 Aftale om alternativ visitation |

### User story 2.5 Videresende til anden modtager

> **User story:**
>
> Som henvisningsmodtager ønsker jeg at kunne videresende en henvisning til en anden relevant modtager,
> når en anden enhed end den oprindeligt angivne skal varetage patientens undersøgelse eller behandling,
> så henvisningen ikke skal retur til henviser alene for at blive sendt videre, og patientens forløb dermed ikke forsinkes unødigt.

Visitatoren vurderer, at henvisningen hører hjemme et andet sted, og videresender den til den relevante modtager. Videresendelsen skal bevare forbindelsen til den oprindelige henvisning og sikre sporbarhed. Den oprindelige henviser orienteres om, hvor henvisningen er sendt hen.

Det skal være tydeligt, hvem der har ansvaret for henvisningen under og efter videresendelsen, og om den oprindelige modtager fortsat har opgaver i forløbet.

**Flettet sammen med:** den oprindelige user story 2.5 *Videresende til anden modtager*. Det nye behov om at kunne se videresendelsen hos henviser er dækket af 1.6.

| Element | Beskrivelse |
|---|---|
| Primære FHIR-ressourcer | `ServiceRequest`, `Task`, `Communication` |
| Triggerhændelse | En anden modtager vurderes at være mere relevant |
| Forrige trin | ← 2.2 Triagere og prioritere en henvisning |
| Næste trin | → 2.1 Modtage og kvittere for ny henvisning hos ny modtager; → 1.6 Modtage afgørelse og status fra visitatoren |

### User story 2.6 Ændre prioritet på en modtaget henvisning

> **User story:**
>
> Som visitator ønsker jeg at kunne justere prioriteten på en allerede modtaget henvisning,
> når ny klinisk information eller en ændret kapacitetssituation tilsiger det,
> så den aktuelle prioritet afspejler patientens behov, og henviseren orienteres om ændringen.

Visitatoren revurderer hastegraden for en modtaget henvisning. Prioriteten opdateres, og henviseren orienteres om ændringen med en reference til den konkrete henvisning og en relevant begrundelse.

| Element | Beskrivelse |
|---|---|
| Primære FHIR-ressourcer | `ServiceRequest`, `Task`, `SubscriptionNotification` |
| Triggerhændelse | Ny information eller ændrede forhold medfører ændret prioritet |
| Forrige trin | ← 2.2 Triagere og prioritere en henvisning |
| Næste trin | → 1.6 Modtage afgørelse og status fra visitatoren |

### User story 2.7 Hente accepteret henvisning og bilag til eget journalsystem

> **User story:**
>
> Som henvisningsmodtager ønsker jeg at kunne hente den accepterede henvisning med tilhørende bilag ind i mit eget journalsystem,
> når min afdeling skal varetage patientens undersøgelse eller behandling,
> så henvisningsoplysningerne kan indgå i afdelingens journalføring og videre behandling i overensstemmelse med gældende regler om henvisning og overdragelse af behandlingsansvar.

Når henvisningen er accepteret, skal modtageren kunne hente eller integrere henvisningens indhold og tilknyttede bilag i eget journalsystem. Det skal være muligt at bevare referencer, proveniens og sammenhæng mellem henvisning og bilag.

| Element | Beskrivelse |
|---|---|
| Primære FHIR-ressourcer | `ServiceRequest`, `DocumentReference`, `Binary` og relevante kliniske ressourcer |
| Triggerhændelse | Henvisningen er accepteret, og modtageren skal varetage patientens forløb |
| Forrige trin | ← 2.3 Acceptere en henvisning og booke forløb |
| Næste trin | Modtagerens interne patientforløb og journalføring |

### User story 2.8 Koordinere sammenhængende henvisninger og bookinger

> **User story:**
>
> Som henvisningsmodtager ønsker jeg at kunne se, om flere henvisninger er knyttet sammen, og om patienten har behov for undersøgelser eller kontakter samme dag og under samme tag,
> når patienten er henvist til flere specialer eller undersøgelser,
> så jeg kan koordinere booking med de øvrige relevante modtagere og tage hensyn til patientens samlede forløb.

Modtageren skal kunne se relationer mellem henvisninger, herunder ønsket rækkefølge, afhængigheder og særlige bookinghensyn. Det skal være muligt at koordinere med andre modtagere, så patienten så vidt muligt får sammenhængende tider og undgår unødige fremmøder.

**Nyt selvstændigt behov.** User story 1.12 beskriver henviserens mulighed for at angive sammenhængen; denne user story beskriver modtagerens mulighed for at anvende oplysningerne i koordineringen.

| Element | Beskrivelse |
|---|---|
| Mulige FHIR-ressourcer | `ServiceRequest`, `Task`, `Appointment` |
| Triggerhændelse | Modtageren modtager en henvisning, der er relateret til andre henvisninger eller bookingbehov |
| Forrige trin | ← 1.12 Knytte flere henvisninger sammen og koordinere booking |
| Næste trin | → 2.3 Acceptere en henvisning og booke forløb; → 2.9 Orientere henviser om booking |

### User story 2.9 Orientere henviser om booking

> **User story:**
>
> Som henvisningsmodtager ønsker jeg at kunne sende besked til henviser, når patienten er booket til en eller flere kontakter,
> når henvisningen er accepteret, og undersøgelse eller behandling er planlagt,
> så henviser er orienteret om, at patientens forløb er kommet videre, og kan informere patienten.

Når der er oprettet en eller flere bookinger på baggrund af henvisningen, skal modtageren kunne orientere henviseren. Meddelelsen skal kunne knyttes til henvisningen og de relevante aftaler. Hvis flere henvisninger er koordineret, skal det fremgå, hvilke bookinger der er etableret.

**Flettet sammen med:** den oprindelige user story 3.4 *Statusnotifikation til henviser*. Den nye bookingorientering er indarbejdet her og i 1.6.

| Element | Beskrivelse |
|---|---|
| Primære FHIR-ressourcer | `Appointment`, `Task`, `SubscriptionNotification`/`Communication` |
| Triggerhændelse | Patienten er booket til en eller flere kontakter |
| Forrige trin | ← 2.3 Acceptere en henvisning og booke forløb; ← 2.8 Koordinere sammenhængende henvisninger og bookinger |
| Næste trin | → 1.6 Modtage afgørelse og status fra visitatoren |

### User story 2.10 Vedligeholde henvisningsvejledninger og patientforløbsbeskrivelser

> **User story:**
>
> Som ansvarlig for en henvisningsmodtagers vejledninger ønsker jeg nemt at kunne oprette og opdatere patientforløbsbeskrivelser og henvisningsvejledninger,
> når der kommer nye eller ændrede oplysninger om henvisningskriterier og tilbud,
> så henviserne altid har adgang til opdateret vejledning.

Den ansvarlige organisation eller faglige enhed skal kunne vedligeholde de oplysninger, som henvisere anvender ved valg af tilbud og udfyldelse af henvisninger. Det skal være tydeligt, hvilken version der er gældende, hvornår den er opdateret, og hvem der er ansvarlig for indholdet.

Vejledningerne bør kunne stilles til rådighed på en måde, så de kan anvendes direkte i henviserens arbejdsgang og knyttes til relevante tilbud og henvisningsmuligheder.

**Nyt selvstændigt behov.** Behovet vedrører vedligeholdelse og publicering af vejledningsindhold og er ikke dækket af de oprindelige transaktionsorienterede user stories.

| Element | Beskrivelse |
|---|---|
| Mulige FHIR-ressourcer | Relevant publicerings-/vejledningsmodel, evt. `PlanDefinition`; tilbud kan beskrives med `HealthcareService` og `Organization` |
| Triggerhændelse | Nye eller ændrede henvisningskriterier, tilbud eller patientforløbsbeskrivelser |
| Forrige trin | Faglig eller organisatorisk beslutning om ændring |
| Næste trin | → 1.7 Finde relevant tilbud og henvisningsvejledning; → 1.8 Få hjælp til at udfylde henvisningen |

## Fælles udvekslingsdialog

Disse user stories forudsætter aktiv kommunikation mellem henviser og visitator via FHIR-baserede meddelelser. Dialogen skal være knyttet til den konkrete henvisning, så parterne kan følge spørgsmål, svar, supplementer og aftaler i sammenhæng.

### User story 3.1 Anmode om supplerende oplysninger

> **User story:**
>
> Som visitator ønsker jeg at kunne sende en struktureret anmodning om supplerende oplysninger til henviseren,
> når grundlaget for triage er utilstrækkeligt,
> så jeg kan træffe en fagligt forsvarlig visitationsafgørelse uden at afvise unødigt.

Visitatoren mangler oplysninger for at kunne triagere og sender en anmodning til henviseren om konkrete kliniske data, fx laboratoriesvar, BMI, medicinliste eller tidligere forløb. Anmodningen skal være knyttet til den oprindelige henvisning og tydeligt angive, hvilke oplysninger der efterspørges.

| Element | Beskrivelse |
|---|---|
| Primære FHIR-ressourcer | `CommunicationRequest`, `ServiceRequest` |
| Triggerhændelse | Utilstrækkeligt grundlag for visitationsafgørelse |
| Forrige trin | ← 2.2 Triagere og prioritere en henvisning |
| Næste trin | → 3.2 Besvare anmodning om supplement |

### User story 3.2 Besvare anmodning om supplement

> **User story:**
>
> Som henviser ønsker jeg at kunne besvare en anmodning om supplerende oplysninger,
> når visitatoren har bedt om yderligere kliniske data,
> så visitatoren hurtigt kan genoptage og afslutte triageprocessen.

Henviseren modtager en anmodning og sender de efterspurgte oplysninger. Svaret skal referere til både anmodningen og den oprindelige henvisning. Hvis de efterspurgte oplysninger allerede findes i journalsystemet, bør de kunne genbruges.

| Element | Beskrivelse |
|---|---|
| Primære FHIR-ressourcer | `Communication`, `ServiceRequest` |
| Triggerhændelse | Modtagelse af `CommunicationRequest` fra visitatoren |
| Forrige trin | ← 3.1 Anmode om supplerende oplysninger |
| Næste trin | → 2.2 Triagere og prioritere en henvisning; → 3.3 Faglig afklaring i dialog |

### User story 3.3 Faglig afklaring i dialog

> **User story:**
>
> Som henviser og visitator ønsker vi begge at kunne føre en struktureret faglig dialog om en konkret henvisning,
> når indikation, egnethed, udfyldelse eller behandlingsvalg er uklart,
> så vi i fællesskab kan nå frem til den rigtige afgørelse for patienten uden at skulle anvende andre kommunikationskanaler.

Henviser og visitator udveksler spørgsmål og svar for at afklare indikation, behandlingsegnethed eller alternativ tilgang. Dialogen kan bestå af flere beskeder og skal kunne følges som en sammenhængende tråd med reference til henvisningen. Dialogen skal kunne foregå, mens henvisningen er under udarbejdelse, og efter at den er afsendt.

**Flettet sammen med:** den oprindelige user story 3.3 *Faglig afklaring i dialog*. De nye behov om hurtig skriftlig dialog mellem henviser og modtager er indarbejdet her. Behovet for at kunne se udkastet og holde dialogen adskilt fra øvrig korrespondance er beskrevet særskilt i 1.10 og 1.11.

| Element | Beskrivelse |
|---|---|
| Primære FHIR-ressourcer | `Communication` (dialogtråd), `ServiceRequest` |
| Triggerhændelse | Faglig uklarhed, der kræver dialog mellem parterne |
| Forrige trin | ← 1.10 Se og drøfte et henvisningsudkast; ← 3.2 Besvare anmodning om supplement |
| Næste trin | → 2.3 Acceptere en henvisning og booke forløb; → 2.4 Afvise en henvisning med begrundelse; → 3.5 Aftale om alternativ visitation |

### User story 3.4 Statusnotifikation til henviser

> **User story:**
>
> Som henviser ønsker jeg automatisk at modtage en notifikation, når status eller afgørelse på en af mine henvisninger ændrer sig hos modtageren,
> når modtageren registrerer en relevant hændelse i henvisningsforløbet,
> så jeg er opdateret uden selv at skulle forespørge aktivt.

Modtageren sender en notifikation ved relevante statusskift, fx modtaget, under vurdering, accepteret, afvist, videresendt eller booket. Notifikationen skal indeholde en reference til den opdaterede henvisning og være tilstrækkelig til, at henviserens system kan vise den relevante hændelse.

**Flettet sammen med:** den oprindelige user story 3.4 *Statusnotifikation til henviser*. De konkrete behov for at se accept, afvisning, videresendelse og booking er samlet i user story 1.6, mens denne user story beskriver selve notifikationsmekanismen.

| Element | Beskrivelse |
|---|---|
| Primære FHIR-ressourcer | `SubscriptionNotification`, `Task`, `ServiceRequest`, evt. `Appointment` |
| Triggerhændelse | Relevant statusændring på en aktiv henvisning |
| Forrige trin | ← 2.3 Acceptere en henvisning; ← 2.4 Afvise en henvisning; ← 2.5 Videresende; ← 2.6 Ændre prioritet; ← 2.9 Orientere henviser om booking |
| Næste trin | → 1.6 Modtage afgørelse og status fra visitatoren |

### User story 3.5 Aftale om alternativ visitation

> **User story:**
>
> Som visitator ønsker jeg at kunne indlede en dialog med henviseren om et alternativt tilbud,
> når jeg ikke kan imødekomme den primære henvisning,
> så patienten ikke ender i en blindgyde, og vi i fællesskab finder en relevant løsning.

Henviser og visitator drøfter et alternativt tilbud, når det primære visitationsspor ikke er muligt. Dialogen foregår med reference til den oprindelige henvisning, og en eventuel aftale om alternativ visitation dokumenteres, så det fremgår, hvad parterne er blevet enige om, og hvordan henvisningen skal håndteres videre.

| Element | Beskrivelse |
|---|---|
| Primære FHIR-ressourcer | `Communication`, `Task`, `ServiceRequest` |
| Triggerhændelse | Det primære tilbud kan ikke imødekommes, og et alternativt tilbud kan være relevant |
| Forrige trin | ← 2.4 Afvise en henvisning med begrundelse; ← 2.5 Videresende til anden modtager |
| Næste trin | → 2.3 Acceptere en henvisning og booke forløb; → 2.5 Videresende til anden modtager; → 1.3 Ændre en afsendt eller afvist henvisning |

### User story 3.6 Aftale og gennemføre korrektion

> **User story:**
>
> Som henviser og visitator ønsker vi at kunne aftale og dokumentere korrektioner til en henvisning,
> når modtageren har identificeret oplysninger, der skal præciseres eller rettes,
> så henvisningen kan bringes i orden uden at miste historik eller sammenhæng i dialogen.

Visitator og henviser afklarer, hvilke oplysninger der skal korrigeres. Henviseren foretager ændringen i henvisningen, og den opdaterede version gøres tilgængelig for modtageren. Det skal være muligt at se sammenhængen mellem den oprindelige henvisning, korrektionen og dialogen, der førte til ændringen.

| Element | Beskrivelse |
|---|---|
| Primære FHIR-ressourcer | `Communication`, `ServiceRequest`, `Task`, evt. `Provenance` |
| Triggerhændelse | Modtageren identificerer behov for korrektion af henvisningen |
| Forrige trin | ← 2.2 Triagere og prioritere en henvisning; ← 3.3 Faglig afklaring i dialog |
| Næste trin | → 1.3 Ændre en afsendt eller afvist henvisning; → 2.2 Triagere og prioritere en henvisning |

## Patientens user stories

Disse user stories beskriver patientens mulighed for at følge sit henvisningsforløb og få indsigt i de oplysninger og beskeder, der vedrører henvisningen. Visningen skal afspejle de rettigheder og adgangsregler, der gælder for patientens oplysninger.

### User story 4.1 Se status på egen henvisning

> **User story:**
>
> Som patient ønsker jeg at kunne se status på min henvisning,
> når en kontakt med min læge har resulteret i opstart af en henvisningsproces,
> så jeg kan holde mig orienteret om henvisningen uden at skulle ringe til min læge.

Patienten skal kunne se relevante og forståelige statusoplysninger om henvisningen, fx at den er oprettet, afsendt, modtaget, under visitation, accepteret, afvist eller videresendt. Statusvisningen skal formidle, hvad status betyder for patienten, og om patienten skal foretage sig noget.

| Element | Beskrivelse |
|---|---|
| Datagrundlag | `ServiceRequest`, `Task` og relevante statusoplysninger |
| Triggerhændelse | Henvisningsprocessen er startet |
| Forrige trin | ← 1.1 Oprette og færdigmelde en henvisning |
| Næste trin | → 4.2 Se egne henvisninger og tilhørende bilag; → 4.3 Se beskeder om bookinger |

### User story 4.2 Se egne henvisninger og tilhørende bilag

> **User story:**
>
> Som patient ønsker jeg at kunne se mine henvisninger med de tilhørende bilag,
> når henvisningen er accepteret og gjort tilgængelig for den relevante modtager,
> så jeg kan få indsigt i de oplysninger, der er sendt videre om mig.

Patienten skal kunne se henvisningens relevante indhold og de bilag, der er knyttet til den, i det omfang patienten har ret til indsigt. Det skal være tydeligt, hvilke oplysninger der er sendt til modtageren, og hvornår de er sendt.

| Element | Beskrivelse |
|---|---|
| Datagrundlag | `ServiceRequest`, `DocumentReference` og relevante dokument-/kliniske ressourcer |
| Triggerhændelse | Henvisningen er accepteret og tilgængelig i patientens visning |
| Forrige trin | ← 2.3 Acceptere en henvisning og booke forløb |
| Næste trin | → 4.3 Se beskeder om bookinger |

### User story 4.3 Se beskeder om bookinger

> **User story:**
>
> Som patient ønsker jeg at kunne se beskeder om bookinger, der er oprettet på baggrund af mine henvisninger,
> når henvisningen er accepteret, og mine kontakter er planlagt,
> så jeg kan sammenholde oplysningerne med mine indkaldelser og få overblik over det videre forløb.

Patienten skal kunne se relevante bookingoplysninger og beskeder om de kontakter, der er planlagt på baggrund af henvisningen. Hvis flere kontakter er koordineret, bør sammenhængen fremgå tydeligt.

| Element | Beskrivelse |
|---|---|
| Datagrundlag | `Appointment` og relevante meddelelser |
| Triggerhændelse | En eller flere kontakter er booket |
| Forrige trin | ← 2.3 Acceptere en henvisning og booke forløb; ← 2.9 Orientere henviser om booking |
| Næste trin | Patienten orienteres om og deltager i det planlagte forløb |

## Administratorens user stories

Disse user stories beskriver behovet for anonymiseret statistik og ledelsesinformation om henvisningsprocesserne. Statistikken skal kunne anvendes til at følge udviklingen, identificere flaskehalse og forbedre kvalitet og effektivitet. Det skal sikres, at data er tilstrækkeligt anonymiserede, og at opgørelserne følger gældende regler og aftalte datadefinitioner.

### User story 5.1 Se anonymiseret statistik om henvisningsforløb

> **User story:**
>
> Som administrator ønsker jeg nem adgang til anonymiseret statistik om henvisningsforløb,
> når jeg skal have overblik over henvisningsprocesserne for en eller flere afsendere eller modtagere,
> så der ikke skal bruges tid på manuel optælling eller manuel fremsøgning af data.

Administratoren skal kunne se aggregerede opgørelser over henvisningsaktivitet for valgte afsendere, modtagere og perioder. Opgørelserne skal baseres på fælles og tydelige definitioner, så de kan sammenlignes.

| Element | Beskrivelse |
|---|---|
| Datagrundlag | Aftalt anonymiseret analyse- og rapporteringsmodel |
| Triggerhændelse | Behov for overblik over henvisningsaktivitet |
| Næste trin | → 5.2 Se anonymiseret statistik om henvisningsstatus |

### User story 5.2 Se anonymiseret statistik om henvisningsstatus

> **User story:**
>
> Som administrator ønsker jeg nem adgang til anonymiseret statistik om henvisningsstatusser,
> når jeg skal have overblik over antal og varighed af henvisninger i forskellige statusser for en eller flere afsendere eller modtagere,
> så jeg kan identificere ophobninger og forsinkelser uden manuel optælling.

Statistikken skal fx kunne vise antal og varighed for henvisninger under udarbejdelse, færdigmeldte, modtagne, under visitation, afviste, videresendte og accepterede. Statusdefinitioner og start-/sluttidspunkter skal være ensartede.

| Element | Beskrivelse |
|---|---|
| Datagrundlag | Aftalt anonymiseret analyse- og rapporteringsmodel med status- og tidsstempler |
| Triggerhændelse | Behov for overblik over fordelingen og varigheden af henvisningsstatusser |
| Forrige trin | ← 5.1 Se anonymiseret statistik om henvisningsforløb |

### User story 5.3 Se anonymiseret statistik om henvisningsdiagnoser

> **User story:**
>
> Som administrator ønsker jeg nem adgang til anonymiseret statistik om henvisningsdiagnoser,
> når jeg skal have overblik over antallet af henvisninger med bestemte diagnoser eller diagnosegrupper for en eller flere afsendere eller modtagere,
> så udviklingen i henvisningsmønstre kan analyseres uden manuel fremsøgning af data.

Statistikken skal kunne opgøres på aftalte diagnosekoder eller diagnosegrupper og kunne afgrænses efter relevante organisatoriske enheder og tidsperioder. Det skal sikres, at små tal og kombinationer ikke medfører risiko for genidentifikation.

| Element | Beskrivelse |
|---|---|
| Datagrundlag | Aftalt anonymiseret analyse- og rapporteringsmodel med diagnoseoplysninger |
| Triggerhændelse | Behov for at analysere henvisningsmønstre fordelt på diagnoser |

### User story 5.4 Se anonymiseret statistik om afvisningsårsager

> **User story:**
>
> Som administrator ønsker jeg nem adgang til anonymiseret statistik om årsager til afviste henvisninger,
> når jeg skal undersøge, om henvisningsprocessen fungerer bedst muligt,
> så jeg kan identificere områder, hvor vejledning, henvisningskriterier eller arbejdsgange bør forbedres.

Statistikken skal kunne vise antal og andele af afvisninger fordelt på aftalte afvisningsårsager, modtagere, afsendere og tidsperioder. Opgørelserne kan anvendes til at identificere tilbagevendende problemer, fx mangelfulde oplysninger eller henvisninger til forkerte tilbud.

| Element | Beskrivelse |
|---|---|
| Datagrundlag | Aftalt anonymiseret analyse- og rapporteringsmodel med strukturerede afvisningsårsager |
| Triggerhændelse | Behov for at analysere afvisninger og forbedringsmuligheder |

### User story 5.5 Se anonymiseret statistik om videresendte henvisninger

> **User story:**
>
> Som administrator ønsker jeg nem adgang til anonymiseret statistik om videresendte henvisninger,
> når jeg skal undersøge, om henvisningsprocessen fungerer bedst muligt,
> så jeg kan identificere uhensigtsmæssige henvisningsveje og forbedre tilbudsbeskrivelser, visitation og arbejdsgange.

Statistikken skal kunne vise antal og andele af videresendte henvisninger, herunder relevante oplysninger om oprindelig og ny modtager, hvor det kan ske anonymiseret og lovligt. Opgørelserne kan anvendes til at identificere områder, hvor henvisningsvejledninger eller visitationspraksis bør justeres.

| Element | Beskrivelse |
|---|---|
| Datagrundlag | Aftalt anonymiseret analyse- og rapporteringsmodel med oplysninger om videresendelser |
| Triggerhændelse | Behov for at analysere videresendelser og forbedringsmuligheder |

## Tværgående opmærksomhedspunkter til den videre modellering

User stories beskriver behov og arbejdsgange. De fastlægger ikke alene den endelige FHIR-løsning. Følgende emner bør derfor behandles på tværs af user stories:

1. **Henvisningens livscyklus og statusmodel:** Der skal skelnes klart mellem kladde/udkast, færdigmeldt, teknisk afsendt, teknisk modtaget, under visitation, accepteret, afvist, videresendt, tilbagekaldt og booket. De konkrete statusværdier og deres betydning skal fastlægges.
2. **Teknisk kvittering kontra faglig afgørelse:** En teknisk modtagelseskvittering må ikke kunne forveksles med accept af henvisningen eller med, at patienten er tilbudt en tid.
3. **Identitet og versionsstyring:** Det skal være muligt at identificere henvisningen entydigt gennem hele forløbet og skelne mellem henvisningens indhold, versioner, bilag og eventuelle meddelelser omkring henvisningen.
4. **Dialog og korrektion:** Spørgsmål, svar, supplementer og aftaler skal kunne knyttes til den konkrete henvisning. Det skal afklares, hvornår en korrektion opdaterer en eksisterende henvisning, og hvornår der er tale om en ny eller erstattende henvisning.
5. **Videresendelse og ansvar:** Det skal være tydeligt, hvem der har ansvar for henvisningen på hvert trin, hvordan den oprindelige henviser orienteres, og hvordan sporbarhed bevares ved videresendelse.
6. **Bilag og kliniske data:** Det skal afklares, hvilke oplysninger der indlejres, hvilke der refereres, hvordan adgang sikres, og hvordan modtageren kan hente dokumentation til eget journalsystem.
7. **Sammenhængende henvisninger og booking:** Der er behov for en eksplicit model for relationer mellem henvisninger, rækkefølge, afhængigheder og bookinghensyn som fx samme dag og samme sted.
8. **Patientindsigt:** Det skal afklares, hvilke statusoplysninger, henvisningsoplysninger, bilag og bookingbeskeder patienten kan se, og hvornår de bliver tilgængelige.
9. **Vejledninger og tilbud:** Der bør være en vedligeholdelses- og publiceringsproces for henvisningsvejledninger og patientforløbsbeskrivelser, så henviserens søgning og udfyldningsstøtte bygger på opdaterede oplysninger.
10. **Statistik og datakvalitet:** Statusser, afvisningsårsager, videresendelser, tidsstempler og diagnoseoplysninger skal defineres konsistent, hvis der skal kunne etableres retvisende og sammenlignelig statistik.
11. **Adgang, samtykke og audit:** Adgang til kladder, henvisninger, bilag og dialog skal baseres på relevante autorisationer og gældende regler. Adgang og ændringer skal kunne spores.
12. **FHIR-profilering:** Ressourcevalgene i oversigten er foreløbige. Det skal i den videre profilering fastlægges, hvordan fx `ServiceRequest`, `Task`, `Communication`, `CommunicationRequest`, `Appointment`, `DocumentReference` og `SubscriptionNotification` konkret anvendes og forbindes.

## Markering af sammenlægninger

Følgende sammenlægninger er foretaget for at undgå parallelle user stories, der beskriver samme grundlæggende funktion:

| Nye behov | Indarbejdet i |
|---|---|
| Henviser kan henvise digitalt og færdigmelde henvisningen | 1.1 Oprette og færdigmelde en henvisning |
| Ensartet national henvisningsproces | 1.1 Oprette og færdigmelde en henvisning |
| Vedhæfte særskilte filer | 1.2 Tilknytte klinisk dokumentation og bilag |
| Tilrette en afvist henvisning og færdigmelde igen | 1.3 Ændre en afsendt eller afvist henvisning |
| Se status, accept, afvisning, afvisningsårsag, videresendelse og booking | 1.5 og 1.6 |
| Modtage og se færdig henvisning | 2.1 Modtage og kvittere for ny henvisning |
| Afvise henvisning og angive årsag | 2.4 Afvise en henvisning med begrundelse |
| Angive at henvisningen er accepteret | 2.3 Acceptere en henvisning og booke forløb |
| Videresende henvisning til anden modtager | 2.5 Videresende til anden modtager |
| Hente accepteret henvisning med bilag | 2.7 Hente accepteret henvisning og bilag |
| Besked til henviser ved booking | 2.9 og 1.6 |
| Hurtig skriftlig faglig dialog | 3.3 Faglig afklaring i dialog |

Følgende behov er bevaret som selvstændige user stories, fordi de tilfører særskilt funktionalitet eller en anden aktørs arbejdsgang:

- 1.7 Finde relevant tilbud og henvisningsvejledning.
- 1.8 Få hjælp til at udfylde henvisningen.
- 1.9 Importere oplysninger fra patientjournalen.
- 1.10 Se og drøfte et henvisningsudkast.
- 1.11 Holde henvisningsdialog adskilt fra øvrig korrespondance.
- 1.12 Knytte flere henvisninger sammen og koordinere booking.
- 2.8 Koordinere sammenhængende henvisninger og bookinger.
- 2.10 Vedligeholde henvisningsvejledninger og patientforløbsbeskrivelser.
- 2.11 Få overblik over færdige henvisninger i centralvisitationen.
- 4.1–4.3 Patientens indblik i henvisningsstatus, henvisninger, bilag og bookinger.
- 5.1–5.5 Anonymiseret statistik til administrator.

---

## Diagrammer og videre anvendelse

De oprindelige user stories var knyttet til PlantUML-diagrammer i filen `fhir-henvisning-use-cases-claude2.puml`. Denne udvidede version indeholder nye og ændrede user stories, og diagrammerne bør derfor gennemgås og opdateres tilsvarende. Det anbefales at bevare en-til-en-sammenhæng mellem de endelige user story-ID'er og diagrammernes navne, så det er let at navigere mellem behov, arbejdsgange og FHIR-modellering.
